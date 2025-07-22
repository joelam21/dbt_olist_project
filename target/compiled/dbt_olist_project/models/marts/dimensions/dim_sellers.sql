-- filepath: models/marts/dimensions/dim_sellers.sql
with base as (
    select
        seller_id
        , seller_zip_code
        , seller_city
        , seller_state
    from dbt_olist_project.DBT_DEV.stg_sellers
)
select
    b.seller_id
    , b.seller_zip_code
    , b.seller_city
    , b.seller_state
    , g.lat as seller_lat
    , g.lng as seller_lng
from base as b
left join dbt_olist_project.DBT_DEV.int_zipcode_geolocation as g
    on b.seller_zip_code = g.zip_code