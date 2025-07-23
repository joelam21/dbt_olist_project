
    select *
    from dbt_olist_project.dbt_prod.int_order_payments
    where payment_value < 0
