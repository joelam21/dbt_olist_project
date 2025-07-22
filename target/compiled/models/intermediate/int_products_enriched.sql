-- File: models/intermediate/int_products_enriched.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches product data with additional attributes and prepares for downstream modeling.
with products as (
    select
        product_id
        , category_name
        , name_length
        , description_length
        , photos_qty
        , weight_g
        , length_cm
        , height_cm
        , width_cm
    from dbt_olist_project.DBT_DEV.stg_products
)

, category as (
    select
        product_category_name
        , category
        , subcategory
    from dbt_olist_project.DBT_DEV.stg_category_enriched
)

select
    p.product_id
    , p.category_name
    , c.category
    , c.subcategory
    , p.name_length
    , p.description_length
    , p.photos_qty
    , p.weight_g
    , p.length_cm
    , p.height_cm
    , p.width_cm
from products as p
left join category as c
    on p.category_name = c.product_category_name