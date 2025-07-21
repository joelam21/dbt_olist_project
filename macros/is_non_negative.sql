{% macro test_is_non_negative(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} < 0
{% endmacro %}
