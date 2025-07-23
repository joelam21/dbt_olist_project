
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select price_total
from dbt_olist_project.dbt_prod.int_orders_metrics
where price_total is null



  
  
      
    ) dbt_internal_test