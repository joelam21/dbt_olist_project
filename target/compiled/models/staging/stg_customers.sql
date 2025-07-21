-- File: models/staging/stg_customers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages customer data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: customer_id

with source as (
    select *
    from dbt_olist_project.raw.customers
)

, stg_customers as (
    select
        customer_id
        , customer_unique_id
        , 
    lpad(cast(customer_zip_code_prefix as string), 5, '0')
 as customer_zip_code
        , customer_city
        , customer_state
    from source
)

select *
from stg_customers