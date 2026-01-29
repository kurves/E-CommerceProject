-- customer snapshot

CREATE OR REPLACE VIEW vw_customer_summary AS
SELECT
    u.user_id,
    COUNT(o.order_id) AS total_orders,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date,
    SUM(o.revenue_usd) AS lifetime_revenue
FROM dim_users u
LEFT JOIN fact_orders o
    ON u.user_id = o.user_id
GROUP BY u.user_id;

-- cohort retention
CREATE OR REPLACE VIEW vw_customer_cohorts AS
WITH first_orders AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM fact_orders
    GROUP BY user_id
)
SELECT
    o.user_id,
    f.cohort_month,
    DATE_TRUNC('month', o.order_date) AS order_month,
    COUNT(o.order_id) AS orders,
    SUM(o.revenue_usd) AS revenue
FROM fact_orders o
JOIN first_orders f
    ON o.user_id = f.user_id
GROUP BY
    o.user_id,
    f.cohort_month,
    DATE_TRUNC('month', o.order_date);
