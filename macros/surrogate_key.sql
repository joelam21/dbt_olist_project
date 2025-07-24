{#
    generate_surrogate_key

    Generates a deterministic surrogate key by hashing one or more columns.
    Accepts a single column (string) or a list of columns, concatenates them with a pipe delimiter, and returns an MD5 hash.
    Useful for SCD Type 2 models, deduplication, and joining on composite keys.

    Args:
        cols (string or list): Column name or list of column names to include in the key.

    Example:
        -- Single column
        {{ generate_surrogate_key('order_id') }}
        -- Multiple columns
        {{ generate_surrogate_key(['order_id', 'product_id', 'order_item_id']) }}
#}
{% macro generate_surrogate_key(cols) %}
    md5(
        {% if cols is string %}
            cast({{ cols }} as string)
        {% else %}
            {%- for col in cols -%}
                {%- if not loop.first %} || '|' || {% endif -%}
                cast({{ col }} as string)
            {%- endfor -%}
        {% endif %}
    )
{% endmacro %}
