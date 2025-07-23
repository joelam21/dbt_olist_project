
    
    

select
    mql_id as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.fct_marketing
where mql_id is not null
group by mql_id
having count(*) > 1


