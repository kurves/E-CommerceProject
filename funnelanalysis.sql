-- business funnel event reclassification
CREATE OR REPLACE VIEW vw_funnel_events AS
SELECT
    s.website_session_id,
    s.user_id,
    s.device_type,
    s.utm_source,
    s.utm_campaign,
    pv.pageview_date,
    CASE
        WHEN pv.pageview_url LIKE '%product%' THEN 'product_view'
        WHEN pv.pageview_url LIKE '%cart%' THEN 'add_to_cart'
        WHEN pv.pageview_url LIKE '%checkout%' THEN 'checkout'
        WHEN pv.pageview_url LIKE '%thank_you%' THEN 'order'
    END AS funnel_step
FROM fact_sessions s
LEFT JOIN fact_pageviews pv
    ON s.website_session_id = pv.website_session_id
WHERE pv.pageview_url IS NOT NULL;

-- overall funnel (sessions-> orders)
CREATE OR REPLACE VIEW vw_funnel_overall AS
SELECT
    d.date_day,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN f.funnel_step = 'product_view' THEN f.website_session_id END) AS product_views,
    COUNT(DISTINCT CASE WHEN f.funnel_step = 'add_to_cart' THEN f.website_session_id END) AS carts,
    COUNT(DISTINCT CASE WHEN f.funnel_step = 'checkout' THEN f.website_session_id END) AS checkouts,
    COUNT(DISTINCT o.order_id) AS orders
FROM fact_sessions s
JOIN dim_date d
    ON s.session_date = d.date_day
LEFT JOIN vw_funnel_events f
    ON s.website_session_id = f.website_session_id
LEFT JOIN fact_orders o
    ON s.website_session_id = o.website_session_id
GROUP BY d.date_day
ORDER BY d.date_day;


-- funnel by device(drop off analysis)
CREATE OR REPLACE VIEW vw_funnel_by_device AS
SELECT
    s.device_type,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT CASE WHEN f.funnel_step = 'product_view' THEN f.website_session_id END) AS product_views,
    COUNT(DISTINCT CASE WHEN f.funnel_step = 'add_to_cart' THEN f.website_session_id END) AS carts,
    COUNT(DISTINCT CASE WHEN f.funnel_step = 'checkout' THEN f.website_session_id END) AS checkouts,
    COUNT(DISTINCT o.order_id) AS orders
FROM fact_sessions s
LEFT JOIN vw_funnel_events f
    ON s.website_session_id = f.website_session_id
LEFT JOIN fact_orders o
    ON s.website_session_id = o.website_session_id
GROUP BY s.device_type;

-- funnel by traffic source
CREATE OR REPLACE VIEW vw_funnel_by_source AS
SELECT
    s.utm_source,
    s.utm_campaign,
    COUNT(DISTINCT s.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::NUMERIC
        / NULLIF(COUNT(DISTINCT s.website_session_id), 0),
        4
    ) AS conversion_rate
FROM fact_sessions s
LEFT JOIN fact_orders o
    ON s.website_session_id = o.website_session_id
GROUP BY s.utm_source, s.utm_campaign
ORDER BY conversion_rate DESC;

