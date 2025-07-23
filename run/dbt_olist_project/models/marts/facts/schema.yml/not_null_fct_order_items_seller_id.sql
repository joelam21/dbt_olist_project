
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select seller_id
from dbt_olist_project.dbt_prod.fct_order_items
where seller_id is null



  
  
      
    ) dbt_internal_test