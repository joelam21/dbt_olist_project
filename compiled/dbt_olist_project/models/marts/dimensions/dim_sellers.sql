-- filepath: models/marts/dimensions/dim_sellers.sql
with base as (
    select
        seller_id
        , seller_zip_code
        , seller_city
        , seller_state
    from dbt_olist_project.dbt_prod.stg_sellers
)
select
    b.seller_id
    , b.seller_zip_code
    , b.seller_city
    , b.seller_state
    , cast(g.lat as float) as seller_lat
    , cast(g.lng as float) as seller_lng
from base as b
left join dbt_olist_project.dbt_prod.int_zipcode_geolocation as g
    on b.seller_zip_code = g.zip_code