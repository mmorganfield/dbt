{% snapshot ebird_hotspots_snapshot_check %}
    {{
        config(
          unique_key='ebird_loc_id',
          strategy='check',
          updated_at='latest_obs_dttm',
          check_cols=['latest_obs_dttm',
                        'species_all_time',
                        'hotspot_name',
                        'longitude',
                        'latitude',
                        'sub_national_2_code',
                        'sub_national_1_code'],
          target_schema='dev_staging'
        )
    }}
    -- Pro-Tip: Use sources in snapshots!
    SELECT 
        ebird_loc_id,
        species_all_time,
        latest_obs_dttm,
        longitude,
        latitude,
        hotspot_name,
        sub_national_2_code,
        sub_national_1_code,
        national_code
    FROM {{ ref('stg_ebird_hotspots') }}

{% endsnapshot %}