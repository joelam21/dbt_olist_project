{#
    rounded_remaining_balance

    Returns the rounded remaining balance for an order by subtracting cumulative payments from the order total.
    Handles nulls as zero and allows configurable decimal precision.

    Args:
        order_total (numeric or expression): The total value of the order.
        cumulative_payment (numeric or expression): The sum of payments made toward the order.
        precision (integer, optional): Number of decimal places to round to. Default is 2.

    Example:
        {{ rounded_remaining_balance('order_total', 'cumulative_payment', 2) }}
#}
{% macro rounded_remaining_balance(order_total, cumulative_payment, precision=2) %}
    ROUND(
        COALESCE({{ order_total }}, 0) - COALESCE({{ cumulative_payment }}, 0),
        {{ precision }}
    )
{% endmacro %}
