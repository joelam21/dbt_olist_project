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
