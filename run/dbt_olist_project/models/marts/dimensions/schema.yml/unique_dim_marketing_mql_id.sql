
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    mql_id as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.dim_marketing
where mql_id is not null
group by mql_id
having count(*) > 1



  
  
      
    ) dbt_internal_test