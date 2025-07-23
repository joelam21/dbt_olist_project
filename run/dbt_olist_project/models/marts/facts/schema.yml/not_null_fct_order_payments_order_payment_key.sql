
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_payment_key
from dbt_olist_project.dbt_prod.fct_order_payments
where order_payment_key is null



  
  
      
    ) dbt_internal_test