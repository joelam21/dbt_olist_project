
    
    

select
    zip_code as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.int_zipcode_geolocation
where zip_code is not null
group by zip_code
having count(*) > 1


