
    
    

select
    origin as unique_field,
    count(*) as n_records

from dbt_olist_project.DBT_DEV.origin_channel_map
where origin is not null
group by origin
having count(*) > 1


