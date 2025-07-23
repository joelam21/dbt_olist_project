
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select lng
from dbt_olist_project.dbt_prod.int_zipcode_geolocation
where lng is null



  
  
      
    ) dbt_internal_test