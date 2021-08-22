WITH stg_google_calendar AS
(
    SELECT * FROM {{ source('dev_base', 'base_google_calendar') }}
)

SELECT * FROM stg_google_calendar