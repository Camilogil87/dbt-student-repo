SELECT
    r.listing_id,
    r.review_date,
    l.created_at
FROM {{ ref('fct_reviews') }} AS r
INNER JOIN {{ ref('dim_listings_cleansed') }} AS l
    ON r.listing_id = l.listing_id
WHERE r.review_date < l.created_at