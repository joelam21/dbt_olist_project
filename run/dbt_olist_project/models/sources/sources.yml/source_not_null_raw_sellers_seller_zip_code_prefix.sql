
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select seller_zip_code_prefix
from dbt_olist_project.raw.sellers
where seller_zip_code_prefix is null



  
  
      
    ) dbt_internal_test