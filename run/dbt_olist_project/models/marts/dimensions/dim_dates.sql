
  
    

create or replace transient table dbt_olist_project.dbt_prod.dim_dates
    
  (
    date_day date,
    year integer,
    month integer,
    day integer,
    quarter integer,
    week integer,
    day_of_week integer,
    is_weekend boolean,
    is_month_start boolean,
    is_month_end boolean,
    day_abbr TEXT,
    month_abbr TEXT
    
    )

    
    
    
    as (
    select date_day, year, month, day, quarter, week, day_of_week, is_weekend, is_month_start, is_month_end, day_abbr, month_abbr
    from (
        -- File: models/marts/dimensions/dim_dates.sql
-- materialization is set to 'table' in this model due to heavy processing and performance considerations
-- (see dbt_project.yml under `models:` or `models.marts:`)
-- remove or override this at the model level only if needed
-- Purpose: Date dimension table for analytics, providing calendar attributes and flags for reporting.
-- Note: Uses dbt_utils.date_spine to generate a continuous date range and enriches with date parts and flags.



with date_spine as (
    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
    
    

    )

    select *
    from unioned
    where generated_number <= 3652
    order by generated_number



),

all_periods as (

    select (
        

    dateadd(
        day,
        row_number() over (order by 1) - 1,
        cast('2016-01-01' as date)
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast('2025-12-31' as date)

)

select * from filtered


)

select
    date_day
    , cast(extract(year from date_day) as number(38, 0)) as year
    , cast(extract(month from date_day) as number(38, 0)) as month
    , cast(extract(day from date_day) as number(38, 0)) as day
    , cast(extract(quarter from date_day) as number(38, 0)) as quarter
    , cast(extract(week from date_day) as number(38, 0)) as week
    , cast(extract(dow from date_day) as number(38, 0)) as day_of_week
    , (extract(dow from date_day) in (6, 0)) as is_weekend
    , date_trunc('month', date_day) = date_day as is_month_start
    , last_day(date_day) = date_day as is_month_end
    , to_char(date_day, 'DY') as day_abbr
    , to_char(date_day, 'MON') as month_abbr
from date_spine
    ) as model_subq
    )
;


  