-- macros/treat_zeroes.sql
{% macro treat_zeroes(value) %}
    CASE
        WHEN {{ value }} < 0 THEN 0
        ELSE {{ value }}
    END
{% endmacro %}