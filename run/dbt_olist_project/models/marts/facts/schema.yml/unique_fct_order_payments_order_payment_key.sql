
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_payment_key as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.fct_order_payments
where order_payment_key is not null
group by order_payment_key
having count(*) > 1



  
  
      
    ) dbt_internal_test