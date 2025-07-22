-- File: models/marts/fct_orders.sql


with orders as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
    from dbt_olist_project.DBT_DEV.stg_orders
)

, order_metrics as (
    select
        order_id
        , num_items
        , price_total
        , freight_total
        , order_total
    from dbt_olist_project.DBT_DEV.int_orders_metrics
)

, reviews as (
    select
        order_id
        , max(review_score) as review_score  -- pick highest score in case of duplicates
    from dbt_olist_project.DBT_DEV.stg_order_reviews
    group by order_id
)

, fulfillment as (
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
        , sla_days_to_approve
        , sla_days_to_carrier
        , sla_days_to_last_mile
        , approval_sla_breached
        , carrier_sla_breached
        , last_mile_sla_breached
        , fulfillment_delay_summary
    from dbt_olist_project.DBT_DEV.int_orders_fulfillment
)

    select
        orders.order_id
        , orders.customer_id as customer_order_id  -- used as FK in facts
        , orders.order_status
        , orders.order_purchase_timestamp
        -- Fulfillment
        , fulfillment.order_approved_at
        , fulfillment.order_delivered_carrier_date
        , fulfillment.order_delivered_customer_date
        , fulfillment.order_estimated_delivery_date
        , fulfillment.days_to_approve
        , fulfillment.days_to_carrier
        , fulfillment.days_to_customer
        , fulfillment.sla_days_to_approve
        , fulfillment.sla_days_to_carrier
        , fulfillment.sla_days_to_last_mile
        , fulfillment.delivery_window_days
        , fulfillment.delivery_days
        , fulfillment.delivered_on_time
        , fulfillment.approval_sla_breached
        , fulfillment.carrier_sla_breached
        , fulfillment.last_mile_sla_breached
        , fulfillment.fulfillment_delay_summary
        -- Review
        , reviews.review_score
        -- Order metrics
        , order_metrics.num_items
        , order_metrics.price_total
        , order_metrics.freight_total
        , order_metrics.order_total
    from orders
        left join order_metrics on orders.order_id = order_metrics.order_id
        left join reviews on orders.order_id = reviews.order_id
        left join fulfillment on orders.order_id = fulfillment.order_id