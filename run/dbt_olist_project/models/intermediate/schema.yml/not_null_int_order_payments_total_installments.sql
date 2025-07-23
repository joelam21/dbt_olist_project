
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_installments
from dbt_olist_project.dbt_prod.int_order_payments
where total_installments is null



  
  
      
    ) dbt_internal_test