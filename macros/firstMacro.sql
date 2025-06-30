{% macro greet_user(name) %}
    {% do log("Hello, " ~ name ~ "!", info=True) %}
{% endmacro %}