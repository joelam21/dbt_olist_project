
    
    

with all_values as (

    select
        payment_status as value_field,
        count(*) as n_records

    from dbt_olist_project.dbt_prod.int_order_payments
    group by payment_status

)

select *
from all_values
where value_field not in (
    'orphaned_payments','unpaid','overpaid','paid','partial','unknown'
)


