{{ config(
    materialized='incremental',
    unique_key='transaction_id',
    database='STAGING_DB',
    schema='FININCIAL_TRANSACTIONS',
    alias='FININCIAL_TRANSACTIONS',
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
related_entity_id,
updated_at

FROM 
RAW_DATA_DB.raw_data.FININCIAL_TRANSACTIONS

{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) from {{ this }})
{% endif %}