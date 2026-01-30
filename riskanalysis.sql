DROP VIEW IF EXISTS vw_product_performance_monthly;

CREATE VIEW vw_product_performance_monthly AS
SELECT
    p.product_id,
    p.product_name,

    d.year,
    d.month,

    COUNT(oi.order_item_id) AS units_sold,
    SUM(oi.item_revenue_usd) AS revenue_usd,
    SUM(oi.item_profit_usd) AS profit_usd,

    COUNT(r.order_item_refund_id) AS refund_count,
    COALESCE(SUM(r.refund_amount_usd), 0) AS refunds_usd,

    ROUND(
        COUNT(r.order_item_refund_id)::NUMERIC
        / NULLIF(COUNT(oi.order_item_id), 0),
        4
    ) AS refund_rate,

    -- Revenue at risk = refunded revenue
    COALESCE(SUM(r.refund_amount_usd), 0) AS revenue_at_risk_usd

FROM fact_order_items oi
JOIN fact_orders o
    ON oi.order_id = o.order_id
JOIN dim_date d
    ON o.order_date = d.date_day
JOIN dim_products p
    ON oi.product_id = p.product_id
LEFT JOIN fact_refunds r
    ON oi.order_item_id = r.order_item_id

GROUP BY
    p.product_id,
    p.product_name,
    d.year,
    d.month;
