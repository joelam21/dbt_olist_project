
  create or replace   view dbt_olist_project.DBT_DEV.stg_order_reviews
  
  
  
  
  as (
    -- File: models/staging/stg_order_reviews.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- Purpose: Stages order reviews data from the raw layer, generating a surrogate key for uniqueness and preparing for downstream modeling.
-- Note: In the raw data, review_id is not unique because the same review can be associated with multiple orders. This model generates a surrogate key using both review_id and order_id to ensure uniqueness.
-- Primary key: review_key (generated from review_id, order_id)

with source as (
    select *
    from dbt_olist_project.raw.order_reviews
)

, stg_order_reviews as (
    select
        
    md5(
        cast(review_id as string) || '|' || cast(order_id as string)
    )
 as review_key
        , review_id
        , order_id
        , review_score
        , review_comment_title
        , review_comment_message
        , review_creation_date
        , review_answer_timestamp
    from source
)

select *
from stg_order_reviews
  );

