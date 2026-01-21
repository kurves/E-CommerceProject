-- create raw data tables
-- load data from csv files
-- validate the load 
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    website_session_id INT,
    user_id INT,
    primary_product_id INT,
    items_purchased INT,
    price_usd NUMERIC(10,2),
    cogs_usd NUMERIC(10,2)
);
CREATE TABLE order_item_refunds (
    order_item_refund_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    order_item_id INT,
    order_id INT,
    refund_amount_usd NUMERIC(10,2)
);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    order_id INT,
    product_id INT,
    is_primary_item BOOLEAN,
    price_usd NUMERIC(10,2),
    cogs_usd NUMERIC(10,2)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    product_name TEXT
);
CREATE TABLE website_sessions (
    website_session_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    user_id INT,
    is_repeat_session BOOLEAN,
    utm_source TEXT,
    utm_campaign TEXT,
    utm_content TEXT,
    device_type TEXT,
    http_referer TEXT
);
CREATE TABLE website_pageviews (
    website_pageview_id INT PRIMARY KEY,
    created_at TIMESTAMP,
    website_session_id INT,
    pageview_url TEXT
);

--\copy orders FROM 'C:\Users\TOM\Desktop\Data Analysis\ToyStoreAnalysis\orders.csv' CSV HEADER;
--\copy order_items FROM 'C:\Users\TOM\Desktop\Data Analysis\ToyStoreAnalysis\order_items.csv' CSV HEADER;
--\copy order_item_refunds FROM 'C:\Users\TOM\Desktop\Data Analysis\ToyStoreAnalysis\order_item_refunds.csv' CSV HEADER;
--\copy products FROM 'C:\Users\TOM\Desktop\Data Analysis\ToyStoreAnalysis\products.csv' CSV HEADER;
--\copy website_sessions FROM 'C:\Users\TOM\Desktop\Data Analysis\ToyStoreAnalysis\website_sessions.csv' CSV HEADER;
--\copy website_pageviews FROM 'C:\Users\TOM\Desktop\Data Analysis\ToyStoreAnalysis\website_pageviews.csv' CSV HEADER;
SELECT COUNT(*) FROM orders;
SELECT MIN(created_at), MAX(created_at) FROM orders;
SELECT * FROM orders LIMIT 10;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_sessions
FOREIGN KEY (website_session_id)
REFERENCES website_sessions (website_session_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_orders
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_products
FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE website_pageviews
ADD CONSTRAINT fk_pageviews_sessions
FOREIGN KEY (website_session_id)
REFERENCES website_sessions (website_session_id);

ALTER TABLE order_item_refunds
ADD CONSTRAINT fk_refunds_order_items
FOREIGN KEY (order_item_id)
REFERENCES order_items (order_item_id);

CREATE INDEX idx_orders_created_at ON orders (created_at);
CREATE INDEX idx_sessions_created_at ON website_sessions (created_at);
CREATE INDEX idx_order_items_product ON order_items (product_id);



