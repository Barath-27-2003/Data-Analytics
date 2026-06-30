-- 1.Display All Customers LIMIT 5
SELECT *
FROM customers;
-- 2. Display All Products
SELECT *
FROM products;
-- 3. Total Number of Customers
SELECT COUNT(*) AS Total_Customers
FROM customers;
-- 4. Total Number of Orders
SELECT COUNT(*) AS Total_Orders
FROM orders;
-- 5. Total Number of Products
SELECT COUNT(*) AS Total_Products
FROM products;
-- 6. Total Revenue
SELECT
ROUND(SUM(payment_value),2) AS Total_Revenue
FROM payments;
-- 7. Average Order Value
SELECT
ROUND(AVG(payment_value),2) AS Average_Order_Value
FROM payments;
-- 8. Highest Payment
SELECT
MAX(payment_value) AS Highest_Payment
FROM payments;

-- 9. Lowest Payment
SELECT
MIN(payment_value) AS Lowest_Payment
FROM payments;
-- 10. Average Product Price
SELECT
ROUND(AVG(price),2) AS Average_Product_Price
FROM order_items;
-- 11. Most Expensive Product Sold
SELECT *
FROM order_items
ORDER BY price DESC
LIMIT 1;
-- 12. Cheapest Product Sold
SELECT *
FROM order_items
ORDER BY price
LIMIT 1;
-- 13. Orders by Status
SELECT
order_status,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_status
ORDER BY Total_Orders DESC;
-- 14. Customers by State
SELECT
customer_state,
COUNT(*) AS Total_Customers
FROM customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;
-- 15. Top 10 Cities by Customers
SELECT
customer_city,
COUNT(*) AS Customer_Count
FROM customers
GROUP BY customer_city
ORDER BY Customer_Count DESC
LIMIT 10;
-- 16. Sellers by State
SELECT
seller_state,
COUNT(*) AS Sellers
FROM sellers
GROUP BY seller_state
ORDER BY Sellers DESC;
-- 17. Products by Category
SELECT
product_category_name,
COUNT(*) AS Products
FROM products
GROUP BY product_category_name
ORDER BY Products DESC;
-- 18. Payment Methods
SELECT
payment_type,
COUNT(*) AS Total
FROM payments
GROUP BY payment_type
ORDER BY Total DESC;
-- 19. Revenue by Payment Method
SELECT
payment_type,
ROUND(SUM(payment_value),2) AS Revenue
FROM payments
GROUP BY payment_type
ORDER BY Revenue DESC;
-- 20. Average Installments
SELECT
ROUND(AVG(payment_installments),2) AS Average_Installments
FROM payments;
-- 21. Monthly Orders
SELECT
YEAR(order_purchase_timestamp) AS Year,
MONTH(order_purchase_timestamp) AS Month,
COUNT(*) AS Orders
FROM orders
GROUP BY Year, Month
ORDER BY Year, Month;
-- 22. Monthly Revenue
SELECT
YEAR(o.order_purchase_timestamp) AS Year,
MONTH(o.order_purchase_timestamp) AS Month,
ROUND(SUM(p.payment_value),2) AS Revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY Year, Month
ORDER BY Year, Month;
-- 23. Average Freight Cost
SELECT
ROUND(AVG(freight_value),2) AS Average_Freight
FROM order_items;
-- 24. Total Freight Cost
SELECT
ROUND(SUM(freight_value),2) AS Total_Freight
FROM order_items;
-- 25. Top 10 Highest Freight Orders
SELECT
order_id,
freight_value
FROM order_items
ORDER BY freight_value DESC
LIMIT 10;
-- 26. Orders Per Customer
SELECT
customer_id,
COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY customer_id
ORDER BY Total_Orders DESC;
-- 27. Products Sold
SELECT
SUM(order_item_id) AS Total_Items_Sold
FROM order_items;
-- 28. Average Products Per Order
SELECT
ROUND(AVG(Item_Count),2) AS Avg_Items_Per_Order
FROM
(
SELECT
order_id,
COUNT(*) AS Item_Count
FROM order_items
GROUP BY order_id
) AS OrderSummary;
-- 29. Top 10 Most Sold Products
SELECT
product_id,
COUNT(*) AS Quantity_Sold
FROM order_items
GROUP BY product_id
ORDER BY Quantity_Sold DESC
LIMIT 10;
-- 30. Top 10 Customers by Spending
SELECT
o.customer_id,
ROUND(SUM(p.payment_value),2) AS Total_Spent
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY Total_Spent DESC
LIMIT 10;
-- 31. Top 10 Sellers by Revenue
SELECT
seller_id,
ROUND(SUM(price),2) AS Revenue
FROM order_items
GROUP BY seller_id
ORDER BY Revenue DESC
LIMIT 10;
-- 32. Revenue by Product Category
SELECT
p.product_category_name,
ROUND(SUM(oi.price),2) AS Revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Revenue DESC;
-- 33. Top 10 Product Categories
SELECT
product_category_name,
COUNT(*) AS Total_Products
FROM products
GROUP BY product_category_name
ORDER BY Total_Products DESC
LIMIT 10;
-- 34. Delivered Orders
SELECT COUNT(*) AS Delivered_Orders
FROM orders
WHERE order_status='delivered';
-- 35. Cancelled Orders
SELECT COUNT(*) AS Cancelled_Orders
FROM orders
WHERE order_status='canceled';