
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select effective_end_date
from dbt_olist_project.dbt_prod.sla_thresholds
where effective_end_date is null



  
  
      
    ) dbt_internal_test