# SQL Analysis Plan

## 🎯 Purpose
SQL is used to build customer-level metrics and business KPIs from transactional e-commerce data.

The output of SQL analysis will serve as the foundation for Python analysis and Tableau dashboards.


## 🗃️ Core Tables & Data Grain
- **Orders table:** One row per order
- **Order items table:** One row per item per order
- **Payments table:** One row per payment
- **Customers table:** One row per customer

### Analysis Grain
All final SQL outputs will be aggregated at **customer level**.


## 📊 KPI Logic Mapping

### Recency
- Days since customer's last purchase
- Derived from latest order date per customer

### Frequency
- Total number of orders per customer

### Monetary Value
- Total revenue per customer

### Average Order Value (AOV)
- Total revenue ÷ total orders

### Customer Lifetime Value (Proxy)
- Frequency × Monetary Value



## 📤 Expected SQL Outputs
- Customer-level RFM table
- High-value customer list
- At-risk customer list
- Revenue contribution by segment

