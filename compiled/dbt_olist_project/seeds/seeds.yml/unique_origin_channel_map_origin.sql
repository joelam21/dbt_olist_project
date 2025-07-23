
    
    

select
    origin as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.origin_channel_map
where origin is not null
group by origin
having count(*) > 1


