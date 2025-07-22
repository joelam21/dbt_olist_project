{% macro rounded_remaining_balance(order_total, cumulative_payment, precision=2) %}
    ROUND(
        COALESCE({{ order_total }}, 0) - COALESCE({{ cumulative_payment }}, 0),
        {{ precision }}
    )
{% endmacro %}
