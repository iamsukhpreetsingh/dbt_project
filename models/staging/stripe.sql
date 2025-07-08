{{ config(
    database='STAGING_DB',
    schema='STG_SALES_SCHEMA',
    alias='stripe',
    materialized='view'
) }}


SELECT
VARIANT_COL:"amount"::NUMBER AS amount,
VARIANT_COL:"billing_details"."address"."city"::STRING AS city,
VARIANT_COL:"billing_details"."address"."country"::STRING AS country,
VARIANT_COL:"billing_details"."address"."line1"::STRING AS line1,
VARIANT_COL:"billing_details"."address"."postal_code"::STRING AS postal_code,
VARIANT_COL:"billing_details"."address"."state"::STRING AS state,
VARIANT_COL:"billing_details"."name"::STRING AS billing_name,
VARIANT_COL:"captured"::TIMESTAMP AS captured,
VARIANT_COL:"card_brand"::STRING AS card_brand,
VARIANT_COL:"card_exp_month"::NUMBER AS card_exp_month,
VARIANT_COL:"card_exp_year"::NUMBER AS card_exp_year,
VARIANT_COL:"card_last4"::NUMBER AS card_last4,
VARIANT_COL:"created"::TIMESTAMP AS created,
VARIANT_COL:"currency"::STRING AS currency,
VARIANT_COL:"customer_id"::NUMBER AS customer_id,
VARIANT_COL:"description"::STRING AS description,
VARIANT_COL:"order_id"::NUMBER AS order_id,
VARIANT_COL:"outcome"."network_status"::STRING AS network_status,
VARIANT_COL:"outcome"."reason"::STRING AS reason,
VARIANT_COL:"outcome"."risk_level"::STRING AS normal,
VARIANT_COL:"outcome"."seller_message"::STRING AS seller_message,
VARIANT_COL:"outcome"."type"::STRING AS type,
VARIANT_COL:"payment_id"::STRING AS payment_id,
VARIANT_COL:"payment_method"::STRING AS payment_method,
VARIANT_COL:"receipt_email"::STRING AS receipt_email,
VARIANT_COL:"shipping"."address"."city"::STRING AS shipping_city,
VARIANT_COL:"shipping"."address"."country"::STRING AS shipping_country,
VARIANT_COL:"shipping"."address"."line1"::STRING AS shipping_line1,
VARIANT_COL:"shipping"."address"."postal_code"::STRING AS shipping_postal_code,
VARIANT_COL:"shipping"."address"."state"::STRING AS shipping_state,
VARIANT_COL:"shipping"."name"::STRING AS reciver_name,
VARIANT_COL:"status"::STRING AS shipment_status

FROM RAW_DATA_DB.TRANSACTIONAL_SCHEMA.STRIPE_PAYMENTS
