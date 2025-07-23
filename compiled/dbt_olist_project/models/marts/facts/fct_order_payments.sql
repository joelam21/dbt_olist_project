-- File: models/marts/facts/fct_order_payments.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Fact table for order payments, tracking payment details, status, and overpayment for analytics.
-- Note: Sourced from int_order_payments for standardized and enriched payment-level data.

select
    cast(order_payment_key as string) as order_payment_key  -- surrogate key for uniqueness
    , cast(order_id as string) as order_id
    , cast(customer_id as string) as customer_order_id  -- used as FK in facts
    , cast(payment_type as string) as payment_type
    , cast(payment_value as float) as payment_value
    , cast(payment_installments as integer) as payment_installments
    , cast(payment_sequential as integer) as payment_sequential
    , cast(payment_number as integer) as payment_number
    , cast(total_installments as integer) as total_installments
    , cast(cumulative_payment as float) as cumulative_payment
    , cast(order_total as float) as order_total
    , cast(remaining_balance as float) as remaining_balance
    , cast(is_final_payment as boolean) as is_final_payment
    , cast(is_overpaid_order as boolean) as is_overpaid_order
    , cast(overpaid_amount as float) as overpaid_amount
    , cast(payment_progress_pct as float) as payment_progress_pct
    , cast(payment_status as string) as payment_status
from dbt_olist_project.dbt_prod.int_order_payments