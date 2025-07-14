{{ config(
    materialized='incremental',
    database='TEMP_DB_CLONED',
    schema='TEMP_SILVER_SCHEMA_ORDERS_ITEM',
    alias='ORDERS_ITEM_SILVER',
    unique_key='order_item_id'
) }}

SELECT
  order_item_id,
  order_id,
  product_id,
  UPPER(product_name) AS product_name,
  UPPER(category) AS category,
  CAST(quantity AS NUMBER) AS quantity,
  CAST(unit_price AS DOUBLE) AS unit_price,
  CAST(CASE 
    WHEN total_price != quantity * unit_price OR total_price IS NULL 
    THEN quantity * unit_price
    ELSE total_price
  END AS DOUBLE) AS total_price,
  TO_TIMESTAMP(created_at, 'YYYY-MM-DD HH24:MI:SS') AS created_at,
  supplier,
  sku,
  updated_at
FROM TEMP_DB_CLONED.TEMP_SCHEMA.RAW_ORDER_ITEMS


{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}