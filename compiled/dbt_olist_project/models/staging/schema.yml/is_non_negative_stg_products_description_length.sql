
    select *
    from dbt_olist_project.dbt_prod.stg_products
    where description_length < 0
