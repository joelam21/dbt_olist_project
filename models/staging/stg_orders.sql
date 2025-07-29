-- File: models/staging/stg_orders.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages orders data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: order_id

with source as (
    select * from {{ ref('orders') }}
)

, stg_orders as (
    select
        order_id
        , customer_id
        , order_status
        , cast(order_purchase_timestamp as timestamp) as order_purchase_timestamp
        , cast(order_approved_at as timestamp) as order_approved_at
        , cast(order_delivered_carrier_date as timestamp) as order_delivered_carrier_date
        , cast(order_delivered_customer_date as timestamp) as order_delivered_customer_date
        , cast(order_estimated_delivery_date as timestamp) as order_estimated_delivery_date
    from source
)

select *
from stg_orders
