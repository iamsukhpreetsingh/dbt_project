{{ config(
    database='STAGING_DB',
    schema='STG_SALES_SCHEMA',
    alias='customers',
    materialized='view'
) }}

SELECT * FROM 
RAW_DATA_DB.TRANSACTIONAL_SCHEMA.CUSTOMERS