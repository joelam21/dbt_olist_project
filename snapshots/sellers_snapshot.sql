-- sellers_snapshot.sql
-- Purpose: SCD Type 2 snapshot to track changes to seller attributes (zip code, city, state) over time
-- Source: stg_sellers
-- Maintainer: joelam21 | Created: 2025-07-28

{% snapshot sellers_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='seller_id',
        strategy='check',
        check_cols=['seller_zip_code', 'seller_city', 'seller_state'],
        invalidate_hard_deletes=True
    )
}}

select
    seller_id
    , seller_zip_code
    , seller_city
    , seller_state
from {{ ref('stg_sellers') }}

{% endsnapshot %}
