-- File: models/marts/dimensions/dim_customers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Dimension table for customers, enriched with geolocation data for analytics and reporting.
-- Note: Joins customer attributes with zipcode geolocation for downstream marts and reporting.
with base as (
    select
        customer_id as customer_order_id
        , customer_unique_id as customer_id
        , customer_zip_code
        , customer_city
        , customer_state
    from dbt_olist_project.dbt_prod.stg_customers
)

select
    b.customer_order_id
    , b.customer_id
    , b.customer_zip_code
    , b.customer_city
    , b.customer_state
    , g.lat as customer_lat
    , g.lng as customer_lng
from base as b
left join dbt_olist_project.dbt_prod.int_zipcode_geolocation as g
    on b.customer_zip_code = g.zip_code