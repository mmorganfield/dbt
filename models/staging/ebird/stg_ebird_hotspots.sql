WITH base_ebird_hotspots AS (
    SELECT 
        *,
         _file_name as file_name 
    FROM {{ source('dev_base', 'base_ebird_hotspots') }}
),  stg_ebird_hotspots_raw AS (
    SELECT
        numSpeciesAllTime as total_species
        ,TIMESTAMP(latestObsDt) as latest_obs_dt
        ,lng as longitude
        ,lat as latitude
        ,subnational1Code as sub_national_code_1
        ,subnational2Code as sub_national_code_2
        ,locName as loc_name
        ,countryCode as country_code
        ,locId as loc_id
        ,PARSE_TIMESTAMP('%Y-%m-%d%H:%M:%S', REGEXP_EXTRACT(file_name,r'(\d{4}-\d{2}-\d{4}:\d{2}:\d{2})')) as extracted_at
        FROM base_ebird_hotspots
)

SELECT * FROM stg_ebird_hotspots_raw ORDER BY loc_name