
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    select *
    from dbt_olist_project.dbt_prod.int_orders_fulfillment_benchmarks
    where sla_days_to_approve < 0

  
  
      
    ) dbt_internal_test