
    
    

with all_values as (

    select
        carrier_sla_breached as value_field,
        count(*) as n_records

    from dbt_olist_project.dbt_prod.int_orders_fulfillment
    group by carrier_sla_breached

)

select *
from all_values
where value_field not in (
    'True','False'
)


