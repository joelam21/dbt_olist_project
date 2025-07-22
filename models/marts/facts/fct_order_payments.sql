-- File: models/marts/facts/fct_order_payments.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Fact table for order payments, tracking payment details, status, and overpayment for analytics.
-- Note: Sourced from int_order_payments for standardized and enriched payment-level data.

select
    order_payment_key  -- surrogate key for uniqueness
    , order_id
    , customer_id as customer_order_id  -- used as FK in facts
    , payment_type
    , payment_value
    , payment_installments
    , payment_sequential
    , payment_number
    , total_installments
    , cumulative_payment
    , order_total
    , remaining_balance
    , is_final_payment
    , is_overpaid_order
    , overpaid_amount
    , payment_progress_pct
    , payment_status
from {{ ref('int_order_payments') }}
