WITH stg_county_cases AS (
    
    SELECT * FROM {{ ref('stg_county_cases')}}

), int_county_cases AS (
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
        stg_county_cases
)

SELECT 
      int_county_cases.*
      ,FARM_FINGERPRINT(CONCAT(date_key, county))  as unique_key
FROM 
    int_county_cases