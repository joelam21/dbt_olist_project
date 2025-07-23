
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select subcategory
from dbt_olist_project.dbt_prod.categories
where subcategory is null



  
  
      
    ) dbt_internal_test