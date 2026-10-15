{% macro select_positive_values(model, column_name) %} -- esta macro recibe un modelo y un nombre de columna como parámetros y devuelve todas las filas del modelo. 
    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} > 0
{% endmacro %}