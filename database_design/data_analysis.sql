-- Top 20 popular categories which businesses register for
SELECT
    category_name,
    total_businesses
FROM
    (SELECT
        b.category_name,
        COUNT(*) total_businesses,
        RANK() OVER(ORDER BY COUNT(*) DESC) ranking
    FROM category_business a
    LEFT JOIN categories b ON b.category_id = a.category_id
    GROUP BY a.category_id
    ORDER BY 2 DESC) m
WHERE ranking <= 20;

-- Average price for each category
SELECT
    ca.category_name,
    ROUND(a.avg_price, 2)
FROM 
    (SELECT
        c.category_id, 
        AVG(b.price) avg_price
    FROM businesses b
    LEFT JOIN category_business c ON c.business_id = b.business_id
    WHERE b.price is NOT NULL
    GROUP BY c.category_id) a
LEFT JOIN categories ca ON ca.category_id = a.category_id
ORDER BY 2;

-- Top 10 popular restaurants having the highest number of reviews
WITH highest_reviews AS
    (SELECT
        business_id,
        business_name,
        CONCAT(street, ' ', city, ' ', state, ' ', zip_code) AS address,
        review_count
    FROM businesses
    ORDER BY review_count DESC
    LIMIT 10)

SELECT
    h.business_name,
    h.address,
    h.review_count,
    c.category_name
FROM highest_reviews h
LEFT JOIN category_business cb ON cb.business_id = h.business_id
LEFT join categories c ON c.category_id = cb.category_id;

-- Top 20 businesses having the highest rating & more than 1000 reviews
SELECT 
    business_name,
    CONCAT(street, ' ', city, ' ', state, ' ', zip_code) AS address,
    driving_distance,
    driving_duration,
    review_count,
    business_rating
FROM businesses
WHERE review_count >= 1000
ORDER BY business_rating DESC, review_count DESC
LIMIT 10;

-- Top 10 businesses which are closest to the GMU campus based on the driving distance 
-- & have an affordable price (the lowest price level - 1)
SELECT
    business_name,
    CONCAT(street, ' ', city, ' ', state, ' ', zip_code) AS address,
    driving_distance,
    driving_duration,
    price
FROM businesses
WHERE price = 1
ORDER BY 3 ASC
LIMIT 10;

-- For each category: find the restaurant having the highest rating 
-- & compare the price of this business with the average price of all businesses.
SELECT
    m.business_name,
    CONCAT(street, city, state, zip_code) AS business_address,
    price,
    ROUND(avg_price, 2) avg_price,
    category_name,
    ranking,
    business_rating
FROM
    (SELECT
        b.business_name,
        b.street,
        b.city,
        b.state,
        b.zip_code,
        b.price,
        b.business_rating,
        d.category_name,
        AVG(b.price) OVER(PARTITION BY c.category_id) avg_price,
        RANK() OVER(PARTITION BY c.category_id ORDER BY b.business_rating) ranking
    FROM businesses b
    LEFT JOIN category_business c ON c.business_id = b.business_id
    LEFT JOIN categories d ON d.category_id = c.category_id
    WHERE price IS NOT NULL) m
WHERE ranking = 1
ORDER BY category_name;


