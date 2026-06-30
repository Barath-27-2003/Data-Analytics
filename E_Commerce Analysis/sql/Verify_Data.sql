USE ecommerce_analysis;
-- =======================================================================
-- CHECKING FOR NULL VALUES
-- =======================================================================

SELECT *
FROM customers
WHERE customer_id IS NULL
   OR customer_unique_id IS NULL
   OR customer_city IS NULL
   OR customer_state IS NULL;

SELECT *
FROM products
WHERE product_category_name IS NULL
   OR product_weight_g IS NULL
   OR product_length_cm IS NULL
   OR product_height_cm IS NULL
   OR product_width_cm IS NULL;

SELECT *
FROM orders
WHERE order_purchase_timestamp IS NULL;

SELECT *
FROM payments
WHERE payment_type IS NULL
   OR payment_value IS NULL;

-- ======================================================
-- FINDING DUPLICATE RECORDS
-- ======================================================

SELECT
    customer_id,
    COUNT(*) AS Duplicate_Count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT
    order_id,
    COUNT(*) AS Duplicate_Count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    product_id,
    COUNT(*) AS Duplicate_Count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT
    seller_id,
    COUNT(*) AS Duplicate_Count
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- ======================================================
-- MISSING PRODUCT CATEGORIES
-- ======================================================

SELECT *
FROM products
WHERE product_category_name IS NULL;

SELECT
    COUNT(*) AS Missing_Categories
FROM products
WHERE product_category_name IS NULL;

SELECT
    p.product_category_name
FROM products p
LEFT JOIN category_translation c
ON p.product_category_name = c.product_category_name
WHERE c.product_category_name IS NULL
  AND p.product_category_name IS NOT NULL;

SELECT
    COUNT(*) AS Categories_Not_Translated
FROM products p
LEFT JOIN category_translation c
ON p.product_category_name = c.product_category_name
WHERE c.product_category_name IS NULL
  AND p.product_category_name IS NOT NULL;

-- =========================================================
-- INVALID PRICES
-- =========================================================

SELECT *
FROM order_items
WHERE price < 0;

SELECT *
FROM order_items
WHERE price = 0;

SELECT *
FROM order_items
WHERE freight_value < 0;

SELECT *
FROM order_items
WHERE price > 5000;

SELECT
    AVG(price) AS Average_Price
FROM order_items;

SELECT
    MAX(price) AS Highest_Price
FROM order_items;

SELECT
    MIN(price) AS Lowest_Price
FROM order_items;

-- =========================================================
-- INVALID PAYMENT VALUES
-- =========================================================

SELECT *
FROM payments
WHERE payment_value < 0;

SELECT *
FROM payments
WHERE payment_value = 0;

-- =========================================================
-- ORDERS WITHOUT CUSTOMERS
-- =========================================================

SELECT
    o.order_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- =========================================================
-- ORDER ITEMS WITHOUT PRODUCTS
-- =========================================================

SELECT
    oi.order_id,
    oi.product_id
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- =========================================================
-- ORDER ITEMS WITHOUT SELLERS
-- =========================================================

SELECT
    oi.order_id,
    oi.seller_id
FROM order_items oi
LEFT JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- =========================================================
-- PAYMENTS WITHOUT ORDERS
-- =========================================================

SELECT
    p.order_id
FROM payments p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- =========================================================
-- VERIFY TOTAL ROWS
-- =========================================================

SELECT COUNT(*) AS Customers FROM customers;
SELECT COUNT(*) AS Sellers FROM sellers;
SELECT COUNT(*) AS Products FROM products;
SELECT COUNT(*) AS Orders FROM orders;
SELECT COUNT(*) AS Order_Items FROM order_items;
SELECT COUNT(*) AS Payments FROM payments;
SELECT COUNT(*) AS Categories FROM category_translation;