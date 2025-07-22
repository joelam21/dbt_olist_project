-- File: models/intermediate/int_order_payments.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
with stg_order_payments as (
    select
        order_id
        , payment_type
        , payment_value
        , payment_installments
        , payment_sequential
    from {{ ref('stg_order_payments') }}
)

, int_order_items as (
    select
        order_id
        , customer_id
        , price
        , freight_value
    from {{ ref('int_order_items') }}
)

, orders_aggregated as (
    select
        order_id
        , customer_id
        , round(coalesce(sum(price + freight_value), 0), 2) as order_total
    from int_order_items
    group by order_id, customer_id
)

, payments as (
    select
        op.order_id
        , op.payment_type
        , op.payment_value
        , op.payment_installments
        , op.payment_sequential
        , oi.customer_id
        , oi.price
        , oi.freight_value
        , oa.order_total
        , sum(op.payment_value) over (
            partition by op.order_id
            order by op.payment_sequential
            rows between unbounded preceding and current row
        ) as cumulative_payment
        , row_number() over (
            partition by op.order_id
            order by op.payment_sequential
        ) as payment_number
        , max(op.payment_installments) over (
            partition by op.order_id
        ) as total_installments
    from stg_order_payments as op
    left join int_order_items as oi
        on op.order_id = oi.order_id
    left join orders_aggregated as oa
        on op.order_id = oa.order_id
)

    select
        {{ dbt_utils.generate_surrogate_key(['order_id', 'payment_number']) }} as order_payment_key
        , order_id
        , payment_type
        , payment_value
        , payment_installments
        , payment_sequential
        , customer_id
        , price
        , freight_value
        , cumulative_payment
        , payment_number
        , total_installments
        , nullif(order_total, 0) as order_total
        , {{ rounded_remaining_balance('nullif(order_total, 0)', 'nullif(cumulative_payment, 0)') }} as remaining_balance
        , min({{ rounded_remaining_balance('nullif(order_total, 0)', 'nullif(cumulative_payment, 0)') }}) over (partition by order_id) as min_remaining_balance
        , coalesce(payment_sequential = total_installments, false) as is_final_payment
        , coalesce(min_remaining_balance < 0, false) as is_overpaid_order
        , case when remaining_balance < 0 then abs(remaining_balance) else 0 end as overpaid_amount
        , round(cumulative_payment / nullif(order_total, 0), 2) as payment_progress_pct
        , case
            when order_total is null then 'orphaned_payments'
            when cumulative_payment = 0 then 'unpaid'
            when round(remaining_balance, 2) < 0 then 'overpaid'
            when round(remaining_balance, 2) = 0 then 'paid'
            when round(remaining_balance, 2) > 0 then 'partial'
            else 'unknown'
        end as payment_status
    from payments
