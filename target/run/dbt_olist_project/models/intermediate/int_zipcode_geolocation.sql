
  create or replace   view dbt_olist_project.DBT_DEV.int_zipcode_geolocation
  
  
  
  
  as (
    with stg_geolocation as (
select
    zip_code
    , lat
    , lng
    , 
    md5(
        cast(zip_code as string)
    )
 as geolocation_key
from dbt_olist_project.DBT_DEV.stg_geolocation
)
select
    zip_code
    , 
    md5(
        cast(zip_code as string)
    )
 as geolocation_key
    , avg(lat) as lat
    , avg(lng) as lng
from stg_geolocation
group by zip_code
  );

