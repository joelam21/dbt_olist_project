-- File: models/intermediate/int_zipcode_geolocation.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches zipcode geolocation data for downstream use.
-- Note: Add further notes on business logic or data handling as needed.
with stg_geolocation as (
select
    zip_code
    , lat
    , lng
    , 
    md5(
        cast(zip_code as string)
    )
 as geolocation_key
from dbt_olist_project.DBT_DEV.stg_geolocation
)

    select
        zip_code
        , 
    md5(
        cast(zip_code as string)
    )
 as geolocation_key
        , avg(lat) as lat
        , avg(lng) as lng
    from stg_geolocation
    group by zip_code