
    select *
    from dbt_olist_project.dbt_prod.int_orders_fulfillment_metrics
    where delivery_window_days < 0
