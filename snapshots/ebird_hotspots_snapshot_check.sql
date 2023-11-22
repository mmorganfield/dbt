{% snapshot ebird_hotspots_snapshot_check %}
    {{
        config(
          unique_key='primary_key',
          strategy='check',
          updated_at='extracted_at',
          check_cols=['latest_obs_dttm',
                        'species_all_time',
                        'hotspot_name',
                        'longitude',
                        'latitude',
                        'sub_national_2_code',
                        'sub_national_1_code',
                        'ebird_loc_id'],
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
        national_code,
        primary_key,
        extracted_at
    FROM {{ ref('stg_ebird_hotspots') }}
    qualify
        row_number() over (partition by primary_key order by extracted_at desc)
        = 1

{% endsnapshot %}