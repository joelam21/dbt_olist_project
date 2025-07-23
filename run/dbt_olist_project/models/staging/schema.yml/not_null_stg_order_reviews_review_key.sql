
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select review_key
from dbt_olist_project.dbt_prod.stg_order_reviews
where review_key is null



  
  
      
    ) dbt_internal_test