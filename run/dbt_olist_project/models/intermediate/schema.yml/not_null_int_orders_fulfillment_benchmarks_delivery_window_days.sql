
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select delivery_window_days
from dbt_olist_project.dbt_prod.int_orders_fulfillment_benchmarks
where delivery_window_days is null



  
  
      
    ) dbt_internal_test