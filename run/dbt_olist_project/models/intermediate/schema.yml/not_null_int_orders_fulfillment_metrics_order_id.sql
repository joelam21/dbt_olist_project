
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from dbt_olist_project.dbt_prod.int_orders_fulfillment_metrics
where order_id is null



  
  
      
    ) dbt_internal_test