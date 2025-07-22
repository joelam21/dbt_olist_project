-- created_at: 2025-07-22T19:15:02.822386+00:00
-- dialect: snowflake
-- node_id: not available
-- desc: Ensure catalogs and schemas exist
CREATE SCHEMA IF NOT EXISTS dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-22T19:15:03.153624+00:00
-- dialect: snowflake
-- node_id: not available
-- desc: Ensure catalogs and schemas exist
CREATE SCHEMA IF NOT EXISTS dbt_olist_project.DBT_DEV_dbt_test__audit;
-- created_at: 2025-07-22T19:15:03.201547+00:00
-- dialect: snowflake
-- node_id: not available
-- desc: Ensure catalogs and schemas exist
CREATE SCHEMA IF NOT EXISTS dbt_olist_project.raw;
-- created_at: 2025-07-22T19:15:04.594073+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.dim_dates
-- desc: execute adapter call
select datediff(
        day,
        cast('2016-01-01' as date),
        cast('2025-12-31' as date)
        );
-- created_at: 2025-07-22T19:15:05.190954+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_dim_products_product_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_id
from dbt_olist_project.DBT_DEV.dim_products
where product_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:05.976822+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_marketing_mql_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select mql_id
from dbt_olist_project.DBT_DEV.fct_marketing
where mql_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:06.333401+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_dim_marketing_mql_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select mql_id
from dbt_olist_project.DBT_DEV.dim_marketing
where mql_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:06.731977+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_fct_marketing_mql_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    mql_id as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.fct_marketing
where mql_id is not null
group by mql_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:07.162185+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_dim_sellers_seller_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    seller_id as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.dim_sellers
where seller_id is not null
group by seller_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:07.583294+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_dim_marketing_mql_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    mql_id as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.dim_marketing
where mql_id is not null
group by mql_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:07.893567+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_dim_products_product_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    product_id as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.dim_products
where product_id is not null
group by product_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:08.195648+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_dim_customers_customer_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from dbt_olist_project.DBT_DEV.dim_customers
where customer_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:08.554329+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_dim_sellers_seller_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select seller_id
from dbt_olist_project.DBT_DEV.dim_sellers
where seller_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:08.862474+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.relationships_int_order_items_product_id__product_id__ref_dim_products
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select product_id as from_field
    from dbt_olist_project.DBT_DEV.int_order_items
    where product_id is not null
),

parent as (
    select product_id as to_field
    from dbt_olist_project.DBT_DEV.dim_products
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:09.204963+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_dim_customers_customer_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_order_id
from dbt_olist_project.DBT_DEV.dim_customers
where customer_order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:09.503173+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_dim_customers_customer_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    customer_order_id as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.dim_customers
where customer_order_id is not null
group by customer_order_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:09.800295+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_customer_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_order_id
from dbt_olist_project.DBT_DEV.fct_order_items
where customer_order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:10.508150+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_freight_value
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select freight_value
from dbt_olist_project.DBT_DEV.fct_order_items
where freight_value is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:10.787806+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_product_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_id
from dbt_olist_project.DBT_DEV.fct_order_items
where product_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:11.123411+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_item_total_value
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select item_total_value
from dbt_olist_project.DBT_DEV.fct_order_items
where item_total_value is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:11.439051+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_order_item_key
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_item_key
from dbt_olist_project.DBT_DEV.fct_order_items
where order_item_key is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:11.701312+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_order_purchase_timestamp
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_purchase_timestamp
from dbt_olist_project.DBT_DEV.fct_order_items
where order_purchase_timestamp is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:12.052372+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_seller_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select seller_id
from dbt_olist_project.DBT_DEV.fct_order_items
where seller_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:12.317224+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_order_item_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_item_id
from dbt_olist_project.DBT_DEV.fct_order_items
where order_item_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:12.601210+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_price
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select price
from dbt_olist_project.DBT_DEV.fct_order_items
where price is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:12.897990+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_order_status
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_status
from dbt_olist_project.DBT_DEV.fct_order_items
where order_status is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:13.487543+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.relationships_int_order_items_customer_id__customer_order_id__ref_dim_customers
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select customer_id as from_field
    from dbt_olist_project.DBT_DEV.int_order_items
    where customer_id is not null
),

parent as (
    select customer_order_id as to_field
    from dbt_olist_project.DBT_DEV.dim_customers
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:13.747625+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_fct_order_items_order_item_key
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_item_key as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.fct_order_items
where order_item_key is not null
group by order_item_key
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:14.057797+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_items_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from dbt_olist_project.DBT_DEV.fct_order_items
where order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:14.365553+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_payments_order_payment_key
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_payment_key
from dbt_olist_project.DBT_DEV.fct_order_payments
where order_payment_key is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:14.611630+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_order_payments_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from dbt_olist_project.DBT_DEV.fct_order_payments
where order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:14.894991+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_fct_order_payments_order_payment_key
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_payment_key as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.fct_order_payments
where order_payment_key is not null
group by order_payment_key
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:15.202136+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_orders_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from dbt_olist_project.DBT_DEV.fct_orders
where order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:15.708012+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_fct_orders_customer_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_order_id
from dbt_olist_project.DBT_DEV.fct_orders
where customer_order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:16.017233+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_fct_orders_order_id
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_id as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.fct_orders
where order_id is not null
group by order_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:16.330060+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.not_null_dim_dates_date_day
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select date_day
from dbt_olist_project.DBT_DEV.dim_dates
where date_day is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2025-07-22T19:15:16.664244+00:00
-- dialect: snowflake
-- node_id: test.dbt_olist_project.unique_dim_dates_date_day
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    date_day as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.dim_dates
where date_day is not null
group by date_day
having count(*) > 1



  
  
      
    ) dbt_internal_test;
