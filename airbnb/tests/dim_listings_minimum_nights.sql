SELECT * FROM {{ ref('dim_listings_cleansed') }}
WHERE minimum_nights < 1
LIMIT 10 -- Filtra los registros de la tabla dim_listings donde el valor de minimum_nights es menor a 1 y limita el resultado a 10 errores.