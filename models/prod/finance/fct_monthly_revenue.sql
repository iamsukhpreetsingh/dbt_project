{{ config(
    database='TEMP_DB_CLONED',
    schema='PROD_FACT_MONTHLY_REVENUE',
    alias='FACT_MONTHLY_REVENUE',
) }}

with orders as (
  select * from TEMP_DB_CLONED.TEMP_SILVER_SCHEMA_ORDERS.ORDERS_SILVER
),

customers as (
  select * from TEMP_DB_CLONED.TEMP_SILVER_SCHEMA_CUSTOMER.CUSTOMER_SILVER
),

order_items as (
  select * from TEMP_DB_CLONED.TEMP_SILVER_SCHEMA_ORDERS_ITEM.ORDERS_ITEM_SILVER
)

select
    orders.customer_id,
    customers.customer_segment,
    COUNT(DISTINCT orders.order_id) as total_orders,
    
    SUM(order_items.quantity * order_items.unit_price) as gross_revenue,
    SUM(order_items.quantity * order_items.unit_price * orders.discount_rate) as total_discounts,
    
    SUM(order_items.quantity * order_items.unit_price) - 
    SUM(order_items.quantity * order_items.unit_price * orders.discount_rate) as net_revenue,
    
    AVG(order_items.quantity * order_items.unit_price) as avg_order_value,

    -- Business logic for customer classification
    CASE 
      WHEN SUM(order_items.quantity * order_items.unit_price) >= 10000 THEN 'high_value'
      WHEN SUM(order_items.quantity * order_items.unit_price) >= 1000 THEN 'medium_value'
      ELSE 'low_value'
    END as customer_value_tier

from orders
inner join order_items
  on orders.order_id = order_items.order_id
inner join customers
  on orders.customer_id = customers.customer_id

group by orders.customer_id, customers.customer_segment
