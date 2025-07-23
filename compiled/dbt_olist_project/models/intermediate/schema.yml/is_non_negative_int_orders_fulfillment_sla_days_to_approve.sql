
    select *
    from dbt_olist_project.dbt_prod.int_orders_fulfillment
    where sla_days_to_approve < 0
