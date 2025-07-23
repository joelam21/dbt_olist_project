
    
    

select
    review_key as unique_field,
    count(*) as n_records

from dbt_olist_project.dbt_prod.stg_order_reviews
where review_key is not null
group by review_key
having count(*) > 1


