{{ config(
    materialized='view',
    meta={
        'owner': 'data-team@olist.com',
        'maturity': 'high',
        'update_frequency': 'daily',
        'business_domain': 'ecommerce'
    }
) }}

with source_data as (

    select
        order_id
        , customer_id
        , order_status
        , order_purchase_timestamp
        , order_approved_at
        , order_delivered_carrier_date
        , order_delivered_customer_date
        , order_estimated_delivery_date

    from {{ ref('orders') }}

)

, cleaned_data as (

    select
        -- Primary key
        order_id

        -- Foreign keys
        , customer_id

        -- Order status and workflow
        , order_status
        , order_purchase_timestamp as order_created_at

        -- Timestamps (standardized naming)
        , order_approved_at
        , order_delivered_carrier_date as order_shipped_at
        , order_delivered_customer_date as order_delivered_at
        , order_estimated_delivery_date
        , coalesce(order_status in ('delivered', 'shipped'), false) as is_order_completed

        -- Derived business fields
        , extract(year from order_purchase_timestamp) as order_year
        , extract(month from order_purchase_timestamp) as order_month
        , extract(day from order_purchase_timestamp) as order_day
        , extract(dayofweek from order_purchase_timestamp) as order_day_of_week
        , date_trunc('day', order_purchase_timestamp) as order_date

        -- Delivery performance metrics
        , case
            when
                order_delivered_customer_date is not null
                and order_estimated_delivery_date is not null
                then datediff(
                    day
                    , order_estimated_delivery_date
                    , order_delivered_customer_date
                )
        end as delivery_delay_days

        , case
            when
                order_delivered_customer_date is not null
                and order_purchase_timestamp is not null
                then datediff(
                    day
                    , order_purchase_timestamp
                    , order_delivered_customer_date
                )
        end as total_delivery_days

        -- Business status categorization
        , case
            when order_status = 'delivered' then 'completed'
            when order_status in ('shipped', 'processing', 'approved') then 'in_progress'
            when order_status = 'cancelled' then 'cancelled'
            else 'created'
        end as order_status_category

    from source_data

)

, final as (

    select
        -- Primary identifiers
        order_id
        , customer_id

        -- Order workflow
        , order_status
        , order_status_category
        , is_order_completed

        -- Timestamp fields
        , order_created_at
        , order_approved_at
        , order_shipped_at
        , order_delivered_at
        , order_estimated_delivery_date

        -- Date dimensions
        , order_date
        , order_year
        , order_month
        , order_day
        , order_day_of_week

        -- Performance metrics
        , delivery_delay_days
        , total_delivery_days

        -- Data quality flags
        , coalesce(order_delivered_at is not null and order_shipped_at is null, false)
            as has_missing_ship_date

        , coalesce(delivery_delay_days > 30, false) as is_severely_delayed

    from cleaned_data

)

select * from final
