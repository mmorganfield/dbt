{% snapshot int_ebird_hotspots %}
    {{ 
        config(
            target_database = "max-warehouse-323301",
            target_schema = "dev_intermediate",
            unique_key = "loc_id",
            strategy = "timestamp",
            updated_at = "extracted_at"
            )
    }}

    SELECT * FROM {{ ref( 'stg_ebird_hotspots') }}

{% endsnapshot %}