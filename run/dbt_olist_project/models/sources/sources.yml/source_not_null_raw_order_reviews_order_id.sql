
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from dbt_olist_project.raw.order_reviews
where order_id is null



  
  
      
    ) dbt_internal_test