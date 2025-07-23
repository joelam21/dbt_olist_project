
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select fulfillment_delay_summary
from dbt_olist_project.dbt_prod.int_orders_fulfillment
where fulfillment_delay_summary is null



  
  
      
    ) dbt_internal_test