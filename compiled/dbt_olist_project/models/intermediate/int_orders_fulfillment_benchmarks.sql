-- File: models/intermediate/int_orders_fulfillment_benchmarks.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates fulfillment SLA breaches and delay summaries for each order.
-- Note: Add further notes on business logic or data handling as needed.
--
-- int_orders_fulfillment_benchmarks.sql
-- Calculates fulfillment SLA breaches and delay summaries for each order.
-- Modular CTE structure for maintainability and interpretability.
--

-- CTE: fulfillment
-- Pulls detailed fulfillment event metrics for each order from the intermediate model.
with fulfillment as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , as_of_date
        , delivery_window_days
        , delivery_days
        , days_to_approve
        , days_to_carrier
        , days_to_customer
        , delivered_on_time
    from dbt_olist_project.dbt_prod.int_orders_fulfillment_metrics
)

-- CTE: sla_thresholds
-- Loads SLA thresholds for each fulfillment stage (approve, carrier) with effective dates.
, sla_thresholds as (
    select
        sla_type
        , threshold_days
        , effective_start_date
        , effective_end_date
    from dbt_olist_project.dbt_prod.sla_thresholds
)

-- CTE: fulfillment_with_sla
-- Joins fulfillment events to SLA thresholds to annotate each order with the correct SLA for each stage.
, fulfillment_with_sla as (
    select
        f.order_id
        , f.customer_id
        , f.order_status
        , f.order_purchase_timestamp
        , f.order_approved_at
        , f.order_delivered_carrier_date
        , f.order_delivered_customer_date
        , f.order_estimated_delivery_date
        , f.as_of_date
        , f.delivery_window_days
        , f.delivery_days
        , f.days_to_approve
        , f.days_to_carrier
        , f.days_to_customer
        , f.delivered_on_time
        , sa.threshold_days as sla_days_to_approve
        , sc.threshold_days as sla_days_to_carrier
    from fulfillment as f
    left join sla_thresholds as sa
        on sa.sla_type = 'approve'
        and f.order_purchase_timestamp >= sa.effective_start_date
        and f.order_purchase_timestamp < sa.effective_end_date
    left join sla_thresholds as sc
        on sc.sla_type = 'carrier'
        and f.order_purchase_timestamp >= sc.effective_start_date
        and f.order_purchase_timestamp < sc.effective_end_date
)

-- Final select: Calculate SLA breaches and fulfillment delay summary for each order.
select
    order_id
    , customer_id
    , order_status
    , order_purchase_timestamp
    , order_approved_at
    , order_delivered_carrier_date
    , order_delivered_customer_date
    , order_estimated_delivery_date
    , as_of_date
    , delivery_window_days
    , delivery_days
    , days_to_approve
    , days_to_carrier
    , days_to_customer
    , delivered_on_time
    , sla_days_to_approve
    , sla_days_to_carrier
    , (delivery_window_days - sla_days_to_approve - sla_days_to_carrier) as sla_days_to_last_mile -- SLA for last mile = total window - other SLAs
    , coalesce(days_to_approve > sla_days_to_approve, false) as approval_sla_breached -- Breach if approval took too long
    , coalesce(days_to_carrier > sla_days_to_carrier, false) as carrier_sla_breached -- Breach if carrier handoff took too long
    , coalesce(days_to_customer > (delivery_window_days - sla_days_to_approve - sla_days_to_carrier), false) as last_mile_sla_breached -- Breach if last mile took too long
    , case
        when order_status = 'canceled' then 'canceled'
        when order_status != 'delivered' and as_of_date <= order_estimated_delivery_date then 'in progress'
        when order_status != 'delivered' and as_of_date > order_estimated_delivery_date then 'not delivered'
        when delivered_on_time = true then 'on time'
        else
            ltrim(
                coalesce(case when days_to_approve > sla_days_to_approve then 'approval' end, '')
                || coalesce(case when days_to_carrier > sla_days_to_carrier then ', carrier' end, '')
                || coalesce(case when days_to_customer > (delivery_window_days - sla_days_to_approve - sla_days_to_carrier) then ', last mile' end, '')
                , ', '
            )
    end as fulfillment_delay_summary -- Text summary of which stages breached SLA
from fulfillment_with_sla