
  create or replace   view dbt_olist_project.DBT_DEV.int_marketing_qualified_leads
  
  
  
  
  as (
    with mql as (
    select
        mql_id
        , first_contact_date
        , landing_page_id
        , origin
    from dbt_olist_project.DBT_DEV.stg_marketing_qualified_leads
),
origin_channel as (
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

