-- rfm_segmentation.sql
-- Purpose: Score customers using RFM metrics and assign business segments
-- Input: rfm_base.sql (customer-level RFM table)
-- Output: One row per customer with RFM scores and segment label


WITH rfm_base AS (
    SELECT *
    FROM rfm_base
),

rfm_scores AS (
    SELECT
        customer_id,
        recency,
        frequency,
        monetary,

        NTILE(4) OVER (ORDER BY recency ASC)   AS recency_score,
        NTILE(4) OVER (ORDER BY frequency DESC) AS frequency_score,
        NTILE(4) OVER (ORDER BY monetary DESC)  AS monetary_score

    FROM rfm_base
)

SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score
FROM rfm_scores;


WITH rfm_base AS (
    SELECT *
    FROM rfm_base
),

rfm_scores AS (
    SELECT
        customer_id,
        recency,
        frequency,
        monetary,

        NTILE(4) OVER (ORDER BY recency ASC)   AS recency_score,
        NTILE(4) OVER (ORDER BY frequency DESC) AS frequency_score,
        NTILE(4) OVER (ORDER BY monetary DESC)  AS monetary_score
    FROM rfm_base
),

rfm_segment AS (
    SELECT
        *,
        CASE
            WHEN recency_score = 4 AND frequency_score = 4 AND monetary_score = 4
                THEN 'Champions'
            WHEN recency_score >= 3 AND frequency_score >= 3
                THEN 'Loyal Customers'
            WHEN recency_score >= 3 AND frequency_score <= 2
                THEN 'Potential Loyalists'
            WHEN recency_score <= 2 AND frequency_score >= 3
                THEN 'At Risk High Value'
            ELSE 'Regular'
        END AS customer_segment
    FROM rfm_scores
)

SELECT *
FROM rfm_segment;
