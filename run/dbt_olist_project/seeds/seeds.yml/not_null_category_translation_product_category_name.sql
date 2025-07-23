
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_category_name
from dbt_olist_project.dbt_prod.category_translation
where product_category_name is null



  
  
      
    ) dbt_internal_test