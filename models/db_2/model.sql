{{ config(
    database='DBT_TESTING_2',
    schema='DBT_TESTING_SCHEMA_2',
    alias='my_custom_view',
    materialized='view'
) }}

SELECT DEPARTMENT, SUM(SALARY) AS SUM_OF_SALARY
FROM TEMP_DB.TEMP_SCHEMA.EMPLOYEES
GROUP BY DEPARTMENT

