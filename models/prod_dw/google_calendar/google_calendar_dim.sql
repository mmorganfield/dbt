WITH int_google_calendar AS (
    SELECT * FROM {{ source('dev_intermediate', 'int_google_calendar_dim')}}
)

SELECT * 
FROM int_google_calendar 
WHERE unique_key IS NOT NULL