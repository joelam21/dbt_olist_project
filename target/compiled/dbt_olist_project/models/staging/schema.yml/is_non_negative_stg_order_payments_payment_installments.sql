
    select *
    from dbt_olist_project.DBT_DEV.stg_order_payments
    where payment_installments < 0
