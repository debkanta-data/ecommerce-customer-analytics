CREATE DATABASE olist_ecommerce;

USE olist_ecommerce;

-- Row count check
SELECT COUNT(*) AS fact_rows FROM fact_orders;
SELECT COUNT(*) AS rfm_rows FROM rfm_scores;

-- Detects duplication issues
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT order_id) AS distinct_orders FROM fact_orders;

-- Null risk
SELECT SUM(order_id IS NULL) AS null_orders,
    SUM(customer_id IS NULL) AS null_customers,
    SUM(item_revenue IS NULL) AS null_revenue
FROM fact_orders;

-- Drop unwanted Columns
ALTER TABLE fact_orders
DROP COLUMN `Unnamed: 0`;

ALTER TABLE rfm_scores
DROP COLUMN `Unnamed: 0`;

-- Confirm schemas
DESCRIBE fact_orders;
DESCRIBE rfm_scores;

-- Conver text to varchar and Make columns NOT NULL
ALTER TABLE fact_orders
MODIFY order_id VARCHAR(70) NOT NULL,
MODIFY customer_id VARCHAR(70) NOT NULL;

-- Add index 
CREATE INDEX idx_fact_order_id ON fact_orders(order_id);
CREATE INDEX idx_fact_customer_id ON fact_orders(customer_id);



-- Confirm indexes
SHOW INDEX FROM fact_orders;


-- Core profitability view creation
 CREATE OR REPLACE VIEW customer_profitability AS 
 SELECT customer_id,
 COUNT(DISTINCT order_id) AS order_count,
 ROUND(SUM(item_revenue),2) AS total_revenue,
 ROUND(SUM(logistics_cost),2) AS total_logistics_cost,
 ROUND(SUM(item_revenue - logistics_cost),2) AS total_profit,
 ROUND(SUM(item_revenue - logistics_cost)/ NULLIF(SUM(item_revenue),0),2) AS profit_margin
 
 FROM fact_orders
 GROUP BY customer_id;










