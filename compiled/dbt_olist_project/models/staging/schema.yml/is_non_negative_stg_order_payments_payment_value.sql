
    select *
    from dbt_olist_project.dbt_prod.stg_order_payments
    where payment_value < 0
