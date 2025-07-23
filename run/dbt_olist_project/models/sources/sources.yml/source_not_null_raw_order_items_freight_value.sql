
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select freight_value
from dbt_olist_project.raw.order_items
where freight_value is null



  
  
      
    ) dbt_internal_test