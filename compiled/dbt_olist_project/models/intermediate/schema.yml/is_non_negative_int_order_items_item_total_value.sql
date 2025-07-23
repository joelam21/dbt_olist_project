
    select *
    from dbt_olist_project.dbt_prod.int_order_items
    where item_total_value < 0
