
    select *
    from dbt_olist_project.dbt_prod.int_orders_fulfillment_benchmarks
    where sla_days_to_carrier < 0
