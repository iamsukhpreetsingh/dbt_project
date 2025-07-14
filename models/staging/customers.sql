{{ config(
    materialized='incremental',
    database='TEMP_DB_CLONED',
    schema='TEMP_SILVER_SCHEMA_CUSTOMER',
    alias='CUSTOMER_SILVER',
    unique_key='customer_id'
) }}


SELECT  

  customer_id,
  UPPER(first_name) AS first_name,
  UPPER(last_name) AS last_name,
  email,
  CAST(RIGHT(REGEXP_REPLACE(phone, '[^0-9]', ''), 10) AS NUMBER) AS phone,
  TO_DATE(registration_date, 'YYYY-MM-DD') AS registration_date,
  UPPER(customer_segment) AS customer_segment,
  CASE 
  WHEN UPPER(is_active) IN ('1', 'TRUE', 'YES') THEN 'TRUE'
  ELSE 'FALSE'
  END AS is_active,
  total_orders,
  UPPER(city) AS city,
  state,
  country,
  TO_TIMESTAMP(created_at, 'YYYY-MM-DD HH24:MI:SS') AS created_at,
  updated_at

  FROM TEMP_DB_CLONED.TEMP_SCHEMA.RAW_CUSTOMERS


{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}