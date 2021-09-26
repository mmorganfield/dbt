WITH base_county_cases AS (
    SELECT * FROM {{ source('covid_cases', 'us_counties') }}
)

SELECT * FROM base_county_cases