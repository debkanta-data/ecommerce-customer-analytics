-- Customer-level RFM base table

WITH order_summary AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price) AS monetary,
        MAX(o.order_purchase_timestamp) AS last_order_date
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id
),

recency_calc AS (
    SELECT
        customer_id,
        frequency,
        monetary,
        DATE_PART(
            'day',
            CURRENT_DATE - last_order_date
        ) AS recency
    FROM order_summary
)

SELECT
    customer_id,
    recency,
    frequency,
    monetary
FROM recency_calc;
