
    
    

select
    customer_order_id as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.dim_customers
where customer_order_id is not null
group by customer_order_id
having count(*) > 1


