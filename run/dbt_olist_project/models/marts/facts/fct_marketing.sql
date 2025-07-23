
  create or replace   view dbt_olist_project.dbt_prod.fct_marketing
  
  
  
  
  as (
    -- File: models/marts/facts/fct_marketing.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Marketing fact table for analytics, tracking MQLs, sellers, and deal outcomes.
-- Note: Calculates is_won flag based on presence of won_date for downstream reporting.

select
    mql_id
    , seller_id
    , cast(won_date as date) as won_date
    , (won_date is not null) as is_won
from dbt_olist_project.dbt_prod.int_closed_deals_enriched
  );

