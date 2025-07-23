
    select *
    from dbt_olist_project.dbt_prod.stg_order_items
    where price < 0
