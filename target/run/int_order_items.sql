
  create or replace   view dbt_olist_project.DBT_DEV.int_order_items
  
   as (
    -- File: models/intermediate/int_order_items.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches order items data and prepares for downstream modeling.
-- Note: Add further notes on business logic or data handling as needed.
with order_items as (
    select
        order_item_key
        , order_id
        , order_item_id
        , product_id
        , seller_id
        , shipping_limit_date
        , price
        , freight_value
    from dbt_olist_project.DBT_DEV.stg_order_items
)

, orders as (
    select
        order_id
        , customer_id
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , order_status
    from dbt_olist_project.DBT_DEV.stg_orders
)

, final as (
    select
        order_items.order_item_key
        , order_items.order_id
        , order_items.order_item_id
        , order_items.product_id
        , order_items.seller_id
        , orders.customer_id
        , orders.order_purchase_timestamp
        , orders.order_approved_at
        , orders.order_delivered_carrier_date
        , orders.order_delivered_customer_date
        , orders.order_estimated_delivery_date
        , order_items.shipping_limit_date
        , order_items.price
        , order_items.freight_value
        , coalesce(orders.order_status, 'no_status') as order_status
        , coalesce(order_items.price, 0) + coalesce(order_items.freight_value, 0) as item_total_value
    from order_items
    left join orders
        on order_items.order_id = orders.order_id
)

select
    order_item_key
    , order_id
    , order_item_id
    , product_id
    , seller_id
    , customer_id
    , order_purchase_timestamp
    , order_approved_at
    , order_delivered_carrier_date
    , order_delivered_customer_date
    , order_estimated_delivery_date
    , order_status
    , shipping_limit_date
    , price
    , freight_value
    , item_total_value
from final
  );

