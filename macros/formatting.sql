{% macro pad_zip(zip_column, length=5) %}
    lpad(cast({{ zip_column }} as string), {{ length }}, '0')
{% endmacro %}
