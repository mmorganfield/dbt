WITH stg_google_calendar AS (
    SELECT * FROM {{ source('dev_staging', 'stg_google_calendar')}}
),

SELECT 