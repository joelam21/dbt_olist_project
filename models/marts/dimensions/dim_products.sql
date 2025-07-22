select
    product_id
    , category
    , subcategory
    , name_length
    , description_length
    , photos_qty
    , weight_g
    , length_cm
    , height_cm
    , width_cm
from {{ ref('int_products_enriched') }}
