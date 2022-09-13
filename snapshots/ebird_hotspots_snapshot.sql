{% snapshot ebird_hotspots_snapshot %}

    {{
        config(
          target_schema='dev_staging',
          strategy='timestamp',
          unique_key='primary_key',
          updated_at='extracted_at',
          invalidate_hard_deletes=True,
        )
    }}

    SELECT 
    * 
    FROM {{ ref('dev_staging', 'stg_ebird_hotspots') }}

{% endsnapshot %}