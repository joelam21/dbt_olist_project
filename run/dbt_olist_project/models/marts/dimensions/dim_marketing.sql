
  create or replace   view dbt_olist_project.dbt_prod.dim_marketing
  
  
  
  
  as (
    -- File: models/marts/dimensions/dim_marketing.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Marketing dimension table, combining MQL and closed deals attributes for analytics and segmentation.
-- Note: Includes both not-null MQL fields and nullable closed deal fields for comprehensive marketing analysis.
select
    mql_id
    , first_contact_date
    , landing_page_id
    , origin
    , channel
    -- closed deals, many nulls
    , seller_id
    , sdr_id
    , sr_id
    , business_segment
    , lead_type
    , lead_behaviour_profile
    , has_company
    , has_gtin
    , average_stock
    , business_type
from dbt_olist_project.dbt_prod.int_closed_deals_enriched
  );

