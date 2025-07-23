-- File: models/staging/stg_closed_deals.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages closed deals data from the raw layer, standardizing booleans and preparing for downstream modeling.
-- Note: coalesce is used to ensure boolean fields are never null.

with source as (
    select *
    from dbt_olist_project.raw.closed_deals
)

, stg_closed_deals as (
    select
        mql_id
        , seller_id
        , sdr_id
        , sr_id
        , won_date
        , business_segment
        , lead_type
        , lead_behaviour_profile
        , average_stock
        , business_type
        , declared_product_catalog_size
        , declared_monthly_revenue
        , coalesce(has_company, false) as has_company  -- ensure boolean, never null
        , coalesce(has_gtin, false) as has_gtin        -- ensure boolean, never null
    from source
)

select *
from stg_closed_deals