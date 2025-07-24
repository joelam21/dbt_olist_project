{#
    round_currency

    Rounds a numeric value to two decimal places, typically for currency formatting.
    Ensures consistent financial reporting and display.

    Args:
        value (numeric or expression): The value to round.

    Example:
        {{ round_currency('order_total') }}
#}
{% macro round_currency(value) %}
    round({{ value }}, 2)
{% endmacro %}
