
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select sla_days_to_carrier
from dbt_olist_project.dbt_prod.int_orders_fulfillment
where sla_days_to_carrier is null



  
  
      
    ) dbt_internal_test