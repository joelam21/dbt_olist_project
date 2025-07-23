
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        delivered_on_time as value_field,
        count(*) as n_records

    from dbt_olist_project.dbt_prod.int_orders_fulfillment_benchmarks
    group by delivered_on_time

)

select *
from all_values
where value_field not in (
    'True','False'
)



  
  
      
    ) dbt_internal_test