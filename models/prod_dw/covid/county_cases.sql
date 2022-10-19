WITH int_county_cases AS (
    SELECT * FROM {{ ref( 'stg_county_cases') }}
)

SELECT DISTINCT * FROM int_county_cases