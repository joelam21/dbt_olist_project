
    select *
    from dbt_olist_project.DBT_DEV.stg_products
    where description_length < 0
