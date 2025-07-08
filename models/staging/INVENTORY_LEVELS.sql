{{ config(
    database='STAGING_DB',
    schema='STG_SALES_SCHEMA',
    alias='INVENTORY_LEVELS',
    materialized='view'
) }}

SELECT * FROM RAW_DATA_DB.TRANSACTIONAL_SCHEMA.INVENTORY_LEVELS