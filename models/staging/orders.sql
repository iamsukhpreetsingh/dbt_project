{{ config(
    materialized='incremental',
    database='TEMP_DB_CLONED',
    schema='TEMP_SILVER_SCHEMA_ORDERS',
    alias='ORDERS_SILVER',
    unique_key='order_id'
) }}

WITH CTE AS (
SELECT
  order_id,
  customer_id,
  TO_DATE(order_date, 'YYYY-MM-DD') AS order_date,
  TO_TIMESTAMP(created_at, 'YYYY-MM-DD HH24:MI:SS') AS created_at,
  order_status,
  CAST(order_amount AS DOUBLE) AS order_amount,
  COALESCE(CAST(discount_amount AS DOUBLE), 0) AS discount_amount,
  COALESCE(CAST(discount_rate AS DOUBLE), 0) AS discount_rate,
  COALESCE(CAST(tax_amount AS DOUBLE), 0) AS tax_amount,
  order_type,
  shipping_address,
  notes,
  updated_at
FROM TEMP_DB_CLONED.TEMP_SCHEMA.RAW_ORDERS)

SELECT * FROM CTE
WHERE customer_id IS NOT NULL 
  AND order_amount > 0

  {% if is_incremental() %}
  AND updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
  {% endif %}
