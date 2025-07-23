
    
    

select
    subcategory as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.categories
where subcategory is not null
group by subcategory
having count(*) > 1


