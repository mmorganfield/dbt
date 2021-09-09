WITH int_ebird AS (
    SELECT * FROM {{ source('dev_intermediate', 'int_ebird')}}
)

SELECT 
* 
FROM int_ebird
WHERE primary_key IS NOT NULL