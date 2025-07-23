
    
    

select
    product_id as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.int_products_enriched
where product_id is not null
group by product_id
having count(*) > 1


