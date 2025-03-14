use retail_transaction;

-- Just taking a quick peek at the data to see what's inside
SELECT TOP 10 * FROM transactions;

-- How many total transactions have we got in this dataset?
SELECT COUNT(*) AS total_transactions FROM transactions;

-- Let’s see how much money customers have spent in total
SELECT SUM(total_cost) AS total_revenue FROM transactions;

-- How many different people have bought stuff? 
SELECT COUNT(DISTINCT customer_name) AS unique_customers FROM transactions;

-- Who's dropping the most cash? Let’s see our VIPs!
SELECT top 10 customer_name, SUM(total_cost) AS total_spent
FROM transactions
GROUP BY customer_name
ORDER BY total_spent DESC;

-- On average, how much does each transaction cost?
SELECT AVG(total_cost) AS avg_order_value FROM transactions;


-- Curious: How are most people paying?
SELECT payment_method, COUNT(*) AS usage_count
FROM transactions
GROUP BY payment_method
ORDER BY usage_count DESC;

-- Which cities are bringing in the most sales?
SELECT city, SUM(total_cost) AS total_sales
FROM transactions
GROUP BY city
ORDER BY total_sales DESC;

-- These folks only bought once... huge churn risk!
SELECT customer_name, COUNT(*) AS order_count
FROM transactions
GROUP BY customer_name
HAVING COUNT(*) = 1;

-- When was the last time each customer shopped with us?
SELECT customer_name, MAX(date) AS last_purchase_date
FROM transactions
GROUP BY customer_name;

-- What are people buying the most? Let’s check the top 10 items.
SELECT top 10 product, COUNT(*) AS times_purchased
FROM transactions
GROUP BY product
ORDER BY times_purchased DESC

-- Which product is making us the most money?
SELECT top 1 product, SUM(total_cost) AS total_revenue
FROM transactions
GROUP BY product
ORDER BY total_revenue DESC

-- How often do our customers buy again? Checking time gaps between their orders.
WITH purchase_gaps AS (
    SELECT 
        customer_name, 
        date,
        LAG(date) OVER (PARTITION BY customer_name ORDER BY date) AS prev_purchase
    FROM transactions
)
SELECT 
    customer_name, 
    AVG(DATEDIFF(day, prev_purchase, date)) AS avg_days_between_orders
FROM purchase_gaps
WHERE prev_purchase IS NOT NULL
GROUP BY customer_name
ORDER BY avg_days_between_orders DESC;

-- We love customers who spend more over time! Who are they?
WITH spending_growth AS (
    SELECT 
        customer_name, 
        year, 
        SUM(total_cost) AS yearly_spent
    FROM transactions
    GROUP BY customer_name, year
)
SELECT 
    customer_name,
    MIN(yearly_spent) AS min_spent,
    MAX(yearly_spent) AS max_spent
FROM spending_growth
GROUP BY customer_name
HAVING MAX(yearly_spent) > MIN(yearly_spent)
ORDER BY max_spent DESC;



-- Who’s our biggest spender in each city?
WITH city_top_spenders AS (
    SELECT 
        city, 
        customer_name, 
        SUM(total_cost) AS total_spent,
        RANK() OVER (PARTITION BY city ORDER BY SUM(total_cost) DESC) AS rank
    FROM transactions
    GROUP BY city, customer_name
)
SELECT city, customer_name, total_spent
FROM city_top_spenders
WHERE rank = 1;


-- Let’s estimate how much a customer is worth over their lifetime.
SELECT top 10 
    customer_name, 
    COUNT(*) AS total_orders, 
    AVG(total_cost) AS avg_order_value,
    (COUNT(*) * AVG(total_cost)) AS estimated_clv
FROM transactions
GROUP BY customer_name
ORDER BY estimated_clv DESC;

-- Which store type makes us the most money? Let’s rank them.
SELECT store_type, SUM(total_cost) AS total_revenue
FROM transactions
GROUP BY store_type
ORDER BY total_revenue DESC;

-- Do returning customers respond to discounts more?
SELECT promotion, COUNT(*) AS times_used
FROM transactions
WHERE customer_name IN (
    SELECT customer_name FROM transactions GROUP BY customer_name HAVING COUNT(*) > 1
)
GROUP BY promotion
ORDER BY times_used DESC;

-- Checking revenue trends over the last 2 years to identify sales patterns
SELECT year, month, SUM(total_cost) AS monthly_revenue
FROM transactions
GROUP BY year, month
ORDER BY year DESC, month DESC;




-- How often do customers use discounts?
SELECT COUNT(*) AS discounted_orders, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions) AS discount_usage_percentage
FROM transactions
WHERE discount_applied = 1;


-- Are some customers ONLY buying when there’s a discount?
SELECT customer_name, 
       COUNT(*) AS total_orders, 
       SUM(CASE WHEN discount_applied = 1 THEN 1 ELSE 0 END) AS discounted_orders,
       SUM(CASE WHEN discount_applied = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS discount_dependency
FROM transactions
GROUP BY customer_name
HAVING (SUM(CASE WHEN discount_applied = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 80 -- More than 80% of purchases were discounted
ORDER BY discount_dependency DESC;






-- Which product was the top seller for each month?
WITH ranked_sales AS (
    SELECT product, year, month, COUNT(*) AS total_sold,
           RANK() OVER (PARTITION BY year, month ORDER BY COUNT(*) DESC) AS rank
    FROM transactions
    GROUP BY product, year, month
)
SELECT year, month, product, total_sold
FROM ranked_sales
WHERE rank = 1
ORDER BY year DESC, month DESC;
