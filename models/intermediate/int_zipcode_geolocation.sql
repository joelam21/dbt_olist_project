-- File: models/intermediate/int_zipcode_geolocation.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches zipcode geolocation data for downstream use.
with stg_geolocation as (
select
    zip_code
    , lat
    , lng
    , {{ generate_surrogate_key(['zip_code']) }} as geolocation_key
from {{ ref('stg_geolocation') }}
)

    select
        zip_code
        , {{ generate_surrogate_key(['zip_code']) }} as geolocation_key
        , avg(lat) as lat
        , avg(lng) as lng
    from stg_geolocation
    group by zip_code
