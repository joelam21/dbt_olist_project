-- File: models/marts/dimensions/dim_products.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Product dimension table for analytics, providing product attributes and derived fields for reporting.
-- Note: Sourced from int_products_enriched for standardized and enriched product data.

select
    product_id
    , category
    , subcategory
    , name_length
    , description_length
    , photos_qty
    , weight_g
    , length_cm
    , height_cm
    , width_cm
from {{ ref('int_products_enriched') }}
