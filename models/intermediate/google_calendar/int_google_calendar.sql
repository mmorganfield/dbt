WITH stg_google_calendar AS (
    SELECT * FROM {{ source( 'dev_staging', 'stg_google_calendar') }}
),

stg_google_calendar_dates AS (
    SELECT stg_google_calendar.*
    ,COALESCE(end_datetime, default_end_date) AS end_time
    ,COALESCE(start_datetime, default_start_date) AS start_time
    FROM stg_google_calendar
)

SELECT DISTINCT * FROM (
    SELECT 

        CAST(FORMAT_TIMESTAMP("%Y%m%d", start_time) AS INT64 ) AS date_key
        ,location
        ,description
        -- ,event_recurrence
        ,event_timezone
        ,end_time
        ,DATE(end_time) AS end_date
        ,start_time
        ,DATE(start_time) AS start_date
        ,event_attendees_name
        ,event_attendees_email
        ,event_attendees_response_status
        ,event_summary
        ,event_updated_time
        ,event_created_time
        ,organizer_name
        ,CASE 
            WHEN is_organizer_self
                THEN 1
            WHEN is_organizer_self IS NULL 
                THEN 0
            ELSE 0
            END
            AS is_organizer_self_ind
        ,organizer_email
        ,_record_create_dt -- this is meaningless in a view, but for example
        ,unique_key 
        
    FROM stg_google_calendar_dates
) 
