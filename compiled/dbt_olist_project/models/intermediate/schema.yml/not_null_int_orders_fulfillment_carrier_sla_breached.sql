
    
    



select carrier_sla_breached
from dbt_olist_project.dbt_prod.int_orders_fulfillment
where carrier_sla_breached is null


