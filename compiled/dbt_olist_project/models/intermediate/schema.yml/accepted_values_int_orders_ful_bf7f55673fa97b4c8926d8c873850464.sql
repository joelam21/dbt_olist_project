
    
    

with all_values as (

    select
        order_status as value_field,
        count(*) as n_records

    from dbt_olist_project.dbt_prod.int_orders_fulfillment
    group by order_status

)

select *
from all_values
where value_field not in (
    'delivered','shipped','canceled','invoiced','processing','unavailable','created','approved','no_status'
)


