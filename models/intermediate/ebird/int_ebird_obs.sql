{{ 
    config(
        materialized='incremental',
        unique_key='primary_key'
    )
}}

WITH stg_ebird AS (
    SELECT 
        * 
    FROM 
    (SELECT 
        *,
        RANK() OVER ( PARTITION BY primary_key ORDER BY extracted_at desc) as rank_
    FROM 
    {{ ref('stg_ebird_obs') }})
    WHERE rank_ = 1
)

SELECT DISTINCT * FROM (
    SELECT
        primary_key
        ,FORMAT_DATETIME("%Y%m%d", DATE(obs_dttm)) as date_key
        ,obs_reviewed
        ,sub_id
        ,obs_valid
        ,longitude
        ,latitude
        ,obs_dttm
        ,DATE(obs_dttm) as                            obs_date
        ,loc_id
        ,sci_name
        ,loc_private
        ,how_many
        ,loc_name
        ,common_name
        ,CURRENT_TIMESTAMP() as                       etl_create_dt
    FROM 
        stg_ebird 

        {% if is_incremental() %}

        WHERE obs_dttm > (SELECT MAX(obs_dttm) FROM {{ this }})

        {% endif %}
        )