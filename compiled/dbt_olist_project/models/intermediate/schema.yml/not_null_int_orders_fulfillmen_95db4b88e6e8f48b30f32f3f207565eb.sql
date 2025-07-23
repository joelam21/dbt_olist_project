
    
    



select last_mile_sla_breached
from dbt_olist_project.dbt_prod.int_orders_fulfillment_benchmarks
where last_mile_sla_breached is null


