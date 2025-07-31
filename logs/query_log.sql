-- created_at: 2025-07-31T22:18:27.306637+00:00
-- dialect: snowflake
-- node_id: not available
-- desc: Ensure catalogs and schemas exist
CREATE SCHEMA IF NOT EXISTS dbt_olist_project.DBT_PROD;
-- created_at: 2025-07-31T22:18:28.898129+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_items
-- desc: get_relation adapter call
show objects like 'INT_ORDER_ITEMS' in schema dbt_olist_project.DBT_PROD;
-- created_at: 2025-07-31T22:18:29.105325+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_items
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_PROD.int_order_items
  
   as (
    -- File: models/intermediate/int_order_items.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches order items data and prepares for downstream modeling.
with order_items as (
    select
        order_item_key
        , order_id
        , order_item_id
        , product_id
        , seller_id
        , shipping_limit_date
        , price
        , freight_value
    from dbt_olist_project.DBT_PROD.stg_order_items
)

, orders as (
    select
        order_id
        , customer_id
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , order_status
    from dbt_olist_project.DBT_PROD.stg_orders
)

, final as (
    select
        order_items.order_item_key
        , order_items.order_id
        , order_items.order_item_id
        , order_items.product_id
        , order_items.seller_id
        , orders.customer_id
        , orders.order_purchase_timestamp
        , orders.order_approved_at
        , orders.order_delivered_carrier_date
        , orders.order_delivered_customer_date
        , orders.order_estimated_delivery_date
        , order_items.shipping_limit_date
        , order_items.price
        , order_items.freight_value
        , coalesce(orders.order_status, 'no_status') as order_status
        , coalesce(order_items.price, 0) + coalesce(order_items.freight_value, 0) as item_total_value
    from order_items
    left join orders
        on order_items.order_id = orders.order_id
)

select
    order_item_key
    , order_id
    , order_item_id
    , product_id
    , seller_id
    , customer_id
    , order_purchase_timestamp
    , order_approved_at
    , order_delivered_carrier_date
    , order_delivered_customer_date
    , order_estimated_delivery_date
    , order_status
    , shipping_limit_date
    , price
    , freight_value
    , item_total_value
from final
  );
-- created_at: 2025-07-31T22:18:30.549937+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.fct_order_items
-- desc: get_relation adapter call
show objects like 'FCT_ORDER_ITEMS' in schema dbt_olist_project.DBT_PROD;
-- created_at: 2025-07-31T22:18:30.931821+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_payments
-- desc: get_relation adapter call
show objects like 'INT_ORDER_PAYMENTS' in schema dbt_olist_project.DBT_PROD;
-- created_at: 2025-07-31T22:18:30.935600+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.fct_order_items
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_PROD.fct_order_items
  
   as (
    -- File: models/marts/facts/fct_order_items.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Fact table for order items, enriched with order and product details for analytics and reporting.
-- Note: Sourced from int_order_items for standardized and enriched item-level data.
select
    order_item_key
    , order_item_id
    , order_id
    , product_id
    , seller_id
    , customer_id as customer_order_id  -- consistent with other fact tables
    -- Order dates
    , order_purchase_timestamp
    , order_approved_at
    , order_delivered_carrier_date
    , order_delivered_customer_date
    , order_estimated_delivery_date
    , order_status
    -- Item details
    , shipping_limit_date
    , price
    , freight_value
    , item_total_value
from dbt_olist_project.DBT_PROD.int_order_items
  );
-- created_at: 2025-07-31T22:18:31.164290+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_payments
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_PROD.int_order_payments
  
   as (
    -- File: models/intermediate/int_order_payments.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
with stg_order_payments as (
    select
        order_id
        , payment_type
        , payment_value
        , payment_installments
        , payment_sequential
    from dbt_olist_project.DBT_PROD.stg_order_payments
)

, int_order_items as (
    select
        order_id
        , max(customer_id) as customer_id
        , sum(price) as price
        , sum(freight_value) as freight_value
    from dbt_olist_project.DBT_PROD.int_order_items
    group by order_id
)

, orders_aggregated as (
    select
        order_id
        , customer_id
        , round(coalesce(sum(price + freight_value), 0), 2) as order_total
    from int_order_items
    group by order_id, customer_id
)

, payments as (
    select
        op.order_id
        , op.payment_type
        , op.payment_value
        , op.payment_installments
        , op.payment_sequential
        , oi.customer_id
        , oi.price
        , oi.freight_value
        , oa.order_total
        , sum(op.payment_value) over (
            partition by op.order_id
            order by op.payment_sequential
            rows between unbounded preceding and current row
        ) as cumulative_payment
        , row_number() over (
            partition by op.order_id
            order by op.payment_sequential
        ) as payment_number
        , max(op.payment_installments) over (
            partition by op.order_id
        ) as total_installments
    from stg_order_payments as op
    left join int_order_items as oi
        on op.order_id = oi.order_id
    left join orders_aggregated as oa
        on op.order_id = oa.order_id
)

    select
        md5(cast(coalesce(cast(order_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(payment_number as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as order_payment_key
        , order_id
        , payment_type
        , payment_value
        , payment_installments
        , payment_sequential
        , customer_id
        , price
        , freight_value
        , cumulative_payment
        , payment_number
        , total_installments
        , nullif(order_total, 0) as order_total
        , 
    ROUND(
        COALESCE(nullif(order_total, 0), 0) - COALESCE(nullif(cumulative_payment, 0), 0),
        2
    )
 as remaining_balance
        , min(
    ROUND(
        COALESCE(nullif(order_total, 0), 0) - COALESCE(nullif(cumulative_payment, 0), 0),
        2
    )
) over (partition by order_id) as min_remaining_balance
        , coalesce(payment_sequential = total_installments, false) as is_final_payment
        , coalesce(min_remaining_balance < 0, false) as is_overpaid_order
        , case when remaining_balance < 0 then abs(remaining_balance) else 0 end as overpaid_amount
        , round(cumulative_payment / nullif(order_total, 0), 2) as payment_progress_pct
        , case
            when order_total is null then 'orphaned_payments'
            when cumulative_payment = 0 then 'unpaid'
            when round(remaining_balance, 2) < 0 then 'overpaid'
            when round(remaining_balance, 2) = 0 then 'paid'
            when round(remaining_balance, 2) > 0 then 'partial'
            else 'unknown'
        end as payment_status
    from payments
  );
-- created_at: 2025-07-31T22:18:31.976369+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.fct_order_payments
-- desc: get_relation adapter call
show objects like 'FCT_ORDER_PAYMENTS' in schema dbt_olist_project.DBT_PROD;
-- created_at: 2025-07-31T22:18:32.100388+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.fct_order_payments
-- desc: get_column_schema_from_query adapter call
select * from (
        -- File: models/marts/facts/fct_order_payments.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Fact table for order payments, tracking payment details, status, and overpayment for analytics.
-- Note: Sourced from int_order_payments for standardized and enriched payment-level data.

select
    cast(order_payment_key as string) as order_payment_key  -- surrogate key for uniqueness
    , cast(order_id as string) as order_id
    , cast(customer_id as string) as customer_order_id  -- used as FK in facts
    , cast(payment_type as string) as payment_type
    , cast(payment_value as float) as payment_value
    , cast(payment_installments as integer) as payment_installments
    , cast(payment_sequential as integer) as payment_sequential
    , cast(payment_number as integer) as payment_number
    , cast(total_installments as integer) as total_installments
    , cast(cumulative_payment as float) as cumulative_payment
    , cast(order_total as float) as order_total
    , cast(remaining_balance as float) as remaining_balance
    , cast(is_final_payment as boolean) as is_final_payment
    , cast(is_overpaid_order as boolean) as is_overpaid_order
    , cast(overpaid_amount as float) as overpaid_amount
    , cast(payment_progress_pct as float) as payment_progress_pct
    , cast(payment_status as string) as payment_status
from dbt_olist_project.DBT_PROD.int_order_payments
    ) as __dbt_sbq
    where false
    limit 0
;
-- created_at: 2025-07-31T22:18:33.149199+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.fct_order_payments
-- desc: get_column_schema_from_query adapter call
select * from (
        select
    
      
    cast(null as float)
     as cumulative_payment, 
      
    cast(null as string)
     as customer_order_id, 
      
    cast(null as boolean)
     as is_final_payment, 
      
    cast(null as boolean)
     as is_overpaid_order, 
      
    cast(null as string)
     as order_id, 
      
    cast(null as string)
     as order_payment_key, 
      
    cast(null as float)
     as order_total, 
      
    cast(null as float)
     as overpaid_amount, 
      
    cast(null as integer)
     as payment_installments, 
      
    cast(null as integer)
     as payment_number, 
      
    cast(null as float)
     as payment_progress_pct, 
      
    cast(null as integer)
     as payment_sequential, 
      
    cast(null as string)
     as payment_status, 
      
    cast(null as string)
     as payment_type, 
      
    cast(null as float)
     as payment_value, 
      
    cast(null as float)
     as remaining_balance, 
      
    cast(null as integer)
     as total_installments
    ) as __dbt_sbq
    where false
    limit 0
;
-- created_at: 2025-07-31T22:18:33.523252+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.fct_order_payments
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_PROD.fct_order_payments
  
   as (
    -- File: models/marts/facts/fct_order_payments.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Fact table for order payments, tracking payment details, status, and overpayment for analytics.
-- Note: Sourced from int_order_payments for standardized and enriched payment-level data.

select
    cast(order_payment_key as string) as order_payment_key  -- surrogate key for uniqueness
    , cast(order_id as string) as order_id
    , cast(customer_id as string) as customer_order_id  -- used as FK in facts
    , cast(payment_type as string) as payment_type
    , cast(payment_value as float) as payment_value
    , cast(payment_installments as integer) as payment_installments
    , cast(payment_sequential as integer) as payment_sequential
    , cast(payment_number as integer) as payment_number
    , cast(total_installments as integer) as total_installments
    , cast(cumulative_payment as float) as cumulative_payment
    , cast(order_total as float) as order_total
    , cast(remaining_balance as float) as remaining_balance
    , cast(is_final_payment as boolean) as is_final_payment
    , cast(is_overpaid_order as boolean) as is_overpaid_order
    , cast(overpaid_amount as float) as overpaid_amount
    , cast(payment_progress_pct as float) as payment_progress_pct
    , cast(payment_status as string) as payment_status
from dbt_olist_project.DBT_PROD.int_order_payments
  );
