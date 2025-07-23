
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select geolocation_city
from dbt_olist_project.raw.geolocation
where geolocation_city is null



  
  
      
    ) dbt_internal_test