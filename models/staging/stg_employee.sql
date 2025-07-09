{{ config(
    database='STAGING_DB',
    schema='EMPLOYEES',
    alias='EMPLOYEES',
    materialized='view'
) }}

SELECT 
employee_id,
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
TO_DATE(hire_date, 'DD-MM-YYYY') AS hire_date,
department,
job_title,
CAST(salary as DOUBLE) AS SALARY,
status

from RAW_DATA_DB.raw_data.EMPLOYEES

