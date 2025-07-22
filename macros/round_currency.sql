{% macro round_currency(value) %}
    round({{ value }}, 2)
{% endmacro %}
