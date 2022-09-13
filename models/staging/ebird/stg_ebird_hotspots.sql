WITH base_ebird_hotspots AS (
    SELECT
    *,
    _FILE_NAME AS file_name
    FROM {{ source('dev_base', 'base_ebird_hotspots') }}
),

stg_ebird_hotspots_raw AS (
SELECT
    SAFE_CAST(NULLIF(numSpeciesAllTime, "nan") AS INT64) as                            species_all_time
    ,PARSE_TIMESTAMP('%F %H:%M', NULLIF(latestObsDt, "nan"), 'America/Denver') as      latest_obs_dttm
    ,SAFE_CAST(NULLIF(lng, "nan") AS FLOAT64) as                                       longitude
    ,SAFE_CAST(NULLIF(lat, "nan") AS FLOAT64) as                                       latitude
    ,subnational2Code as                                                sub_national_2_code
    ,subnational1Code as                                                sub_national_1_code
    ,locName as                                                         hotspot_name
    ,countryCode as                                                     national_code 
    ,locId as                                                           ebird_loc_id
    ,REGEXP_EXTRACT(file_name,
        r'(\d{4}-\d{2}-\d{4}:\d{2}:\d{2}.\d+)') as                      extracted_at 
FROM
base_ebird_hotspots 
)

SELECT
stg_ebird_hotspots_raw.*,
FARM_FINGERPRINT(CONCAT(species_all_time, ebird_loc_id, latest_obs_dttm,
                    longitude, latitude, sub_national_2_code)) as        primary_key
FROM
stg_ebird_hotspots_raw