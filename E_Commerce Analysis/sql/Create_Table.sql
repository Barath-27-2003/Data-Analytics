-- =====================================================
-- Project: E-Commerce Sales & Customer Analytics
-- File   : 01_Create_Database.sql
-- Database: ecommerce_analysis
-- =====================================================

-- Drop database if it already exists
DROP DATABASE IF EXISTS ecommerce_analysis;

-- Create database
CREATE DATABASE ecommerce_analysis;

-- Use the database
USE ecommerce_analysis;

-- =====================================================
-- TABLE 1 : CUSTOMERS
-- =====================================================

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- =====================================================
-- TABLE 2 : SELLERS
-- =====================================================

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

-- =====================================================
-- TABLE 3 : PRODUCTS
-- =====================================================

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2)
);

-- =====================================================
-- TABLE 4 : PRODUCT CATEGORY TRANSLATION
-- =====================================================

CREATE TABLE category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

-- =====================================================
-- TABLE 5 : ORDERS
-- =====================================================

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(30),

    order_purchase_timestamp DATETIME,

    order_approved_at DATETIME,

    order_delivered_carrier_date DATETIME,

    order_delivered_customer_date DATETIME,

    order_estimated_delivery_date DATETIME,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id)
);

-- =====================================================
-- TABLE 6 : ORDER ITEMS
-- =====================================================

CREATE TABLE order_items (

    order_id VARCHAR(50),

    order_item_id INT,

    product_id VARCHAR(50),

    seller_id VARCHAR(50),

    shipping_limit_date DATETIME,

    price DECIMAL(10,2),

    freight_value DECIMAL(10,2),

    PRIMARY KEY(order_id,order_item_id),

    CONSTRAINT fk_orderitems_orders
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_orderitems_products
        FOREIGN KEY(product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_orderitems_sellers
        FOREIGN KEY(seller_id)
        REFERENCES sellers(seller_id)
);

-- =====================================================
-- TABLE 7 : PAYMENTS
-- =====================================================

CREATE TABLE payments (

    order_id VARCHAR(50),

    payment_sequential INT,

    payment_type VARCHAR(30),

    payment_installments INT,

    payment_value DECIMAL(10,2),

    PRIMARY KEY(order_id,payment_sequential),

    CONSTRAINT fk_payments_orders
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

-- =====================================================
-- Verify Tables
-- =====================================================

SHOW TABLES;

-- =====================================================
-- Verify Structure
-- =====================================================

DESCRIBE customers;
DESCRIBE sellers;
DESCRIBE products;
DESCRIBE category_translation;
DESCRIBE orders;
DESCRIBE order_items;
DESCRIBE payments;