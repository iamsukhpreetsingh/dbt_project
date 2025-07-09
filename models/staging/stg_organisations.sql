{{ config(
    materialized='incremental',
    database='STAGING_DB',
    schema='organization',
    alias='organization',
    unique_key='org_id'
) }}

SELECT
org_id,
org_name,
industry,
org_type,
org_address,
org_city,
org_state,
CAST(org_zip AS NUMBER) AS org_zip,
updated_at

FROM RAW_DATA_DB.raw_data.organizations

{% if is_incremental() %}
WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }} )
{% endif %}