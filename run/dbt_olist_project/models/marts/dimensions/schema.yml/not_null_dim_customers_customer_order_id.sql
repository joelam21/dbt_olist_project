
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_order_id
from dbt_olist_project.dbt_prod.dim_customers
where customer_order_id is null



  
  
      
    ) dbt_internal_test