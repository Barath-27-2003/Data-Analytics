-- =====================================================
-- Project : E-Commerce Sales & Customer Analytics
-- File    : 05_Intermediate_SQL.sql
-- Concepts: INNER JOIN, LEFT JOIN, RIGHT JOIN,
--           SELF JOIN, CASE, Subqueries
-- =====================================================

USE ecommerce_analysis;

-- =====================================================
-- 1. INNER JOIN
-- Customer Details with Orders
-- =====================================================

SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- =====================================================
-- 2. INNER JOIN
-- Product Sales with Seller Details
-- =====================================================

SELECT
    oi.order_id,
    oi.product_id,
    s.seller_id,
    s.seller_city,
    s.seller_state,
    oi.price
FROM order_items oi
INNER JOIN sellers s
ON oi.seller_id = s.seller_id;

-- =====================================================
-- 3. INNER JOIN
-- Orders with Payment Information
-- =====================================================

SELECT
    o.order_id,
    o.order_status,
    p.payment_type,
    p.payment_value
FROM orders o
INNER JOIN payments p
ON o.order_id = p.order_id;

-- =====================================================
-- 4. LEFT JOIN
-- Products with English Category Name
-- =====================================================

SELECT
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english
FROM products p
LEFT JOIN category_translation ct
ON p.product_category_name = ct.product_category_name;

-- =====================================================
-- 5. LEFT JOIN
-- Customers Including Those Without Orders
-- =====================================================

SELECT
    c.customer_id,
    c.customer_city,
    o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- =====================================================
-- 6. RIGHT JOIN
-- Sellers with Matching Order Items
-- =====================================================

SELECT
    oi.order_id,
    oi.product_id,
    s.seller_id,
    s.seller_city
FROM order_items oi
RIGHT JOIN sellers s
ON oi.seller_id = s.seller_id;

-- =====================================================
-- 7. RIGHT JOIN
-- Orders with Payment Records
-- =====================================================

SELECT
    o.order_id,
    p.payment_type,
    p.payment_value
FROM orders o
RIGHT JOIN payments p
ON o.order_id = p.order_id;

-- =====================================================
-- 8. SELF JOIN
-- Customers Living in the Same City
-- =====================================================

SELECT
    A.customer_id AS Customer1,
    B.customer_id AS Customer2,
    A.customer_city
FROM customers A
JOIN customers B
ON A.customer_city = B.customer_city
AND A.customer_id <> B.customer_id;

-- =====================================================
-- 9. CASE
-- Categorize Payment Values
-- =====================================================

SELECT
    payment_value,
    CASE
        WHEN payment_value < 100 THEN 'Low'
        WHEN payment_value BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS Payment_Category
FROM payments;

-- =====================================================
-- 10. CASE
-- Delivery Status
-- =====================================================

SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status = 'delivered' THEN 'Completed'
        WHEN order_status = 'shipped' THEN 'In Transit'
        WHEN order_status = 'canceled' THEN 'Cancelled'
        ELSE 'Pending'
    END AS Delivery_Status
FROM orders;

-- =====================================================
-- 11. Subquery
-- Orders Above Average Payment
-- =====================================================

SELECT
    order_id,
    payment_value
FROM payments
WHERE payment_value >
(
    SELECT AVG(payment_value)
    FROM payments
);

-- =====================================================
-- 12. Subquery
-- Products Above Average Price
-- =====================================================

SELECT
    product_id,
    price
FROM order_items
WHERE price >
(
    SELECT AVG(price)
    FROM order_items
);

-- =====================================================
-- 13. Subquery
-- Customers with More Than One Order
-- =====================================================

SELECT
    customer_id,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- =====================================================
-- 14. Correlated Subquery
-- Highest Payment Made by Each Customer
-- =====================================================

SELECT
    o.customer_id,
    p.payment_value
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
WHERE p.payment_value =
(
    SELECT MAX(p2.payment_value)
    FROM payments p2
    JOIN orders o2
    ON p2.order_id = o2.order_id
    WHERE o.customer_id = o2.customer_id
);

-- =====================================================
-- 15. EXISTS
-- Customers Who Placed At Least One Order
-- =====================================================

SELECT
    customer_id
FROM customers c
WHERE EXISTS
(
    SELECT *
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- =====================================================
-- 16. NOT EXISTS
-- Customers Without Orders
-- =====================================================

SELECT
    customer_id
FROM customers c
WHERE NOT EXISTS
(
    SELECT *
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- =====================================================
-- 17. IN
-- Orders from Customers in State 'SP'
-- =====================================================

SELECT
    order_id,
    customer_id
FROM orders
WHERE customer_id IN
(
    SELECT customer_id
    FROM customers
    WHERE customer_state = 'SP'
);

-- =====================================================
-- 18. NOT IN
-- Customers Not in SP or RJ
-- =====================================================

SELECT
    customer_id,
    customer_state
FROM customers
WHERE customer_state NOT IN ('SP','RJ');

-- =====================================================
-- 19. HAVING
-- Sellers with Revenue Greater Than 50000
-- =====================================================

SELECT
    seller_id,
    SUM(price) AS Revenue
FROM order_items
GROUP BY seller_id
HAVING SUM(price) > 50000
ORDER BY Revenue DESC;

-- =====================================================
-- 20. Multiple INNER JOIN
-- Customer, Seller, Payment and Product Information
-- =====================================================

SELECT
    o.order_id,
    c.customer_city,
    p.payment_value,
    oi.price,
    s.seller_city
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN payments p
ON o.order_id = p.order_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN sellers s
ON oi.seller_id = s.seller_id;

