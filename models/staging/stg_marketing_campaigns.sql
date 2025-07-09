{{ config(
    materialized='incremental',
    unique_key='campaign_id',
    database='STAGING_DB',
    schema='MARKETING_CAMPAIGNS',
    alias='MARKETING_CAMPAIGNS'
) }}


SELECT

campaign_id,
LEFT(CAMPAIGN_NAME, (LENGTH(CAMPAIGN_NAME) - 11)) AS CAMPAIGN_NAME,	
campaign_type,	
RIGHT(campaign_type, 11) AS CAMPAIGN_number,
TO_DATE(start_date, 'DD-MM-YYYY') AS START_DATE,	
TO_DATE(end_date, 'DD-MM-YYYY') AS end_date,	
CAST(budget AS DOUBLE) AS BUDGET,
status,	
target_audience,
updated_at

FROM RAW_DATA_DB.raw_data.MARKETING_CAMPAIGNS

{% if is_incremental() %}
  WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}
