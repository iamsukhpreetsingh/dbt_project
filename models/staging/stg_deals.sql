{{ config(
    database='STAGING_DB',
    schema='DEALS',
    alias='DEALS',
    materialized='incremental',
    unique_key='deal_id'
) }}

SELECT 

deal_id,
title,
organization_id,
person_name	,
CAST(value AS DOUBLE) AS DEAL_VALUE,
currency AS CURRENCY_TYPE,
TO_DATE(add_time, 'DD-MM-YYYY') AS 	DEAL_ADD_DATE,
TO_DATE(update_time, 'DD-MM-YYYY') AS DEAL_UPDATES_DATES,
TO_DATE(close_time, 'DD-MM-YYYY') AS DEAL_CLOSING_DATE,
deal_stage,
won_by_person_id,
lost_reason,
updated_at

FROM RAW_DATA_DB.raw_data.DEALS

{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) from {{ this }})
{% endif %}