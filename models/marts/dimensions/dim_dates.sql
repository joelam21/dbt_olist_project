-- File: models/marts/dimensions/dim_dates.sql
-- materialization is set to 'table' in this model due to heavy processing and performance considerations
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Date dimension table for analytics, providing calendar attributes and flags for reporting.
-- Note: Uses dbt_utils.date_spine to generate a continuous date range and enriches with date parts and flags.

{{ config(materialized='table') }}

with date_spine as (
    {{ dbt_utils.date_spine(
        'day'
        , "cast('2016-01-01' as date)"
        , "cast('2025-12-31' as date)"
    ) }}
)

select
    date_day
    , extract(year from date_day) as year
    , extract(month from date_day) as month
    , extract(day from date_day) as day
    , extract(quarter from date_day) as quarter
    , extract(week from date_day) as week
    , extract(dow from date_day) as day_of_week
    , (extract(dow from date_day) in (6, 0)) as is_weekend
    , date_trunc('month', date_day) = date_day as is_month_start
    , last_day(date_day) = date_day as is_month_end
    , to_char(date_day, 'DY') as day_abbr
    , to_char(date_day, 'MON') as month_abbr
    -- add more fields as needed
from date_spine
