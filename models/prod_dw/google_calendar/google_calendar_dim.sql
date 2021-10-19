WITH int_google_calendar AS (
    SELECT * FROM {{ ref( 'int_google_calendar_dim')}}
)

SELECT * 
FROM int_google_calendar 
WHERE primary_key IS NOT NULL