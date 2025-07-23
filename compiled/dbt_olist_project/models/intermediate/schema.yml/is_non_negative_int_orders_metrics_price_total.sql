
    select *
    from dbt_olist_project.dbt_prod.int_orders_metrics
    where price_total < 0
