WITH base_google_calendar AS
(
    SELECT * FROM {{ source('dev_base', 'base_google_calendar') }}
)

SELECT 

     items.source.title AS source_title
    ,items.source.url AS source_url
    ,items.location AS location
    ,items.description AS description
    ,items.recurrence AS event_recurrence
    ,items.end.timeZone AS event_timezone
    ,items.end.dateTime AS end_datetime
    ,TIMESTAMP(items.end.date) AS default_end_date
    ,items.start.dateTime AS start_datetime
    ,TIMESTAMP(items.start.date) AS default_start_date
    ,attendees.displayName AS event_attendees_name
    ,attendees.email AS event_attendees_email
    ,attendees.responseStatus AS event_attendees_response_status
    ,items.summary AS event_summary
    ,items.updated AS event_updated_time
    ,items.created AS event_created_time
    ,items.organizer.displayName AS organizer_name
    ,items.organizer.self AS is_organizer_self
    ,items.organizer.email AS organizer_email
    ,id AS event_id
    ,nextSyncToken AS google_next_sync_token
    ,CURRENT_TIMESTAMP() AS _record_create_dt

FROM base_google_calendar
,UNNEST(items) AS items
,UNNEST(attendees) AS attendees
