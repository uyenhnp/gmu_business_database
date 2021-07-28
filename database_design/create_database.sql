CREATE DATABASE restaurant_near_gmu;

USE restaurant_near_gmu;

DROP TABLE transaction_business;
DROP TABLE category_business;
DROP TABLE reviews;
DROP TABLE businesses;
DROP TABLE transactions;
DROP TABLE categories;
DROP TABLE users;

CREATE TABLE businesses(
    business_id VARCHAR(50),
    business_name VARCHAR(200), 
    business_url VARCHAR(1000), 
    street VARCHAR(1000), 
    city VARCHAR(50), 
    state VARCHAR(50), 
    zip_code VARCHAR(10), 
    phone VARCHAR(12), 
    latitude DECIMAL(10, 8), 
    longitude DECIMAL(11, 8), 
    business_rating FLOAT, 
    is_closed BOOLEAN, 
    price VARCHAR(10), 
    review_count INT, 
    driving_distance FLOAT, 
    driving_duration FLOAT,
    PRIMARY KEY (business_id)
    );

CREATE TABLE transactions(
    transaction_id VARCHAR(1),
    transaction_name VARCHAR(50),
    PRIMARY KEY (transaction_id)
    );

CREATE TABLE categories(
    category_id VARCHAR(5),
    category_name VARCHAR(50),
    PRIMARY KEY (category_id)
    ); 

CREATE TABLE users(
    user_id VARCHAR(50),
    user_name VARCHAR(100),
    user_profile_url VARCHAR(200),
    user_image_url VARCHAR(200),
    PRIMARY KEY (user_id)
    );

CREATE TABLE transaction_business(
    business_id VARCHAR(50),
    transaction_id VARCHAR(1),
    PRIMARY KEY (business_id, transaction_id),
    FOREIGN KEY (business_id) REFERENCES businesses (business_id),
    FOREIGN KEY (transaction_id) REFERENCES transactions (transaction_id)
    ); 

CREATE TABLE category_business(
    business_id VARCHAR(50),
    category_id VARCHAR(5),
    PRIMARY KEY (business_id, category_id),
    FOREIGN KEY (business_id) REFERENCES businesses (business_id),
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
    );

CREATE TABLE reviews(
    review_id VARCHAR(50),
    review_rating FLOAT,
    text VARCHAR(300),
    time_created DATETIME,
    business_id VARCHAR(50),
    user_id VARCHAR(50),
    PRIMARY KEY (review_id),
    FOREIGN KEY (business_id) REFERENCES businesses (business_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
    );

-- POPULATE DATA
source insert_query/businesses.sql;
source insert_query/categories.sql;
source insert_query/transactions.sql;
source insert_query/category_business.sql;
source insert_query/transaction_business.sql;
source insert_query/users.sql;
source insert_query/reviews.sql;