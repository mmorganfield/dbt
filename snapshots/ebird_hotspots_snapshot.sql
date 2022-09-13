{% snapshot ebird_hotspots_snapshot %}
    {{
        config(
          unique_key='primary_key',
          strategy='timestamp',
          updated_at='extracted_at',
          target_schema='dev_staging'
        )
    }}
    -- Pro-Tip: Use sources in snapshots!
    select * from {{ ref('dev_staging', 'stg_ebird_hotspots') }}

{% endsnapshot %}