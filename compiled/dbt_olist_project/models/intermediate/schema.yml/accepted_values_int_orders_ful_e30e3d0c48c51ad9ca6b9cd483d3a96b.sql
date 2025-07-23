
    
    

with all_values as (

    select
        delivered_on_time as value_field,
        count(*) as n_records

    from dbt_olist_project.dbt_prod.int_orders_fulfillment
    group by delivered_on_time

)

select *
from all_values
where value_field not in (
    'True','False'
)


