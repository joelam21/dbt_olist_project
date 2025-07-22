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
from dbt_olist_project.DBT_DEV.int_order_payments