{{ config(
    materialized='incremental',
    database='TEMP_DB_CLONED',
    schema='TEMP_SILVER_SCHEMA_PRODUCTS',
    alias='PRODUCTS_SILVER',
    unique_key='product_id'
) }}


SELECT 
  product_id,
  upper(product_name) as product_name,
  upper(category) as category,
  upper(subcategory) as subcategory,
  upper(brand) as brand,
  cast(cost_price as double) as cost_price,
  cast(retail_price as double) as retail_price,
  CASE WHEN 
    is_active IN ('1', 'Y' ,'Yes', 'YES', 'TRUE', 'True') THEN 'TRUE'
    ELSE 'FALSE'
  END AS is_active,
  TO_DATE(created_date, 'YYYY-MM-DD') AS created_date,
  weight_kg,
  dimensions,
  supplier_id,
  updated_at

FROM TEMP_DB_CLONED.TEMP_SCHEMA.RAW_PRODUCTS


{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}