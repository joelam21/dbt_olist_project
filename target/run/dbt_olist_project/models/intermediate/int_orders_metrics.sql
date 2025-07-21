
  create or replace   view dbt_olist_project.DBT_DEV.int_orders_metrics
  
  
  
  
  as (
    with order_items as (
    select
        order_id
        , price
        , freight_value
    from dbt_olist_project.DBT_DEV.stg_order_items
)

    select
        order_id
        , count(*) as num_items
        , sum(price) as price_total
        , sum(freight_value) as freight_total
        , sum(price + freight_value) as order_total
    from order_items
    group by order_id
  );

