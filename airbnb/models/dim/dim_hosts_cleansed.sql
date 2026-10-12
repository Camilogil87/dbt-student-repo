WITH src_hosts AS (
    SELECT
        *
    FROM
        {{ ref('src_hosts') }}
)
SELECT
    host_id,
    NVL(  -- NVL es una función que reemplaza valores nulos con un valor predeterminado. Es una funcion nativa que se puede usar en snowflake
        host_name,
        'Anonymous'
    ) AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    src_hosts