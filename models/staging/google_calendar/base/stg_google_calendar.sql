WITH base_google_calendar AS
(
    SELECT * FROM {{ source('dev_sandbox', 'google_calendar_test') }}
)

SELECT * FROM base_google_calendar