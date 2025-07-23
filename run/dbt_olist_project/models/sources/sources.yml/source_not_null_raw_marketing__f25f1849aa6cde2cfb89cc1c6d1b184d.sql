
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select first_contact_date
from dbt_olist_project.raw.marketing_qualified_leads
where first_contact_date is null



  
  
      
    ) dbt_internal_test