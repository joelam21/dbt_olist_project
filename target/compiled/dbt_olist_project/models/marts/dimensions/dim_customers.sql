-- filepath: models/dimensions/dim_customers.sql
with base as (
    select
        customer_id as customer_order_id
        , customer_unique_id as customer_id
        , customer_zip_code
        , customer_city
        , customer_state
    from dbt_olist_project.DBT_DEV.stg_customers
)

select
    b.customer_order_id
    , b.customer_id
    , b.customer_zip_code
    , b.customer_city
    , b.customer_state
    , g.lat as customer_lat
    , g.lng as customer_lng
from base as b
left join dbt_olist_project.DBT_DEV.int_zipcode_geolocation as g
    on b.customer_zip_code = g.zip_code