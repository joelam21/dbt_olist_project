-- File: models/staging/stg_marketing_qualified_leads.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages marketing qualified leads (MQL) data from the raw layer for downstream modeling.
-- Note: No transformations are applied; this model standardizes naming and structure for consistency.
-- Primary key: mql_id

with source as (
    select * from {{ source('raw', 'marketing_qualified_leads') }}
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
