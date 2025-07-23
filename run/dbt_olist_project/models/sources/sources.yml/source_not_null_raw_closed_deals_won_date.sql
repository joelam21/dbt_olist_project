
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select won_date
from dbt_olist_project.raw.closed_deals
where won_date is null



  
  
      
    ) dbt_internal_test