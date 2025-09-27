--{% macro no_nulls_in_columns(model) %}
--    SELECT * FROM {{ model }} WHERE
--    {% for col in adapter.get_columns_in_relation(model) %}
--        {{ col.column }} IS NULL OR
--    {% endfor %}
--    FALSE
--{% endmacro %}

{% macro no_nulls_in_columns(model) %}
select *
from {{ model }}
where
  {% for col in adapter.get_columns_in_relation(model) %}
    {{ col.name }} is null{% if not loop.last %} or{% endif %}
  {% endfor %}
{% endmacro %}
