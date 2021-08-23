WITH int_google_calendar AS (
    SELECT * FROM {{ source('dev_intermediate', 'int_google_calendar')}}
)

SELECT * FROM int_google_calendar