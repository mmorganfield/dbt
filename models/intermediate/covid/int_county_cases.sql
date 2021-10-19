WITH stg_county_cases AS (
    
    SELECT * FROM {{ ref('stg_county_cases')}}

), int_county_cases AS (
    SELECT
        FORMAT_DATE("%Y%m%d", date) AS date_key
        ,date
        ,county 
        ,state_name 
        ,county_fips_code 
        ,confirmed_cases AS running_total_cases
        ,confirmed_cases - LAG(confirmed_cases)
            OVER (PARTITION BY county ORDER BY date ASC) AS new_cases
        ,deaths AS running_total_deaths
        ,deaths - LAG(deaths)
            OVER (PARTITION BY county ORDER BY date ASC) AS new_deaths
    FROM stg_county_cases
)

SELECT 
      int_county_cases.*
      ,FARM_FINGERPRINT(CONCAT(date_key, county)) AS unique_key
FROM int_county_cases