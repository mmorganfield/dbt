WITH int_county_cases AS (
    SELECT * FROM {{ source('dev_intermediate', 'int_county_cases') }}
)

SELECT DISTINCT * FROM int_county_cases