
  create or replace   view dbt_olist_project.DBT_DEV.int_orders_fulfillment_metrics
  
  
  
  
  as (
    with max_data_date as (
    select
        max(order_estimated_delivery_date) as as_of_date
    from dbt_olist_project.DBT_DEV.stg_orders
),
orders as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , as_of_date
    from dbt_olist_project.DBT_DEV.stg_orders
    cross join max_data_date m
)

    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , as_of_date
        , datediff(day, order_purchase_timestamp, order_estimated_delivery_date) as delivery_window_days
        , datediff(day, order_purchase_timestamp, order_delivered_customer_date) as delivery_days
        , datediff(day, order_purchase_timestamp, order_approved_at) as days_to_approve
        , datediff(day, order_approved_at, order_delivered_carrier_date) as days_to_carrier
        , datediff(day, order_delivered_carrier_date, order_delivered_customer_date) as days_to_customer
        , case
            when order_status = 'canceled' then null
            when order_status = 'delivered' and date_trunc('day', order_delivered_customer_date) <= order_estimated_delivery_date then true
            when order_status = 'delivered' and date_trunc('day', order_delivered_customer_date) > order_estimated_delivery_date then false
            when order_status != 'delivered' and as_of_date > order_estimated_delivery_date then false
            else null
        end as delivered_on_time
    from orders
  );

