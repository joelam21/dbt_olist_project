
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    select *
    from dbt_olist_project.dbt_prod.stg_order_payments
    where payment_value < 0

  
  
      
    ) dbt_internal_test