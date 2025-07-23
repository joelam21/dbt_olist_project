
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select category
from dbt_olist_project.dbt_prod.categories
where category is null



  
  
      
    ) dbt_internal_test