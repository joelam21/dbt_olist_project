-- File: models/staging/stg_geolocation.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages geolocation data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: (zip_code, lat, lng, city, state) | surrogate key: geolocation_key

with source as (
    select *
    from {{ source('raw', 'geolocation') }}
)

, stg_geolocation as (
    select
        {{ generate_surrogate_key([
        pad_zip('geolocation_zip_code_prefix'),
        'geolocation_lat',
        'geolocation_lng',
        'geolocation_city',
        'geolocation_state']) }} as geolocation_key
        , {{ pad_zip('geolocation_zip_code_prefix') }} as zip_code
        , geolocation_lat as lat
        , geolocation_lng as lng
        , geolocation_city as city
        , geolocation_state as state
    from source
    group by
          {{ pad_zip('geolocation_zip_code_prefix') }}
        , geolocation_lat
        , geolocation_lng
        , geolocation_city
        , geolocation_state
)

select *
from stg_geolocation
