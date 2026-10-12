WITH raw_hosts AS (
    SELECT
        *
    FROM
        {{ source('airbnb', 'hosts') }}
) --Luego de renombrar este modelo en el archivo source.yml puedo referenciar la tabla usando source() y el alias que le di en el archivo
SELECT
    id as host_id,
    name as host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts