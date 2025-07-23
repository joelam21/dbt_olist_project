
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_purchase_timestamp
from dbt_olist_project.dbt_prod.fct_order_items
where order_purchase_timestamp is null



  
  
      
    ) dbt_internal_test