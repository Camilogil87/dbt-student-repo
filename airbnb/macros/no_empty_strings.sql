{% macro no_empty_strings(model) %}
    {%- for col in adapter.get_columns_in_relation(model) -%}  -- Adapter permite interactuar con la base de datos y obtener información sobre las columnas. 
        {%- if col.is_string() -%} -- Verifica si la columna es de tipo string
            {{ col.name }} IS NOT NULL AND {{ col.name }} <> '' AND -- Las condiciones de filtrado aseguran que la columna no sea nula y no esté vacía
        {%- endif -%}
    {%- endfor -%}
    TRUE  -- Esta línea asegura que la cláusula WHERE siempre sea verdadera si no hay columnas de tipo string, evitando errores de sintaxis.
{%- endmacro -%}