-- File: models/intermediate/int_orders_fulfillment_metrics.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates fulfillment event metrics for each order.
with max_data_date as (
    select max(order_estimated_delivery_date) as as_of_date
    from {{ ref('stg_orders') }}
)

, orders as (
    select
        o.order_id
        , o.customer_id
        , o.order_status
        , o.order_purchase_timestamp
        , o.order_approved_at
        , o.order_delivered_carrier_date
        , o.order_delivered_customer_date
        , o.order_estimated_delivery_date
        , m.as_of_date
    from {{ ref('stg_orders') }} as o
    cross join max_data_date as m
)

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
        , datediff(day, order_purchase_timestamp, order_estimated_delivery_date) as delivery_window_days -- Total allowed delivery window
        , datediff(day, order_purchase_timestamp, order_delivered_customer_date) as delivery_days -- Actual days from purchase to delivery
        , datediff(day, order_purchase_timestamp, order_approved_at) as days_to_approve -- Days from purchase to approval
        , datediff(day, order_approved_at, order_delivered_carrier_date) as days_to_carrier -- Days from approval to carrier handoff
        , datediff(day, order_delivered_carrier_date, order_delivered_customer_date) as days_to_customer -- Days from carrier handoff to customer delivery
        , case
            when order_status = 'canceled' then null -- No on-time flag for canceled orders
            when order_status = 'delivered' and date_trunc('day', order_delivered_customer_date) <= order_estimated_delivery_date then true -- Delivered on or before estimated date
            when order_status = 'delivered' and date_trunc('day', order_delivered_customer_date) > order_estimated_delivery_date then false -- Delivered late
            when order_status != 'delivered' and as_of_date > order_estimated_delivery_date then false -- Not delivered and window expired -- Still in progress or insufficient data
        end as delivered_on_time -- Boolean flag for on-time delivery
    from orders
