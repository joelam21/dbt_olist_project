-- File: models/intermediate/int_orders_fulfillment.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates fulfillment status and related metrics for each order.

with int_orders_fulfillment_metrics as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , delivery_window_days
        , days_to_approve
        , days_to_carrier
        , days_to_customer
        , delivery_days
        , delivered_on_time
    from dbt_olist_project.DBT_DEV.int_orders_fulfillment_metrics
)

, int_orders_fulfillment_benchmarks as (
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
        , sla_days_to_last_mile
        , approval_sla_breached
        , carrier_sla_breached
        , last_mile_sla_breached
        , fulfillment_delay_summary
    from dbt_olist_project.DBT_DEV.int_orders_fulfillment_benchmarks
)

    select
        int_orders_fulfillment_metrics.order_id
        , int_orders_fulfillment_metrics.customer_id
        , int_orders_fulfillment_metrics.order_status
        , int_orders_fulfillment_metrics.order_purchase_timestamp
        , int_orders_fulfillment_metrics.order_approved_at
        , int_orders_fulfillment_metrics.order_delivered_carrier_date
        , int_orders_fulfillment_metrics.order_delivered_customer_date
        , int_orders_fulfillment_metrics.order_estimated_delivery_date
        , int_orders_fulfillment_metrics.delivery_window_days
        , int_orders_fulfillment_metrics.days_to_approve
        , int_orders_fulfillment_metrics.days_to_carrier
        , int_orders_fulfillment_metrics.days_to_customer
        , int_orders_fulfillment_metrics.delivery_days
        , int_orders_fulfillment_metrics.delivered_on_time
        , int_orders_fulfillment_benchmarks.sla_days_to_approve
        , int_orders_fulfillment_benchmarks.sla_days_to_carrier
        , int_orders_fulfillment_benchmarks.sla_days_to_last_mile
        , int_orders_fulfillment_benchmarks.approval_sla_breached
        , int_orders_fulfillment_benchmarks.carrier_sla_breached
        , int_orders_fulfillment_benchmarks.last_mile_sla_breached
        , int_orders_fulfillment_benchmarks.fulfillment_delay_summary
    from int_orders_fulfillment_metrics
    left join int_orders_fulfillment_benchmarks
    on int_orders_fulfillment_metrics.order_id = int_orders_fulfillment_benchmarks.order_id