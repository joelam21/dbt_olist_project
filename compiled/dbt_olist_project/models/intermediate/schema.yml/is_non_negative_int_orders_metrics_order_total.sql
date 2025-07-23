
    select *
    from dbt_olist_project.dbt_prod.int_orders_metrics
    where order_total < 0
