{#
    pad_zip

    Pads a zip code column with leading zeros to a specified length (default 5).
    Useful for standardizing zip code formats for joins and reporting.

    Args:
        zip_column (string or expression): The column or value to pad.
        length (integer, optional): Desired length of the output string. Default is 5.

    Example:
        {{ pad_zip('geolocation_zip_code_prefix', 8) }}
#}
{% macro pad_zip(zip_column, length=5) %}
    lpad(cast({{ zip_column }} as string), {{ length }}, '0')
{% endmacro %}
