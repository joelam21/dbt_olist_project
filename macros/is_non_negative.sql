{#
    test_is_non_negative

    A generic test macro that checks if a column contains any negative values.
    Returns all rows where the specified column is less than zero.

    Args:
        model (relation): The dbt model or table to test.
        column_name (string): The column to check for negative values.

    Example:
        -- In schema.yml
        tests:
          - is_non_negative
#}
{% macro test_is_non_negative(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} < 0
{% endmacro %}
