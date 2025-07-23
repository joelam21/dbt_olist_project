
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_id
from dbt_olist_project.dbt_prod.stg_products
where product_id is null



  
  
      
    ) dbt_internal_test