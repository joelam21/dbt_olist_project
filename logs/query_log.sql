-- created_at: 2025-07-31T20:17:04.093245+00:00
-- dialect: snowflake
-- node_id: model.dbt_olist_project.dim_dates
-- desc: execute adapter call
select datediff(
        day,
        cast('2016-01-01' as date),
        cast('2025-12-31' as date)
        );
