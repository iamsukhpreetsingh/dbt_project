{{ config(
    database='STAGING_DB',
    schema='CUSTOMERS',
    alias='CUSTOMERS',
    materialized='view'
) }}

SELECT 
customer_id,
first_name,
last_name,
CASE 
    WHEN email ILIKE '%@%' THEN email
    ELSE 'INVALID_EMAIL'
END AS email,
CASE 
    WHEN LEN(cast(phone as number)) <= 10 
    THEN RIGHT(cast(phone as number), 10) 
    ELSE NULL 
END AS phone_number,
address,
city,
state,
CAST(zip_code AS NUMBER) AS zip_code,
TO_DATE(REGISTRATION_DATE, 'DD-MM-YYYY') AS registration_date,
customer_segment

FROM RAW_DATA_DB.raw_data.customers

