
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select sla_type
from dbt_olist_project.dbt_prod.sla_thresholds
where sla_type is null



  
  
      
    ) dbt_internal_test