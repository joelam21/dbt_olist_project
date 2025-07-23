
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_estimated_delivery_date
from dbt_olist_project.dbt_prod.int_orders_fulfillment
where order_estimated_delivery_date is null



  
  
      
    ) dbt_internal_test