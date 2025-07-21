-- created_at: 2025-07-21T23:24:59.623529+00:00
-- dialect: snowflake
-- node_id: not available
-- desc: Ensure catalogs and schemas exist
CREATE SCHEMA IF NOT EXISTS dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:24:59.943613+00:00
-- dialect: snowflake
-- node_id: not available
-- desc: Ensure catalogs and schemas exist
CREATE SCHEMA IF NOT EXISTS dbt_olist_project.raw;
-- created_at: 2025-07-21T23:25:01.312833+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_marketing_qualified_leads
-- desc: get_relation adapter call
show objects like 'STG_MARKETING_QUALIFIED_LEADS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:01.668885+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_order_payments
-- desc: get_relation adapter call
show objects like 'STG_ORDER_PAYMENTS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:01.763156+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_marketing_qualified_leads
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_marketing_qualified_leads
  
   as (
    -- File: models/staging/stg_marketing_qualified_leads.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages marketing qualified leads (MQL) data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: mql_id

with source as (
    select * from dbt_olist_project.raw.marketing_qualified_leads
)

, stg_marketing_qualified_leads as (
    select
        mql_id
        , first_contact_date
        , landing_page_id
        , origin
    from source
)

select *
from stg_marketing_qualified_leads
  );
-- created_at: 2025-07-21T23:25:01.918601+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_order_payments
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_order_payments
  
   as (
    -- File: models/staging/stg_order_payments.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages order payments data from the raw layer,
--          generating a surrogate key for uniqueness and
--          preparing for downstream modeling.
-- Note: Uses the generate_surrogate_key macro to ensure unique order payment keys.
-- Primary key: order_payment_key (generated from order_id, payment_sequential)

with source as (
    select *
    from dbt_olist_project.raw.order_payments
)

, stg_order_payments as (
    select
        
    md5(
        cast(order_id as string) || '|' || cast(payment_sequential as string)
    )
 as order_payment_key
        , order_id
        , payment_sequential
        , payment_type
        , payment_installments
        , payment_value
    from source
)

select *
from stg_order_payments
  );
-- created_at: 2025-07-21T23:25:01.945106+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_orders
-- desc: get_relation adapter call
show objects like 'STG_ORDERS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:02.176811+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_order_items
-- desc: get_relation adapter call
show objects like 'STG_ORDER_ITEMS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:02.252384+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_orders
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_orders
  
   as (
    -- File: models/staging/stg_orders.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages orders data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: order_id

with source as (
    select * from dbt_olist_project.raw.orders
)

, stg_orders as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
    from source
)

select *
from stg_orders
  );
-- created_at: 2025-07-21T23:25:02.582498+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_products
-- desc: get_relation adapter call
show objects like 'STG_PRODUCTS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:02.758491+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_products
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_products
  
   as (
    -- File: models/staging/stg_products.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages products data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: product_id

with source as (
    select * from dbt_olist_project.raw.products
)

, stg_products as (
    select
        product_id
        , product_category_name as category_name
        , product_name_lenght as name_length
        , product_description_lenght as description_length
        , product_photos_qty as photos_qty
        , product_weight_g as weight_g
        , product_length_cm as length_cm
        , product_height_cm as height_cm
        , product_width_cm as width_cm
    from source
)

select *
from stg_products
  );
-- created_at: 2025-07-21T23:25:03.002825+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_order_items
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_order_items
  
   as (
    -- File: models/staging/stg_order_items.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages order items data from the raw layer,
--          generating a surrogate key for uniqueness and
--          preparing for downstream modeling.
-- Note: Uses the generate_surrogate_key macro to ensure unique order item keys.
-- Primary key: order_item_key (generated from order_id, order_item_id)

with source as (
    select *
    from dbt_olist_project.raw.order_items
)

, stg_order_items as (
    select
        
    md5(
        cast(order_id as string) || '|' || cast(order_item_id as string)
    )
 as order_item_key
        , order_id
        , order_item_id
        , product_id
        , seller_id
        , shipping_limit_date
        , price
        , freight_value
    from source
)

select *
from stg_order_items
  );
-- created_at: 2025-07-21T23:25:03.359557+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_sellers
-- desc: get_relation adapter call
show objects like 'STG_SELLERS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:03.479235+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_sellers
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_sellers
  
   as (
    -- File: models/staging/stg_sellers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages sellers data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: seller_id

with source as (
    select *
    from dbt_olist_project.raw.sellers
)

, stg_sellers as (
    select
        seller_id
        , 
    lpad(cast(seller_zip_code_prefix as string), 5, '0')
 as seller_zip_code
        , seller_city
        , seller_state
    from source
)

select *
from stg_sellers
  );
-- created_at: 2025-07-21T23:25:03.726192+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_customers
-- desc: get_relation adapter call
show objects like 'STG_CUSTOMERS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:03.872598+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_customers
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_customers
  
   as (
    -- File: models/staging/stg_customers.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages customer data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: customer_id

with source as (
    select
        customer_id
        , customer_unique_id
        , customer_zip_code_prefix
        , customer_city
        , customer_state
    from dbt_olist_project.raw.customers
)

, stg_customers as (
    select
        customer_id
        , customer_unique_id
        , 
    lpad(cast(customer_zip_code_prefix as string), 5, '0')
 as customer_zip_code
        , customer_city
        , customer_state
    from source
)

select *
from stg_customers
  );
-- created_at: 2025-07-21T23:25:03.917641+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_closed_deals
-- desc: get_relation adapter call
show objects like 'STG_CLOSED_DEALS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:04.102564+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_closed_deals
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_closed_deals
  
   as (
    -- File: models/staging/stg_closed_deals.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages closed deals data from the raw layer, standardizing booleans and preparing for downstream modeling.
-- Note: coalesce is used to ensure boolean fields are never null.

with source as (
    select *
    from dbt_olist_project.raw.closed_deals
)

, stg_closed_deals as (
    select
        mql_id
        , seller_id
        , sdr_id
        , sr_id
        , won_date
        , business_segment
        , lead_type
        , lead_behaviour_profile
        , average_stock
        , business_type
        , declared_product_catalog_size
        , declared_monthly_revenue
        , coalesce(has_company, false) as has_company  -- ensure boolean, never null
        , coalesce(has_gtin, false) as has_gtin        -- ensure boolean, never null
    from source
)

select *
from stg_closed_deals
  );
-- created_at: 2025-07-21T23:25:04.205330+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_order_reviews
-- desc: get_relation adapter call
show objects like 'STG_ORDER_REVIEWS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:04.334173+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_order_reviews
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_order_reviews
  
   as (
    -- File: models/staging/stg_order_reviews.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages order reviews data from the raw layer, generating a surrogate key for uniqueness and preparing for downstream modeling.
-- Note: In the raw data, review_id is not unique because the same review can be associated with multiple orders. This model generates a surrogate key using both review_id and order_id to ensure uniqueness.
-- Primary key: review_key (generated from review_id, order_id)

with source as (
    select *
    from dbt_olist_project.raw.order_reviews
)

, stg_order_reviews as (
    select
        
    md5(
        cast(review_id as string) || '|' || cast(order_id as string)
    )
 as review_key
        , review_id
        , order_id
        , review_score
        , review_comment_title
        , review_comment_message
        , review_creation_date
        , review_answer_timestamp
    from source
)

select *
from stg_order_reviews
  );
-- created_at: 2025-07-21T23:25:04.569600+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_category_enriched
-- desc: get_relation adapter call
show objects like 'STG_CATEGORY_ENRICHED' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:04.714351+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_category_enriched
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_category_enriched
  
   as (
    -- File: models/staging/stg_category_enriched.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- NOTE:
-- We are referencing the 'categories' and 'category_translation' seeds directly in this staging model.
-- No base models are created for these seeds because the data is already clean and well-structured.
-- If future cleaning or renaming is needed, consider introducing base models at that time.

select
    categories.category
    , category_translation.product_category_name_english as subcategory
    , category_translation.product_category_name
    , iff(
        category_translation.product_category_name_english is not null
        , true
        , false
    )
        as is_translated
from dbt_olist_project.DBT_DEV.category_translation as category_translation
left join dbt_olist_project.DBT_DEV.categories as categories
    on
        category_translation.product_category_name_english
        = categories.subcategory
  );
-- created_at: 2025-07-21T23:25:04.838420+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_geolocation
-- desc: get_relation adapter call
show objects like 'STG_GEOLOCATION' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:04.997899+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.stg_geolocation
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.stg_geolocation
  
   as (
    -- File: models/staging/stg_geolocation.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages geolocation data from the raw layer, standardizing zip codes and preparing for downstream modeling.
-- Note: Uses the pad_zip macro to ensure zip codes are consistently formatted.
-- Primary key: (zip_code, lat, lng, city, state) | surrogate key: geolocation_key

with source as (
    select *
    from dbt_olist_project.raw.geolocation
)

, stg_geolocation as (
    select
        
    md5(
        cast(
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')
 as string) || '|' || cast(geolocation_lat as string) || '|' || cast(geolocation_lng as string) || '|' || cast(geolocation_city as string) || '|' || cast(geolocation_state as string)
    )
 as geolocation_key
        , 
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')
 as zip_code
        , geolocation_lat as lat
        , geolocation_lng as lng
        , geolocation_city as city
        , geolocation_state as state
    from source
    group by
          
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')

        , geolocation_lat
        , geolocation_lng
        , geolocation_city
        , geolocation_state
)

select *
from stg_geolocation
  );
-- created_at: 2025-07-21T23:25:05.159044+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_marketing_qualified_leads
-- desc: get_relation adapter call
show objects like 'INT_MARKETING_QUALIFIED_LEADS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:05.348169+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_marketing_qualified_leads
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_marketing_qualified_leads
  
   as (
    -- File: models/intermediate/int_marketing_qualified_leads.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches marketing qualified leads data and prepares for downstream modeling.
-- Note: Add further notes on business logic or data handling as needed.
with mql as (
    select
        mql_id
        , first_contact_date
        , landing_page_id
        , origin
    from dbt_olist_project.DBT_DEV.stg_marketing_qualified_leads
)

, origin_channel as (
    select
        origin
        , channel
    from dbt_olist_project.DBT_DEV.origin_channel_map
)

select
    mql.mql_id
    , mql.first_contact_date
    , mql.landing_page_id
    , mql.origin
    , origin_channel.channel
from mql
left join origin_channel
    on mql.origin = origin_channel.origin
  );
-- created_at: 2025-07-21T23:25:05.520066+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_fulfillment_metrics
-- desc: get_relation adapter call
show objects like 'INT_ORDERS_FULFILLMENT_METRICS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:05.671156+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_fulfillment_metrics
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_orders_fulfillment_metrics
  
   as (
    -- File: models/intermediate/int_orders_fulfillment_metrics.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed

with max_data_date as (
    select max(order_estimated_delivery_date) as as_of_date
    from dbt_olist_project.DBT_DEV.stg_orders
)

, orders as (
    select
        o.order_id
        , o.customer_id
        , o.order_status
        , o.order_purchase_timestamp
        , o.order_approved_at
        , o.order_delivered_carrier_date
        , o.order_delivered_customer_date
        , o.order_estimated_delivery_date
        , m.as_of_date
    from dbt_olist_project.DBT_DEV.stg_orders as o
    cross join max_data_date as m
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
        , datediff(day, order_purchase_timestamp, order_estimated_delivery_date) as delivery_window_days -- Total allowed delivery window
        , datediff(day, order_purchase_timestamp, order_delivered_customer_date) as delivery_days -- Actual days from purchase to delivery
        , datediff(day, order_purchase_timestamp, order_approved_at) as days_to_approve -- Days from purchase to approval
        , datediff(day, order_approved_at, order_delivered_carrier_date) as days_to_carrier -- Days from approval to carrier handoff
        , datediff(day, order_delivered_carrier_date, order_delivered_customer_date) as days_to_customer -- Days from carrier handoff to customer delivery
        , case
            when order_status = 'canceled' then null -- No on-time flag for canceled orders
            when order_status = 'delivered' and date_trunc('day', order_delivered_customer_date) <= order_estimated_delivery_date then true -- Delivered on or before estimated date
            when order_status = 'delivered' and date_trunc('day', order_delivered_customer_date) > order_estimated_delivery_date then false -- Delivered late
            when order_status != 'delivered' and as_of_date > order_estimated_delivery_date then false -- Not delivered and window expired -- Still in progress or insufficient data
        end as delivered_on_time -- Boolean flag for on-time delivery
    from orders
  );
-- created_at: 2025-07-21T23:25:05.759644+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_metrics
-- desc: get_relation adapter call
show objects like 'INT_ORDERS_METRICS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:05.896487+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_metrics
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_orders_metrics
  
   as (
    -- File: models/intermediate/int_orders_metrics.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates order-level metrics for downstream analysis.
-- Note: Add further notes on business logic or data handling as needed.
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
-- created_at: 2025-07-21T23:25:06.033599+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_items
-- desc: get_relation adapter call
show objects like 'INT_ORDER_ITEMS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:06.120985+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_fulfillment_benchmarks
-- desc: get_relation adapter call
show objects like 'INT_ORDERS_FULFILLMENT_BENCHMARKS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:06.180158+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_items
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_order_items
  
   as (
    -- File: models/intermediate/int_order_items.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches order items data and prepares for downstream modeling.
-- Note: Add further notes on business logic or data handling as needed.
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
    from dbt_olist_project.DBT_DEV.stg_order_items
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
    from dbt_olist_project.DBT_DEV.stg_orders
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
-- created_at: 2025-07-21T23:25:06.260243+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_fulfillment_benchmarks
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_orders_fulfillment_benchmarks
  
   as (
    -- File: models/intermediate/int_orders_fulfillment_benchmarks.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates fulfillment SLA breaches and delay summaries for each order.
-- Note: Add further notes on business logic or data handling as needed.
--
-- int_orders_fulfillment_benchmarks.sql
-- Calculates fulfillment SLA breaches and delay summaries for each order.
-- Modular CTE structure for maintainability and interpretability.
--

-- CTE: fulfillment
-- Pulls detailed fulfillment event metrics for each order from the intermediate model.
with fulfillment as (
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
        , delivery_window_days
        , delivery_days
        , days_to_approve
        , days_to_carrier
        , days_to_customer
        , delivered_on_time
    from dbt_olist_project.DBT_DEV.int_orders_fulfillment_metrics
)

-- CTE: sla_thresholds
-- Loads SLA thresholds for each fulfillment stage (approve, carrier) with effective dates.
, sla_thresholds as (
    select
        sla_type
        , threshold_days
        , effective_start_date
        , effective_end_date
    from dbt_olist_project.DBT_DEV.sla_thresholds
)

-- CTE: fulfillment_with_sla
-- Joins fulfillment events to SLA thresholds to annotate each order with the correct SLA for each stage.
, fulfillment_with_sla as (
    select
        f.order_id
        , f.customer_id
        , f.order_status
        , f.order_purchase_timestamp
        , f.order_approved_at
        , f.order_delivered_carrier_date
        , f.order_delivered_customer_date
        , f.order_estimated_delivery_date
        , f.as_of_date
        , f.delivery_window_days
        , f.delivery_days
        , f.days_to_approve
        , f.days_to_carrier
        , f.days_to_customer
        , f.delivered_on_time
        , sa.threshold_days as sla_days_to_approve
        , sc.threshold_days as sla_days_to_carrier
    from fulfillment as f
    left join sla_thresholds as sa
        on sa.sla_type = 'approve'
        and f.order_purchase_timestamp >= sa.effective_start_date
        and f.order_purchase_timestamp < sa.effective_end_date
    left join sla_thresholds as sc
        on sc.sla_type = 'carrier'
        and f.order_purchase_timestamp >= sc.effective_start_date
        and f.order_purchase_timestamp < sc.effective_end_date
)

-- Final select: Calculate SLA breaches and fulfillment delay summary for each order.
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
    , delivery_window_days
    , delivery_days
    , days_to_approve
    , days_to_carrier
    , days_to_customer
    , delivered_on_time
    , sla_days_to_approve
    , sla_days_to_carrier
    , (delivery_window_days - sla_days_to_approve - sla_days_to_carrier) as sla_days_to_last_mile -- SLA for last mile = total window - other SLAs
    , coalesce(days_to_approve > sla_days_to_approve, false) as approval_sla_breached -- Breach if approval took too long
    , coalesce(days_to_carrier > sla_days_to_carrier, false) as carrier_sla_breached -- Breach if carrier handoff took too long
    , coalesce(days_to_customer > (delivery_window_days - sla_days_to_approve - sla_days_to_carrier), false) as last_mile_sla_breached -- Breach if last mile took too long
    , case
        when order_status = 'canceled' then 'canceled'
        when order_status != 'delivered' and as_of_date <= order_estimated_delivery_date then 'in progress'
        when order_status != 'delivered' and as_of_date > order_estimated_delivery_date then 'not delivered'
        when delivered_on_time = true then 'on time'
        else
            ltrim(
                coalesce(case when days_to_approve > sla_days_to_approve then 'approval' end, '')
                || coalesce(case when days_to_carrier > sla_days_to_carrier then ', carrier' end, '')
                || coalesce(case when days_to_customer > (delivery_window_days - sla_days_to_approve - sla_days_to_carrier) then ', last mile' end, '')
                , ', '
            )
    end as fulfillment_delay_summary -- Text summary of which stages breached SLA
from fulfillment_with_sla
  );
-- created_at: 2025-07-21T23:25:06.273853+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_products_enriched
-- desc: get_relation adapter call
show objects like 'INT_PRODUCTS_ENRICHED' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:06.414792+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_products_enriched
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_products_enriched
  
   as (
    -- File: models/intermediate/int_products_enriched.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches product data with additional attributes and prepares for downstream modeling.
-- Note: Add further notes on business logic or data handling as needed.
with products as (
    select
        product_id
        , category_name
        , name_length
        , description_length
        , photos_qty
        , weight_g
        , length_cm
        , height_cm
        , width_cm
    from dbt_olist_project.DBT_DEV.stg_products
)

, category as (
    select
        product_category_name
        , category
        , subcategory
    from dbt_olist_project.DBT_DEV.stg_category_enriched
)

select
    p.product_id
    , p.category_name
    , c.category
    , c.subcategory
    , p.name_length
    , p.description_length
    , p.photos_qty
    , p.weight_g
    , p.length_cm
    , p.height_cm
    , p.width_cm
from products as p
left join category as c
    on p.category_name = c.product_category_name
  );
-- created_at: 2025-07-21T23:25:06.704066+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_zipcode_geolocation
-- desc: get_relation adapter call
show objects like 'INT_ZIPCODE_GEOLOCATION' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:06.823983+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_payments
-- desc: get_relation adapter call
show objects like 'INT_ORDER_PAYMENTS' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:06.870139+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_zipcode_geolocation
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_zipcode_geolocation
  
   as (
    -- File: models/intermediate/int_zipcode_geolocation.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches zipcode geolocation data for downstream use.
-- Note: Add further notes on business logic or data handling as needed.
with stg_geolocation as (
select
    zip_code
    , lat
    , lng
    , 
    md5(
        cast(zip_code as string)
    )
 as geolocation_key
from dbt_olist_project.DBT_DEV.stg_geolocation
)

    select
        zip_code
        , 
    md5(
        cast(zip_code as string)
    )
 as geolocation_key
        , avg(lat) as lat
        , avg(lng) as lng
    from stg_geolocation
    group by zip_code
  );
-- created_at: 2025-07-21T23:25:06.947867+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_closed_deals_enriched
-- desc: get_relation adapter call
show objects like 'INT_CLOSED_DEALS_ENRICHED' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:07.065222+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_order_payments
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_order_payments
  
   as (
    -- File: models/intermediate/int_order_payments.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches order payments data and prepares for downstream modeling.
-- Note: Add further notes on business logic or data handling as needed.
with stg_order_payments as (
    select
        order_id
        , payment_type
        , payment_value
        , payment_installments
        , payment_sequential
    from dbt_olist_project.DBT_DEV.stg_order_payments
)

, int_order_items as (
    select
        order_id
        , customer_id
        , price
        , freight_value
    from dbt_olist_project.DBT_DEV.int_order_items
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
        , order_total
        , cumulative_payment
        , payment_number
        , total_installments
    from payments
  );
-- created_at: 2025-07-21T23:25:07.086432+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_closed_deals_enriched
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_closed_deals_enriched
  
   as (
    -- File: models/intermediate/int_closed_deals_enriched.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches closed deals data with additional attributes and prepares for downstream modeling.
-- Note: Add further notes on business logic or data handling as needed.
with mql as (
    select
        mql_id
        , first_contact_date
        , landing_page_id
        , origin
        , channel
    from dbt_olist_project.DBT_DEV.int_marketing_qualified_leads
)

, closed_deals as (
    select
        seller_id
        , sdr_id
        , sr_id
        , won_date
        , business_segment
        , lead_type
        , lead_behaviour_profile
        , has_company
        , has_gtin
        , average_stock
        , business_type
        , declared_product_catalog_size
        , declared_monthly_revenue
        , mql_id
    from dbt_olist_project.DBT_DEV.stg_closed_deals
)

, sellers as (
    select
        seller_id
        , seller_city
        , seller_state
        , seller_zip_code
    from dbt_olist_project.DBT_DEV.stg_sellers
)

select
    mql.mql_id
    , mql.first_contact_date
    , mql.landing_page_id
    , mql.origin
    , mql.channel
    , closed_deals.seller_id
    , closed_deals.sdr_id
    , closed_deals.sr_id
    , closed_deals.won_date
    , closed_deals.business_segment
    , closed_deals.lead_type
    , closed_deals.lead_behaviour_profile
    , closed_deals.has_company
    , closed_deals.has_gtin
    , closed_deals.average_stock
    , closed_deals.business_type
    , closed_deals.declared_product_catalog_size
    , closed_deals.declared_monthly_revenue
    , sellers.seller_city
    , sellers.seller_state
    , sellers.seller_zip_code
    , coalesce(closed_deals.has_company, false) as has_company_flag
    , coalesce(closed_deals.has_gtin, false) as has_gtin_flag
from mql
left join closed_deals
    on mql.mql_id = closed_deals.mql_id
left join sellers
    on closed_deals.seller_id = sellers.seller_id
  );
-- created_at: 2025-07-21T23:25:07.268054+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_fulfillment
-- desc: get_relation adapter call
show objects like 'INT_ORDERS_FULFILLMENT' in schema dbt_olist_project.DBT_DEV;
-- created_at: 2025-07-21T23:25:07.434481+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.int_orders_fulfillment
-- desc: execute adapter call
create or replace   view dbt_olist_project.DBT_DEV.int_orders_fulfillment
  
   as (
    -- File: models/intermediate/int_orders_fulfillment.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates fulfillment status and related metrics for each order.

with int_orders_fulfillment_metrics as (
    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date
        , delivery_window_days
        , days_to_approve
        , days_to_carrier
        , days_to_customer
        , delivery_days
        , delivered_on_time
    from dbt_olist_project.DBT_DEV.int_orders_fulfillment_metrics
)

, int_orders_fulfillment_benchmarks as (
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
        , delivery_window_days
        , delivery_days
        , days_to_approve
        , days_to_carrier
        , days_to_customer
        , delivered_on_time
        , sla_days_to_approve
        , sla_days_to_carrier
        , sla_days_to_last_mile
        , approval_sla_breached
        , carrier_sla_breached
        , last_mile_sla_breached
        , fulfillment_delay_summary
    from dbt_olist_project.DBT_DEV.int_orders_fulfillment_benchmarks
)

    select
        int_orders_fulfillment_metrics.order_id
        , int_orders_fulfillment_metrics.customer_id
        , int_orders_fulfillment_metrics.order_status
        , int_orders_fulfillment_metrics.order_purchase_timestamp
        , int_orders_fulfillment_metrics.order_approved_at
        , int_orders_fulfillment_metrics.order_delivered_carrier_date
        , int_orders_fulfillment_metrics.order_delivered_customer_date
        , int_orders_fulfillment_metrics.order_estimated_delivery_date
        , int_orders_fulfillment_metrics.delivery_window_days
        , int_orders_fulfillment_metrics.days_to_approve
        , int_orders_fulfillment_metrics.days_to_carrier
        , int_orders_fulfillment_metrics.days_to_customer
        , int_orders_fulfillment_metrics.delivery_days
        , int_orders_fulfillment_metrics.delivered_on_time
        , int_orders_fulfillment_benchmarks.sla_days_to_approve
        , int_orders_fulfillment_benchmarks.sla_days_to_carrier
        , int_orders_fulfillment_benchmarks.sla_days_to_last_mile
        , int_orders_fulfillment_benchmarks.approval_sla_breached
        , int_orders_fulfillment_benchmarks.carrier_sla_breached
        , int_orders_fulfillment_benchmarks.last_mile_sla_breached
        , int_orders_fulfillment_benchmarks.fulfillment_delay_summary
    from int_orders_fulfillment_metrics
    left join int_orders_fulfillment_benchmarks
    on int_orders_fulfillment_metrics.order_id = int_orders_fulfillment_benchmarks.order_id
  );
