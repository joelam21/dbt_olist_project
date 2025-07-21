
    select *
    from dbt_olist_project.DBT_DEV.stg_order_items
    where freight_value < 0
