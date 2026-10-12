WITH src_listings AS (
  SELECT
    *
  FROM
    {{ ref('src_listings') }}
)
SELECT
  listing_id,
  listing_name,
  room_type,
  CASE
    WHEN minimum_nights = 0 THEN 1 -- Si el minimo de noches es 0 lo reemplazamos por 1 para evitar errores en el modelo
    ELSE minimum_nights
  END AS minimum_nights,
  host_id,
  REPLACE(
    price_str,  -- Eliminamos el símbolo de dólar y lo convertimos a número
    '$'
  ) :: NUMBER(  -- Los dos puntos significan que estamos casteando el valor a un tipo de dato específico, en este caso un NUMBER
    10, -- Definimos el tamaño del número
    2
  ) AS price,
  created_at,
  updated_at
FROM
  src_listings