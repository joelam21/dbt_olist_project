
  create or replace   view dbt_olist_project.dbt_prod.fct_order_items
  
  
  
  
  as (
    -- File: models/marts/facts/fct_order_items.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Fact table for order items, enriched with order and product details for analytics and reporting.
-- Note: Sourced from int_order_items for standardized and enriched item-level data.
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
from dbt_olist_project.dbt_prod.int_order_items
  );

