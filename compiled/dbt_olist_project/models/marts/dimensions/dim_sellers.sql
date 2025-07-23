-- File: models/marts/dimensions/dim_sellers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Seller dimension table for analytics, enriched with geolocation data for reporting and analysis.
-- Note: Joins seller attributes with zipcode geolocation for downstream marts and reporting.
with base as (
    select
        seller_id
        , seller_zip_code
        , seller_city
        , seller_state
    from dbt_olist_project.dbt_prod.stg_sellers
)
select
    b.seller_id
    , b.seller_zip_code
    , b.seller_city
    , b.seller_state
    , g.lat as seller_lat
    , g.lng as seller_lng
from base as b
left join dbt_olist_project.dbt_prod.int_zipcode_geolocation as g
    on b.seller_zip_code = g.zip_code