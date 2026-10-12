--Configuracion de materializacion incremental
--En caso de que haya un cambio en el esquema, la ejecucion del modelo fallara
-- Puedes incluir incremental_strategy dentro de la configuracion y definir la unique_key.
{{ 
  config(
    materialized = 'incremental', 
    on_schema_change='fail' 
    ) 

}}
WITH src_reviews AS (
  SELECT * FROM {{ ref('src_reviews') }} -- Referenciamos el modelo src_reviews que contiene los datos crudos de las reseñas
)
SELECT * FROM src_reviews
WHERE review_text is not null

{% if is_incremental() %} -- is_incremental() es una función que verifica si el modelo se está ejecutando de manera incremental
  AND review_date > (select max(review_date) from {{ this }}) -- Si el modelo se está ejecutando de manera incremental, 
  -- solo seleccionamos las reseñas que tienen una fecha de reseña mayor a la fecha máxima de reseña en el modelo actual
{% endif %} -- el this es una variable que hace referencia al modelo actual, en este caso fct_reviews