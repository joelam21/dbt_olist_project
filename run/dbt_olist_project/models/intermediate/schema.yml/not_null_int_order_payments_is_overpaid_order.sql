
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select is_overpaid_order
from dbt_olist_project.dbt_prod.int_order_payments
where is_overpaid_order is null



  
  
      
    ) dbt_internal_test