-- created_at: 2025-07-22T04:05:39.938864+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.dim_dates
-- desc: execute adapter call
select datediff(
        day,
        cast('2016-01-01' as date),
        cast('2025-12-31' as date)
        );
