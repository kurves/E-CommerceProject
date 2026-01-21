CREATE TABLE dim_products (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    product_created_at TIMESTAMP
);

INSERT INTO dim_products
SELECT
    product_id,
    product_name,
    created_at
FROM products;
