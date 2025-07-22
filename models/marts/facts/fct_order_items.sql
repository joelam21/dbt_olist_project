-- Fact table for order items with enriched order and product details
select
    order_item_key
    , order_item_id
    , order_id
    , product_id
    , seller_id
    , customer_id as customer_order_id  -- consistent with other fact tables
    -- Order dates
    , order_purchase_timestamp
    , order_approved_at
    , order_delivered_carrier_date
    , order_delivered_customer_date
    , order_estimated_delivery_date
    , order_status
    -- Item details
    , shipping_limit_date
    , price
    , freight_value
    , item_total_value
from {{ ref('int_order_items') }}
