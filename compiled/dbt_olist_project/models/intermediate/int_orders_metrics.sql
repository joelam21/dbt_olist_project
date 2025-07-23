-- File: models/intermediate/int_orders_metrics.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Calculates order-level metrics for downstream analysis.
with order_items as (
    select
        order_id
        , price
        , freight_value
    from dbt_olist_project.dbt_prod.stg_order_items
)

    select
        order_id
        , count(*) as num_items
        , sum(price) as price_total
        , sum(freight_value) as freight_total
        , sum(price + freight_value) as order_total
    from order_items
    group by order_id