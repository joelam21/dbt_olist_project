
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_final_payment
from dbt_olist_project.dbt_prod.int_order_payments
where is_final_payment is null



  
  
      
    ) dbt_internal_test