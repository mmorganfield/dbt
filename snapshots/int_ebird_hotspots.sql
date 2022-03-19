{% snapshot int_ebird_hotspots %}
    {{ 
        config(
            target_database = "max-warehouse-323301",
            target_schema = "dev_intermediate",
            unique_key = "unique_key",
            strategy = "timestamp",
            updated_at = "extracted_at"
            )
    }}

    SELECT 
        DISTINCT * 
    FROM {{ ref( 'stg_ebird_hotspots') }}

{% endsnapshot %}