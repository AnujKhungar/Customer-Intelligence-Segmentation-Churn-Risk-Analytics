create database customer_churn_analysis;


CREATE TABLE dim_customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen INT,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INT,
    tenure_group VARCHAR(10)
);

CREATE TABLE dim_subscription (
    customer_id VARCHAR(20),
    contract VARCHAR(50),
    payment_method VARCHAR(50),
    paperless_billing VARCHAR(5),
    monthly_charges DECIMAL(10,2),
    internet_service VARCHAR(50)
);

CREATE TABLE fact_customer_monthly (
    customer_id VARCHAR(20),
    month_number INT,
    monthly_revenue DECIMAL(10,2),
    churn_flag INT,
    engagement_score VARCHAR(10)
);


load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/fact_customer_monthly.csv'
into table fact_customer_monthly
fields terminated by ','
enclosed by '"'
lines terminated by ','
ignore 1 rows;


-- What percentage of customers churn
SELECT COUNT(DISTINCT customer_id) AS total_customers, SUM(churn_flag) AS churned_customers,
ROUND(SUM(churn_flag) * 100.0 / COUNT(DISTINCT customer_id),2) AS churn_rate_pct
FROM fact_customer_monthly;

-- Which contract types are riskier
SELECT s.contract, COUNT(DISTINCT f.customer_id) AS customers,
SUM(f.churn_flag) AS churned_customers,ROUND(SUM(f.churn_flag) * 100.0 / 
COUNT(DISTINCT f.customer_id),2) AS churn_rate_pct
FROM fact_customer_monthly f
JOIN dim_subscription s ON f.customer_id = s.customer_id
GROUP BY s.contract ORDER BY churn_rate_pct DESC;


-- At what customer lifecycle stage do we lose people
SELECT c.tenure_group,COUNT(DISTINCT f.customer_id) AS customers,
SUM(f.churn_flag) AS churned_customers,ROUND(SUM(f.churn_flag) * 100.0 / 
COUNT(DISTINCT f.customer_id),2) AS churn_rate_pct FROM fact_customer_monthly f
JOIN dim_customer c ON f.customer_id = c.customer_id
GROUP BY c.tenure_group ORDER BY churn_rate_pct DESC;


-- Are we losing high-value customers
SELECT f.churn_flag, ROUND(AVG(f.monthly_revenue), 2) AS avg_monthly_revenue
FROM fact_customer_monthly f WHERE f.churn_flag IN (0,1)
GROUP BY f.churn_flag;


-- Does engagement predict churn
SELECT engagement_score,COUNT(DISTINCT customer_id) AS customers,SUM(churn_flag) AS churned_customers,
ROUND(SUM(churn_flag) * 100.0 / COUNT(DISTINCT customer_id),2) AS churn_rate_pct
FROM fact_customer_monthly GROUP BY engagement_score ORDER BY churn_rate_pct DESC;


-- Which valuable customers should we save first
SELECT f.customer_id,SUM(f.monthly_revenue) AS total_revenue,MAX(f.churn_flag) AS churned
FROM fact_customer_monthly f GROUP BY f.customer_id HAVING MAX(f.churn_flag) = 1
ORDER BY total_revenue DESC LIMIT 20;


-- Churn by Payment Method
SELECT s.payment_method,COUNT(DISTINCT f.customer_id) AS customers,SUM(f.churn_flag) AS churned_customers,
ROUND(SUM(f.churn_flag) * 100.0 / COUNT(DISTINCT f.customer_id), 2) AS churn_rate_pct
FROM fact_customer_monthly f JOIN dim_subscription s ON f.customer_id = s.customer_id
GROUP BY s.payment_method ORDER BY churn_rate_pct DESC;


-- Paperless Billing Impact
SELECT s.paperless_billing,COUNT(DISTINCT f.customer_id) AS customers,
SUM(f.churn_flag) AS churned_customers,ROUND(SUM(f.churn_flag) * 100.0 / 
COUNT(DISTINCT f.customer_id), 2) AS churn_rate_pct
FROM fact_customer_monthly f JOIN dim_subscription s ON f.customer_id = s.customer_id
GROUP BY s.paperless_billing;


-- Internet Service vs Churn
SELECT s.internet_service,COUNT(DISTINCT f.customer_id) AS customers,
SUM(f.churn_flag) AS churned_customers,ROUND(SUM(f.churn_flag) * 100.0 / 
COUNT(DISTINCT f.customer_id), 2) AS churn_rate_pct FROM fact_customer_monthly f
JOIN dim_subscription s ON f.customer_id = s.customer_id
GROUP BY s.internet_service ORDER BY churn_rate_pct DESC;


-- Retention Priority Score
SELECT f.customer_id,SUM(f.monthly_revenue) AS total_revenue,
COUNT(f.month_number) AS months_active,MAX(f.churn_flag) AS churned
FROM fact_customer_monthly f GROUP BY f.customer_id
HAVING churned = 1 ORDER BY total_revenue DESC;


-- Early-Life Churn Detection
SELECT COUNT(DISTINCT customer_id) AS early_churners
FROM fact_customer_monthly WHERE churn_flag = 1 AND month_number <= 6;


-- Revenue at Risk
SELECT ROUND(SUM(monthly_revenue), 2) AS revenue_at_risk
FROM fact_customer_monthly WHERE churn_flag = 1;











