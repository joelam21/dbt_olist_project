
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select channel
from dbt_olist_project.dbt_prod.origin_channel_map
where channel is null



  
  
      
    ) dbt_internal_test