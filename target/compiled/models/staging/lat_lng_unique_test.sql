select
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0') as zip_code
  , geolocation_lat as lat
  , geolocation_lng as lng
  , geolocation_city as city
  , geolocation_state as state
  , count(*) as cnt
from dbt_olist_project.raw.geolocation
group by
    lpad(cast(geolocation_zip_code_prefix as string), 5, '0')
  , geolocation_lat
  , geolocation_lng
  , geolocation_city
  , geolocation_state
having count(*) > 1