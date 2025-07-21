-- File: models/intermediate/int_marketing_qualified_leads.sql
-- Materialization is configured at the directory or project level (see dbt_project.yml under `models:` or `models.intermediate:`)
-- Remove or override this at the model level only if needed
-- Purpose: Enriches marketing qualified leads data and prepares for downstream modeling.
with mql as (
    select
        mql_id
        , first_contact_date
        , landing_page_id
        , origin
    from {{ ref('stg_marketing_qualified_leads') }}
)

, origin_channel as (
    select
        origin
        , channel
    from {{ ref('origin_channel_map') }}
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
