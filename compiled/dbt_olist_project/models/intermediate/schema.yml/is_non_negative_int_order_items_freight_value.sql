
    select *
    from dbt_olist_project.dbt_prod.int_order_items
    where freight_value < 0
