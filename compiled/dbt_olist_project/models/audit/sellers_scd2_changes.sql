-- Purpose: Identify sellers with SCD2 changes (multiple versions) in the sellers_snapshot table
-- Best practice: Use a CTE for windowed counts, select all SCD2 fields, and add a row_number for change tracking

with sellers_snapshot as (
  select
      seller_id
    , seller_zip_code
    , seller_city
    , seller_state
    , dbt_valid_from
    , dbt_valid_to
    , count(*) over (partition by seller_id) as seller_id_ct
    , row_number() over (partition by seller_id order by dbt_valid_from) as version_num
  from dbt_olist_project.snapshots.sellers_snapshot
)

select
    seller_id
  , seller_zip_code
  , seller_city
  , seller_state
  , dbt_valid_from as valid_from
  , dbt_valid_to as valid_to
  , version_num
  , seller_id_ct
from sellers_snapshot
where seller_id_ct > 1
order by seller_id, dbt_valid_from