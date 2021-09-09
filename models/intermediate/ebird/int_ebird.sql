WITH stg_ebird AS (
    SELECT * FROM {{ source('dev_staging', 'stg_ebird')}}
)

SELECT DISTINCT * FROM (
    SELECT
        primary_key
        ,FORMAT_TIMESTAMP("Y%m%d%", obs_dttm) as date_key
        ,obs_reviewed
        ,sub_id
        ,obs_valid
        ,longitude
        ,latitude
        ,obs_dttm
        ,DATE(obs_dttm) as obs_date
        ,loc_id
        ,sci_name
        ,loc_private
        ,how_many
        ,loc_name
        ,common_name
    FROM stg_ebird)