select
    mql_id
    , seller_id
    , cast(won_date as date) as won_date
    , (won_date is not null) as is_won
from dbt_olist_project.DBT_DEV.int_closed_deals_enriched