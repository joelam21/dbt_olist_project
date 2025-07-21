
    
    

select
    subcategory as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.categories
where subcategory is not null
group by subcategory
having count(*) > 1


