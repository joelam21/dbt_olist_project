-- File: models/staging/stg_products.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages products data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: product_id

with source as (
    select * from {{ ref('products') }}
)

, stg_products as (
    select
        product_id
        , product_category_name as category_name
        , product_name_lenght as name_length
        , product_description_lenght as description_length
        , product_photos_qty as photos_qty
        , product_weight_g as weight_g
        , product_length_cm as length_cm
        , product_height_cm as height_cm
        , product_width_cm as width_cm
    from source
)

select *
from stg_products
