WITH base_ebird AS (
    SELECT * FROM {{ source('dev_base', 'base_ebird')}}
),   stg_ebird_raw AS (
    SELECT
        obsReviewed as obs_reviewed
        ,subId as sub_id
        ,obsValid as obs_valid
        ,lng as longitude
        ,lat as latitude
        ,speciesCode as species_code
        ,obsDt as obs_dttm
        ,locId as loc_id
        ,sciName as sci_name
        ,locationPrivate as loc_private
        ,comName as common_name
    FROM base_ebird
    )

SELECT 
    stg_ebird_raw.*
    ,FARM_FINGERPRINT(CONCAT(
                    obs_dttm
                    ,species_code 
                    ,loc_id
    )) primary_key
FROM stg_ebird_raw
ORDER BY primary_key