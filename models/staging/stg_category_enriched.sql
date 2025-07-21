-- File: models/staging/stg_category_enriched.sql
-- materialization is configured at the directory or project level
-- (see dbt_project.yml under `models:` or `models.staging:`)
-- remove or override this at the model level only if needed
-- NOTE:
-- We are referencing the 'categories' and 'category_translation' seeds directly in this staging model.
-- No base models are created for these seeds because the data is already clean and well-structured.
-- If future cleaning or renaming is needed, consider introducing base models at that time.

select
    categories.category
    , category_translation.product_category_name_english as subcategory
    , category_translation.product_category_name
    , iff(
        category_translation.product_category_name_english is not null
        , true
        , false
    )
        as is_translated
from {{ ref('category_translation') }} as category_translation
left join {{ ref('categories') }} as categories
    on
        category_translation.product_category_name_english
        = categories.subcategory
