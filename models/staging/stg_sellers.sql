-- File: models/staging/stg_sellers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages sellers data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: seller_id

with source as (
    select *
    from {{ source('raw', 'sellers') }}
)

, stg_sellers as (
    select
        seller_id
        , {{ pad_zip('seller_zip_code_prefix') }} as seller_zip_code
        , seller_city
        , seller_state
    from source
)

select *
from stg_sellers
