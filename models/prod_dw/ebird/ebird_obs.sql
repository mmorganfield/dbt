WITH int_ebird AS (
    SELECT * FROM {{ ref( 'int_ebird_obs')}}
)

SELECT 
* 
FROM int_ebird
WHERE primary_key IS NOT NULL