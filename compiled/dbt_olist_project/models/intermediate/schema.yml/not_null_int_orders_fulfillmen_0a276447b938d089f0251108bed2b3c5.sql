
    
    



select order_purchase_timestamp
from dbt_olist_project.dbt_prod.int_orders_fulfillment_metrics
where order_purchase_timestamp is null


