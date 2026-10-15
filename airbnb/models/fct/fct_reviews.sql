-- Configuración de materialización incremental.
-- En caso de que haya un cambio en el esquema, la ejecución del modelo fallará.
-- Puedes incluir incremental_strategy dentro de la configuración y definir la unique_key.
{{
  config(
    materialized='incremental',
    on_schema_change='fail'
  )
}}

WITH src_reviews AS (
  -- Referenciamos el modelo src_reviews, que contiene los datos crudos de las reseñas.
  SELECT * FROM {{ ref('src_reviews') }}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} AS review_id,
  *
FROM src_reviews
WHERE review_text IS NOT NULL

{% if is_incremental() %}
  -- is_incremental() verifica si el modelo se está ejecutando de manera incremental.
  -- Solo seleccionamos las reseñas con una fecha posterior a la fecha máxima
  -- de las reseñas que ya existen en la tabla de destino.
  -- this hace referencia al modelo actual, en este caso fct_reviews.
  AND review_date > (
    SELECT MAX(review_date)
    FROM {{ this }}
  )
{% endif %}