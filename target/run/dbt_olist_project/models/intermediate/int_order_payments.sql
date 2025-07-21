
  create or replace   view dbt_olist_project.DBT_DEV.int_order_payments
  
  
  
  
  as (
    with stg_order_payments as (
    select
        order_id
        , payment_type
        , payment_value
        , payment_installments
        , payment_sequential
    from dbt_olist_project.DBT_DEV.stg_order_payments
),
int_order_items as (
    select
        order_id
        , customer_id
        , price
        , freight_value
    from dbt_olist_project.DBT_DEV.int_order_items
),
orders_aggregated as (
    select
        order_id
        , customer_id
        , round(coalesce(sum(price + freight_value), 0), 2) as order_total
    from int_order_items
    group by order_id, customer_id
),
payments as (
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
    from stg_order_payments op
    left join int_order_items oi
        on op.order_id = oi.order_id
    left join orders_aggregated oa
        on op.order_id = oa.order_id
)

    select
        payments.order_id
        , payments.payment_type
        , payments.payment_value
        , payments.payment_installments
        , payments.payment_sequential
        , payments.cumulative_payment
        , payments.payment_number
        , payments.total_installments
        , orders_aggregated.customer_id
        , nullif(orders_aggregated.order_total, 0) as order_total
    from payments
    left join orders_aggregated using (order_id)
  );

