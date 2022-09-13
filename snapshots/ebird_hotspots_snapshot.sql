{% snapshot ebird_hotspots_snapshot %}
    {{
        config(
          unique_key='primary_key',
          strategy='timestamp',
          updated_at='latest_obs_dttm',
          target_schema='dev_staging'
        )
    }}
    -- Pro-Tip: Use sources in snapshots!
    SELECT * FROM {{ ref('stg_ebird_hotspots') }}

{% endsnapshot %}