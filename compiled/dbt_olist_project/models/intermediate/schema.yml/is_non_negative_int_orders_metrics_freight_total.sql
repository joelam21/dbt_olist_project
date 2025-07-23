
    select *
    from dbt_olist_project.dbt_prod.int_orders_metrics
    where freight_total < 0
