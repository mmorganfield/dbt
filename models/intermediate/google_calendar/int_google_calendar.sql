WITH stg_google_calendar AS (
    SELECT * FROM {{ source( 'dev_staging', 'stg_google_calendar') }}
),

stg_google_calendar_dates AS (
    SELECT stg_google_calendar.*
    ,COALESCE(end_datetime, default_end_date) AS end_time
    ,COALESCE(start_datetime, default_start_date) AS start_time
    FROM stg_google_calendar
)

SELECT 

* FROM stg_google_calendar_dates