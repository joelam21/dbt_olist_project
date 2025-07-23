
    select *
    from dbt_olist_project.dbt_prod.stg_products
    where length_cm < 0
