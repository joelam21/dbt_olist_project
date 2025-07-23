
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select mql_id
from dbt_olist_project.dbt_prod.stg_marketing_qualified_leads
where mql_id is null



  
  
      
    ) dbt_internal_test