---------------------------------------------------------------
-- SAMPLE TABLES (as required for analytical queries)
---------------------------------------------------------------

CREATE TABLE products (
    product_id   NUMBER PRIMARY KEY,
    category     VARCHAR2(50),
    price        NUMBER(10,2)
);

CREATE TABLE sales (
    sale_id      NUMBER PRIMARY KEY,
    product_id   NUMBER,
    quantity     NUMBER,
    sale_date    DATE,
    customer_id  NUMBER,
    channel      VARCHAR2(20),  -- 'ONLINE' or 'STORE'
    CONSTRAINT fk_sale_prod FOREIGN KEY (product_id) REFERENCES products(product_id)
);

---------------------------------------------------------------
-- QUERY 1: TOTAL SALES AMOUNT FOR EACH PRODUCT CATEGORY (LAST QUARTER)
---------------------------------------------------------------
SELECT 
    p.category,
    SUM(p.price * s.quantity) AS total_sales
FROM products p
JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_date >= ADD_MONTHS(TRUNC(SYSDATE,'Q'), -3)
GROUP BY p.category;

---------------------------------------------------------------
-- QUERY 2: TOP 5 CUSTOMERS WHO SPENT THE MOST IN THE PAST YEAR
---------------------------------------------------------------
SELECT 
    customer_id,
    SUM(p.price * s.quantity) AS total_spent
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.sale_date >= ADD_MONTHS(SYSDATE, -12)
GROUP BY customer_id
ORDER BY total_spent DESC
FETCH FIRST 5 ROWS ONLY;

---------------------------------------------------------------
-- QUERY 3: AVERAGE ORDER VALUE – ONLINE VS IN-STORE
---------------------------------------------------------------
SELECT 
    channel,
    AVG(p.price * s.quantity) AS avg_order_value
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY channel;
