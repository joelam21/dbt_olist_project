-- File: models/intermediate/int_closed_deals_enriched.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches closed deals data with additional attributes and prepares for downstream modeling.
with mql as (
    select
        mql_id
        , first_contact_date
        , landing_page_id
        , origin
        , channel
    from dbt_olist_project.dbt_prod.int_marketing_qualified_leads
)

, closed_deals as (
    select
        seller_id
        , sdr_id
        , sr_id
        , won_date
        , business_segment
        , lead_type
        , lead_behaviour_profile
        , has_company
        , has_gtin
        , average_stock
        , business_type
        , declared_product_catalog_size
        , declared_monthly_revenue
        , mql_id
    from dbt_olist_project.dbt_prod.stg_closed_deals
)

, sellers as (
    select
        seller_id
        , seller_city
        , seller_state
        , seller_zip_code
    from dbt_olist_project.dbt_prod.stg_sellers
)

select
    mql.mql_id
    , mql.first_contact_date
    , mql.landing_page_id
    , mql.origin
    , mql.channel
    , closed_deals.seller_id
    , closed_deals.sdr_id
    , closed_deals.sr_id
    , closed_deals.won_date
    , closed_deals.business_segment
    , closed_deals.lead_type
    , closed_deals.lead_behaviour_profile
    , closed_deals.has_company
    , closed_deals.has_gtin
    , closed_deals.average_stock
    , closed_deals.business_type
    , closed_deals.declared_product_catalog_size
    , closed_deals.declared_monthly_revenue
    , sellers.seller_city
    , sellers.seller_state
    , sellers.seller_zip_code
    , coalesce(closed_deals.has_company, false) as has_company_flag
    , coalesce(closed_deals.has_gtin, false) as has_gtin_flag
from mql
left join closed_deals
    on mql.mql_id = closed_deals.mql_id
left join sellers
    on closed_deals.seller_id = sellers.seller_id