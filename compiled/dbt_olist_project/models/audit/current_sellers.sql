-- models/audit/current_sellers.sql
-- Purpose: Returns only the current (active) version of each seller from the SCD2 snapshot table.
-- Usage: Use this model to join with fact tables or for reporting on the latest seller attributes.
-- Logic: Filters for records where dbt_valid_to IS NULL, which indicates the current version in SCD2.

select *
from dbt_olist_project.snapshots.sellers_snapshot
where dbt_valid_to is null