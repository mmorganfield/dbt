WITH base_county_cases AS (
    
    SELECT * FROM {{ source('covid_cases', 'us_counties')}}

), stg_county_cases AS (
    SELECT
        FORMAT_DATE("%Y%m%d", date)                as date_key
        ,date                                      as case_date
        ,county                                    as case_county 
        ,state_name                                as case_state_name
        ,county_fips_code                          as case_county_fips_code 
        ,confirmed_cases                           as running_total_cases
        ,confirmed_cases - LAG(confirmed_cases)
            OVER (PARTITION BY 
                    county 
                ORDER BY 
                    date ASC)                      as new_cases
        ,deaths                                    as running_total_deaths
        ,deaths - LAG(deaths)
            OVER (PARTITION BY 
                    county 
                ORDER BY 
                    date ASC)                      as new_deaths
    FROM 
        base_county_cases
)

SELECT 
      stg_county_cases.*
      ,FARM_FINGERPRINT(CONCAT(date_key, case_county))  as unique_key
FROM 
    stg_county_cases