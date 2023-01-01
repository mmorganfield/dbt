WITH stg_county_cases AS (
    SELECT 
        *
    FROM 
        {{ ref( 'stg_county_cases') }}
)

SELECT DISTINCT * FROM stg_county_cases