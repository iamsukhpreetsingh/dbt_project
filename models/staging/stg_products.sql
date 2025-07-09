{{ config(
    materialized='incremental',
    database='STAGING_DB',
    schema='PRODUCTS',
    alias='PRODUCTS',
    unique_key='PRODUCT_ID'
) }}

SELECT 
product_id,
product_name,
category,
CAST(price AS DOUBLE) AS PRICE,
CAST(stock_quantity AS DOUBLE) AS stock_quantity,
updated_at
FROM 
RAW_DATA_DB.raw_data.PRODUCTS

{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}