-- File: models/staging/stg_order_items.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages order items data from the raw layer,
--          generating a surrogate key for uniqueness and
--          preparing for downstream modeling.
-- Note: Uses the generate_surrogate_key macro to ensure unique order item keys.
-- Primary key: order_item_key (generated from order_id, order_item_id)

with source as (
    select *
    from {{ source('raw', 'order_items') }}
)

, stg_order_items as (
    select
        {{ generate_surrogate_key(['order_id', 'order_item_id']) }} as order_item_key
        , order_id
        , order_item_id
        , product_id
        , seller_id
        , shipping_limit_date
        , price
        , freight_value
    from source
)

select *
from stg_order_items
