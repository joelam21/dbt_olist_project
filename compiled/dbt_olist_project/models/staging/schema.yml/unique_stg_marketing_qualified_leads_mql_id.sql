
    
    

select
    mql_id as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.stg_marketing_qualified_leads
where mql_id is not null
group by mql_id
having count(*) > 1


