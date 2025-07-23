
    
    

select
    order_id as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.int_orders_fulfillment
where order_id is not null
group by order_id
having count(*) > 1


