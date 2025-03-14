USE retail_transaction;

-- Taking a quick look at the first 10 records to get a sense of the data
SELECT TOP 10 * FROM transactions;

-- Checking the total number of transactions recorded in the dataset
SELECT COUNT(*) AS total_transactions FROM transactions;

-- Calculating the total revenue generated from all transactions
SELECT SUM(total_cost) AS total_revenue FROM transactions;

-- Finding out how many unique customers have made purchases
SELECT COUNT(DISTINCT customer_name) AS unique_customers FROM transactions;

-- Identifying the top 10 highest-spending customers
SELECT TOP 10 customer_name, SUM(total_cost) AS total_spent
FROM transactions
GROUP BY customer_name
ORDER BY total_spent DESC;

-- Calculating the average value of a single transaction
SELECT AVG(total_cost) AS avg_order_value FROM transactions;

-- Understanding customer payment preferences by counting usage of each payment method
SELECT payment_method, COUNT(*) AS usage_count
FROM transactions
GROUP BY payment_method
ORDER BY usage_count DESC;

-- Checking which cities contribute the most to total sales
SELECT city, SUM(total_cost) AS total_sales
FROM transactions
GROUP BY city
ORDER BY total_sales DESC;

-- Identifying customers who have only made a single purchase, which could indicate a churn risk
SELECT customer_name, COUNT(*) AS order_count
FROM transactions
GROUP BY customer_name
HAVING COUNT(*) = 1;

-- Determining the last purchase date for each customer
SELECT customer_name, MAX(date) AS last_purchase_date
FROM transactions
GROUP BY customer_name;

-- Finding the top 10 most frequently purchased products
SELECT TOP 10 product, COUNT(*) AS times_purchased
FROM transactions
GROUP BY product
ORDER BY times_purchased DESC;

-- Identifying the product that has generated the highest total revenue
SELECT TOP 1 product, SUM(total_cost) AS total_revenue
FROM transactions
GROUP BY product
ORDER BY total_revenue DESC;

-- Measuring how often customers place repeat orders by calculating the average time between their purchases
WITH purchase_gaps AS (
    SELECT 
        customer_name, 
        date,
        LAG(date) OVER (PARTITION BY customer_name ORDER BY date) AS prev_purchase
    FROM transactions
)
SELECT 
    customer_name, 
    AVG(DATEDIFF(DAY, prev_purchase, date)) AS avg_days_between_orders
FROM purchase_gaps
WHERE prev_purchase IS NOT NULL
GROUP BY customer_name
ORDER BY avg_days_between_orders DESC;

-- Identifying customers whose spending has increased over time
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

-- Finding the highest-spending customer in each city
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

-- Estimating the customer lifetime value (CLV) for the top 10 customers
SELECT TOP 10 
    customer_name, 
    COUNT(*) AS total_orders, 
    AVG(total_cost) AS avg_order_value,
    (COUNT(*) * AVG(total_cost)) AS estimated_clv
FROM transactions
GROUP BY customer_name
ORDER BY estimated_clv DESC;

-- Ranking store types based on total revenue generated
SELECT store_type, SUM(total_cost) AS total_revenue
FROM transactions
GROUP BY store_type
ORDER BY total_revenue DESC;

-- Checking if returning customers are more likely to use promotions
SELECT promotion, COUNT(*) AS times_used
FROM transactions
WHERE customer_name IN (
    SELECT customer_name FROM transactions GROUP BY customer_name HAVING COUNT(*) > 1
)
GROUP BY promotion
ORDER BY times_used DESC;

-- Analyzing revenue trends over the last two years to spot any seasonal sales patterns
SELECT year, month, SUM(total_cost) AS monthly_revenue
FROM transactions
GROUP BY year, month
ORDER BY year DESC, month DESC;

-- Measuring how frequently discounts are used in transactions
SELECT COUNT(*) AS discounted_orders, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions) AS discount_usage_percentage
FROM transactions
WHERE discount_applied = 1;

-- Identifying customers who primarily buy only when there’s a discount
SELECT customer_name, 
       COUNT(*) AS total_orders, 
       SUM(CASE WHEN discount_applied = 1 THEN 1 ELSE 0 END) AS discounted_orders,
       SUM(CASE WHEN discount_applied = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS discount_dependency
FROM transactions
GROUP BY customer_name
HAVING (SUM(CASE WHEN discount_applied = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 80 -- More than 80% of purchases were discounted
ORDER BY discount_dependency DESC;

-- Identifying the best-selling product for each month
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
