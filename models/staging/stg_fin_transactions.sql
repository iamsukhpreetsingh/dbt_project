{{ config(
    database='STAGING_DB',
    schema='FININCIAL_TRANSACTIONS',
    alias='FININCIAL_TRANSACTIONS',
    materialized='view'
) }}

SELECT
transaction_id,
TO_DATE(transaction_date, 'DD-MM-YYYY') AS transaction_date,
transaction_type,
CAST(amount AS DOUBLE) AS amount,
currency,
description,
source_account,
destination_account
related_entity_id
FROM 
RAW_DATA_DB.raw_data.FININCIAL_TRANSACTIONS
