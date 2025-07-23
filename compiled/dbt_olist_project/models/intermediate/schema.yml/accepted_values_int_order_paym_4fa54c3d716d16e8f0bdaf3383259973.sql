
    
    

with all_values as (

    select
        is_overpaid_order as value_field,
        count(*) as n_records

    from dbt_olist_project.dbt_prod.int_order_payments
    group by is_overpaid_order

)

select *
from all_values
where value_field not in (
    'True','False'
)


