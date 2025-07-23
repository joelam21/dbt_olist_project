
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select payment_type
from dbt_olist_project.raw.order_payments
where payment_type is null



  
  
      
    ) dbt_internal_test