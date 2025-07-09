{{ config(
    materialized='incremental',
    database='STAGING_DB',
    schema='OPERATIONS_LOGS',
    alias='OPERATIONS_LOGS',
    unique_key='log_id'
) }}


SELECT 
log_id,
TO_TIMESTAMP(EVENT_TIMESTAMP, 'DD-MM-YYYY HH24:MI') AS event_timestamp,
event_type,
status,
product_id,
employee_id,
details,
updated_at

FROM
RAW_DATA_DB.raw_data.OPERATION_LOGS

{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}