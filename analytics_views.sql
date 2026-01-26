-- business health 
CREATE OR REPLACE VIEW vw_exec_daily_performance AS
SELECT
    d.date_day,
    d.year,
    d.month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.revenue_usd) AS total_revenue,
    SUM(o.gross_profit_usd) AS gross_profit,
    SUM(o.revenue_usd) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM fact_orders o
JOIN dim_date d
    ON o.order_date = d.date_day
GROUP BY d.date_day, d.year, d.month;





-- funnel analysis
CREATE OR REPLACE VIEW vw_funnel_sessions_orders AS
SELECT
    d.date_day,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / NULLIF(COUNT(DISTINCT s.website_session_id), 0),
        4
    ) AS conversion_rate
FROM fact_sessions s
JOIN dim_date d
    ON s.session_date = d.date_day
LEFT JOIN fact_orders o
    ON s.website_session_id = o.website_session_id
GROUP BY d.date_day
ORDER BY d.date_day;

-- customer retention

CREATE OR REPLACE VIEW vw_customer_retention AS
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

-- refund analysis
CREATE OR REPLACE VIEW vw_refunds_by_product AS
SELECT
    p.product_id,
    p.product_name,
    COUNT(r.order_item_refund_id) AS refund_count,
    SUM(r.refund_amount_usd) AS total_refunds_usd
FROM fact_refunds r
JOIN fact_order_items oi
    ON r.order_item_id = oi.order_item_id
JOIN dim_products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_refunds_usd DESC;


-- high refund products

CREATE OR REPLACE VIEW vw_high_refund_products AS
SELECT
    p.product_id,
    p.product_name,
    COUNT(r.order_item_refund_id) AS refund_count,
    COUNT(oi.order_item_id) AS total_items_sold,
    ROUND(
        COUNT(r.order_item_refund_id)::NUMERIC
        / NULLIF(COUNT(oi.order_item_id), 0),
        4
    ) AS refund_rate
FROM dim_products p
JOIN fact_order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN fact_refunds r
    ON oi.order_item_id = r.order_item_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.order_item_refund_id) > 0
ORDER BY refund_rate DESC;



