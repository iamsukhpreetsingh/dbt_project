{{ config(
    materialized='incremental',
    database='TEMP_DB_CLONED',
    schema='TEMP_SILVER_SCHEMA_PAYMENTS',
    alias='PAYMENTS_SILVER',
    unique_key='payment_id'
) }}

SELECT 
  payment_id,
  order_id,
CASE 
WHEN UPPER(payment_method) IN ('CREDIT_CARD', 'CREDIT CARD') THEN 'CREDIT CARD'
WHEN UPPER(payment_method) IN ('DEBIT_CARD', 'DEBIT CARD') THEN 'DEBIT CARD'
ELSE 'ONLINE'
END AS payment_method,
payment_status,
CAST(amount AS DOUBLE) AS amount,
currency,
TO_DATE(payment_date, 'YYYY-MM-DD') as payment_date,
transaction_id,
CAST(fees AS DOUBLE) AS fees,
TO_TIMESTAMP(NULLIF(TRIM(REPLACE(created_at, '"', '')), ''), 'YYYY-MM-DD HH24:MI:SS') AS created_at,
updated_at
FROM TEMP_DB_CLONED.TEMP_SCHEMA.RAW_PAYMENTS
WHERE amount > 0 AND TRANSACTION_ID IS NOT NULL


{% if is_incremental() %}
AND updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}