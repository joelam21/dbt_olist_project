-- File: models/staging/stg_customers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages customer data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: customer_id

with source as (
    select
        customer_id
        , customer_unique_id
        , customer_zip_code_prefix
        , customer_city
        , customer_state
    from {{ ref('customers') }}
)

, stg_customers as (
    select
        customer_id
        , customer_unique_id
        , {{ pad_zip('customer_zip_code_prefix') }} as customer_zip_code
        , customer_city
        , customer_state
    from source
)

select *
from stg_customers
