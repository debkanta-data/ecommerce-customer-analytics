SELECT
    customer_segment,
    COUNT(*) AS customer_count
FROM rfm_segment
GROUP BY customer_segment
ORDER BY customer_count DESC;


SELECT
    customer_segment,
    SUM(monetary) AS total_revenue,
    AVG(monetary) AS avg_revenue
FROM rfm_segment
GROUP BY customer_segment
ORDER BY total_revenue DESC;

SELECT
    customer_segment,
    AVG(recency) AS avg_recency_days
FROM rfm_segment
GROUP BY customer_segment
ORDER BY avg_recency_days ASC;



