-- Create Customers Table
CREATE TABLE Customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_unique_id VARCHAR(255) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city VARCHAR(255) NOT NULL,
    customer_state VARCHAR(255) NOT NULL,
    customer_first_name VARCHAR(255),
    customer_last_name VARCHAR(255),
    customer_email VARCHAR(255),
    customer_phone VARCHAR(20)
);

-- Create Products Table
CREATE TABLE Products (
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255)
);

-- Create Sellers Table
CREATE TABLE Sellers (
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(255) NOT NULL,
    seller_state VARCHAR(255) NOT NULL
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id VARCHAR(255) PRIMARY KEY,
    customer_id VARCHAR(255) ,
    order_status VARCHAR(50),
    order_purchase_timestamp DATE ,
    order_approved_at DATE,
    order_delivered_carrier_date DATE,
    order_delivered_customer_date DATE,
    order_estimated_delivery_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create OrderItems Table
CREATE TABLE OrderItems (
    order_id VARCHAR(255) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    seller_id VARCHAR(255) NOT NULL,
    shipping_limit_date DATE,
    price DECIMAL(18, 2) NOT NULL,
    freight_value DECIMAL(18, 2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id)
);

-- Create OrderPayments Table
CREATE TABLE OrderPayments (
    order_id VARCHAR(255) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(50) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(18, 2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Create OrderReviews Table
CREATE TABLE OrderReviews (
    review_id VARCHAR(255) PRIMARY KEY,
    order_id VARCHAR(255) NOT NULL,
    review_score INT NOT NULL,
    review_creation_date DATE NOT NULL,
    review_answer_timestamp DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);