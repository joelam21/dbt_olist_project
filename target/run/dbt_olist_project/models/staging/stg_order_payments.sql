
  create or replace   view dbt_olist_project.DBT_DEV.stg_order_payments
  
  
  
  
  as (
    -- File: models/staging/stg_order_payments.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages order payments data from the raw layer,
--          generating a surrogate key for uniqueness and
--          preparing for downstream modeling.
-- Note: Uses the generate_surrogate_key macro to ensure unique order payment keys.
-- Primary key: order_payment_key (generated from order_id, payment_sequential)

with source as (
    select *
    from dbt_olist_project.raw.order_payments
)

, stg_order_payments as (
    select
        
    md5(
        cast(order_id as string) || '|' || cast(payment_sequential as string)
    )
 as order_payment_key
        , order_id
        , payment_sequential
        , payment_type
        , payment_installments
        , payment_value
    from source
)

select *
from stg_order_payments
  );

