
  create or replace   view dbt_olist_project.dbt_prod.stg_orders
  
  
  
  
  as (
    -- File: models/staging/stg_orders.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages orders data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: order_id

with source as (
    select * from dbt_olist_project.raw.orders
)

, stg_orders as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
    from source
)

select *
from stg_orders
  );

