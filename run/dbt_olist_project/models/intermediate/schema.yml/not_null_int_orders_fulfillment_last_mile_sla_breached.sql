
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select last_mile_sla_breached
from dbt_olist_project.dbt_prod.int_orders_fulfillment
where last_mile_sla_breached is null



  
  
      
    ) dbt_internal_test