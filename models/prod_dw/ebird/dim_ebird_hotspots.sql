WITH stg_ebird_hotspots AS (
    SELECT * FROM {{ ref('stg_ebird_hotspots')}}
),
    stg_ebird_hotspots_lag AS(
SELECT
    ebird_loc_id,
    species_all_time,
    latest_obs_dttm,
    longitude,
    latitude,
    hotspot_name,
    sub_national_1_code,
    sub_national_2_code,
    latest_obs_dttm                                 AS valid_from_dt,
    LAG (latest_obs_dttm) OVER (
        PARTITION BY ebird_loc_id 
        ORDER BY latest_obs_dttm DESC)              AS valid_to_dt
    FROM
    stg_ebird_hotspots
    )
SELECT 
    *,
    CASE 
        WHEN valid_to_dt IS NULL
            THEN 1
        ELSE 0
        END                                         AS scd_active_ind
FROM stg_ebird_hotspots_lag
WHERE 
    valid_from_dt < valid_to_dt
    OR valid_to_dt IS NULL
GROUP BY 
    ebird_loc_id,
    species_all_time,
    latest_obs_dttm,
    longitude,
    latitude,
    hotspot_name,
    sub_national_1_code,
    sub_national_2_code,
    valid_from_dt,
    valid_to_dt,
    scd_active_ind