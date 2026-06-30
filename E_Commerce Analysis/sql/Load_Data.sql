USE ecommerce_analysis;

-- =====================================================
-- LOAD CUSTOMERS
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verify
SELECT COUNT(*) AS Total_Customers FROM customers;

-- =====================================================
-- LOAD SELLERS
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS Total_Sellers FROM sellers;

-- =====================================================
-- LOAD PRODUCTS
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS Total_Products FROM products;

-- =====================================================
-- LOAD CATEGORY TRANSLATION
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/product_category_name_translation.csv'
INTO TABLE category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS Total_Categories FROM category_translation;

-- =====================================================
-- LOAD ORDERS
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
order_id,
customer_id,
order_status,
@purchase,
@approved,
@carrier,
@delivered,
@estimated
)
SET
order_purchase_timestamp =
NULLIF(STR_TO_DATE(@purchase,'%Y-%m-%d %H:%i:%s'),''),

order_approved_at =
NULLIF(STR_TO_DATE(@approved,'%Y-%m-%d %H:%i:%s'),''),

order_delivered_carrier_date =
NULLIF(STR_TO_DATE(@carrier,'%Y-%m-%d %H:%i:%s'),''),

order_delivered_customer_date =
NULLIF(STR_TO_DATE(@delivered,'%Y-%m-%d %H:%i:%s'),''),

order_estimated_delivery_date =
NULLIF(STR_TO_DATE(@estimated,'%Y-%m-%d %H:%i:%s'),'');
-- =====================================================
-- LOAD ORDERS_ITEMS
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
order_id,
order_item_id,
product_id,
seller_id,
@shipping,
price,
freight_value
)
SET
shipping_limit_date =
NULLIF(STR_TO_DATE(@shipping,'%Y-%m-%d %H:%i:%s'),'');
-- =====================================================
-- LOAD PAYMENTS
-- =====================================================
LOAD DATA LOCAL INFILE 'C:/Users/barat/Downloads/Olist/olist_order_payments_dataset.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;