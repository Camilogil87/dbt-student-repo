WITH raw_listings AS (
    SELECT
        *
    FROM
        {{ source('airbnb', 'listings') }}
) --Luego de renombrar este modelo en el archivo source.yml puedo referenciar la tabla usando source() y el alias que le di en el archivo
SELECT
    id AS listing_id,
    name AS listing_name,
    listing_url,
    room_type,
    minimum_nights,
    host_id,
    price AS price_str,
    created_at,
    updated_at
FROM
    raw_listings