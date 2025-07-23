
    
    

select
    product_category_name as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.category_translation
where product_category_name is not null
group by product_category_name
having count(*) > 1


