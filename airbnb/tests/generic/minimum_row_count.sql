{% test minimum_row_count(model, min_row_count) %} -- en lugar de definir una columna, este test evalue el número de filas en la tabla.

SELECT COUNT(*) AS row_count FROM {{ model }} -- El test fallará si el número de filas es menor que el valor de min_row_count.

HAVING COUNT(*) < {{ min_row_count }}

{% endtest %}