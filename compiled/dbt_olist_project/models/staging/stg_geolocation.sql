-- File: models/staging/stg_geolocation.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages geolocation data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: (zip_code, lat, lng, city, state) | surrogate key: geolocation_key

with source as (
    select *
    from dbt_olist_project.raw.geolocation
)

, stg_geolocation as (
    select
        
    md5(
        cast(
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')
 as string) || '|' || cast(geolocation_lat as string) || '|' || cast(geolocation_lng as string) || '|' || cast(geolocation_city as string) || '|' || cast(geolocation_state as string)
    )
 as geolocation_key
        , 
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')
 as zip_code
        , geolocation_lat as lat
        , geolocation_lng as lng
        , geolocation_city as city
        , geolocation_state as state
    from source
    group by
          
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')

        , geolocation_lat
        , geolocation_lng
        , geolocation_city
        , geolocation_state
)

select *
from stg_geolocation