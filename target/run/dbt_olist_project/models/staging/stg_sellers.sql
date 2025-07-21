
  create or replace   view dbt_olist_project.DBT_DEV.stg_sellers
  
  
  
  
  as (
    -- File: models/staging/stg_sellers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages sellers data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: seller_id

with source as (
    select *
    from dbt_olist_project.raw.sellers
)

, stg_sellers as (
    select
        seller_id
        , 
    lpad(cast(seller_zip_code_prefix as string), 5, '0')
 as seller_zip_code
        , seller_city
        , seller_state
    from source
)

select *
from stg_sellers
  );

