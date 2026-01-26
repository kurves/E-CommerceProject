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

-- dim date



CREATE TABLE dim_date (
    date_key        INT PRIMARY KEY,
    date_day        DATE NOT NULL UNIQUE,
    year            INT NOT NULL,
    quarter         INT NOT NULL,
    month           INT NOT NULL,
    month_name      VARCHAR(20) NOT NULL,
    week_of_year    INT NOT NULL,
    day_of_month    INT NOT NULL,
    day_of_week     INT NOT NULL,
    day_name        VARCHAR(20) NOT NULL,
    is_weekend      BOOLEAN NOT NULL,
    is_month_start  BOOLEAN NOT NULL,
    is_month_end    BOOLEAN NOT NULL
);
INSERT INTO dim_date
SELECT
    TO_CHAR(d, 'YYYYMMDD')::INT        AS date_key,
    d                                  AS date_day,
    EXTRACT(YEAR FROM d)::INT          AS year,
    EXTRACT(QUARTER FROM d)::INT       AS quarter,
    EXTRACT(MONTH FROM d)::INT         AS month,
    TRIM(TO_CHAR(d, 'Month'))          AS month_name,
    EXTRACT(WEEK FROM d)::INT          AS week_of_year,
    EXTRACT(DAY FROM d)::INT           AS day_of_month,
    EXTRACT(ISODOW FROM d)::INT        AS day_of_week,
    TRIM(TO_CHAR(d, 'Day'))            AS day_name,
    CASE 
        WHEN EXTRACT(ISODOW FROM d) IN (6,7) THEN TRUE 
        ELSE FALSE 
    END                                AS is_weekend,
    d = DATE_TRUNC('month', d)::DATE   AS is_month_start,
    d = (
        DATE_TRUNC('month', d) 
        + INTERVAL '1 month - 1 day'
    )::DATE                            AS is_month_end
FROM GENERATE_SERIES(
    DATE '2012-01-01',
    DATE '2015-12-31',
    INTERVAL '1 day'
) AS d;





