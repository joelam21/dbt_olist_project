-- mql, not null
select
    mql_id
    , first_contact_date
    , landing_page_id
    , origin
    , channel
    -- closed deals, many nulls
    , seller_id
    , sdr_id
    , sr_id
    , business_segment
    , lead_type
    , lead_behaviour_profile
    , has_company
    , has_gtin
    , average_stock
    , business_type
from dbt_olist_project.DBT_DEV.int_closed_deals_enriched