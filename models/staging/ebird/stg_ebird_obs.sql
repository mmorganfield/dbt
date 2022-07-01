WITH base_ebird AS (
    SELECT *,
    _FILE_NAME as file_name
    FROM {{ source('dev_base', 'base_ebird') }}
),   
    stg_ebird_raw AS (
    
    SELECT
        SAFE_CAST(obsReviewed AS BOOL) as          obs_reviewed
        ,subId as                                  sub_id
        ,SAFE_CAST(obsValid AS BOOL) as            obs_valid
        ,SAFE_CAST(lng AS FLOAT64)  as             longitude
        ,SAFE_CAST(lat AS FLOAT64) as              latitude
        ,speciesCode as                            species_code
        ,DATETIME(CASE 
            WHEN 
                length(obsDt) = 10
            THEN 
                TIMESTAMP(obsDt) 
            ELSE 
                PARSE_TIMESTAMP("%F %H:%M", obsDt, 'America/Denver')
            END, 'America/Denver') as              obs_dttm
        ,locId as                                  loc_id
        ,sciName as                                sci_name
        ,SAFE_CAST(howMany AS INT64) as            how_many
        ,locName as                                loc_name
        ,SAFE_CAST(locationPrivate AS BOOL) as     loc_private
        ,comName as                                common_name
        ,file_name as                              file_name
        ,REGEXP_EXTRACT(file_name,
        r'(\d{4}-\d{2}-\d{4}:\d{2}:\d{2}.\d+)') as extracted_at                    
    FROM 
        base_ebird
    )

SELECT 
    stg_ebird_raw.*
    ,FARM_FINGERPRINT(CONCAT(
                    obs_dttm
                    ,species_code 
                    ,loc_id
                    ,sub_id
    )) as primary_key
FROM stg_ebird_raw
ORDER BY primary_key