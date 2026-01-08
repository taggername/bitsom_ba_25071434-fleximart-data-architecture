-- Query 1: Customer Purchase History
-- Business Question:Generate a detailed report showing each customer's name, email, total number of orders placed, and total amount spent. Include only customers who have placed at least 2 orders and spent more than ₹5,000. Order by total amount spent in descending order.
-- Expected to return customers with 2+ orders and >5000 spent

SELECT
  first_name AND last_name AS customer_name, 
    email, 
    COUNT(DISTINCT transaction_id) AS total_orders, 
    SUM(quantity * unit_price) AS total_spent
FROM customers
JOIN sales ON customers.customer_id = sales.transaction_id
GROUP BY customers.customer_id, first_name, last_name, email
HAVING COUNT(DISTINCT transaction_id) >= 2 
   AND SUM(quantity * unit_price) > 5000
ORDER BY total_spent DESC;

-- Query 2: Product Sales Analysis
-- Business Question: For each product category, show the category name, number of different products sold, total quantity sold, and total revenue generated. Only include categories that have generated more than ₹10,000 in revenue. Order by total revenue descending.
-- Expected to return categories with >10000 revenue

SELECT
      p.category, 
    COUNT(DISTINCT p.product_id) AS num_products, 
    SUM(stock_quantity) AS total_quantity_sold, 
    SUM(stock_quantity * price) AS total_revenue
FROM products p
JOIN sales ON p.product_id = sales.product_id
GROUP BY p.category
HAVING SUM(sales.quantity * sales.unit_price) > 10000
ORDER BY total_revenue DESC;

-- Query 3: Monthly Sales Trend
-- Business Question: Show monthly sales trends for the year 2024. For each month, display the month name, total number of orders, total revenue, and the running total of revenue (cumulative revenue from January to that month)
-- Expected to show monthly and cumulative revenue

SELECT
 MONTHNAME(transaction_date) AS month_name,
    COUNT(DISTINCT transaction_id) AS total_orders,
    -- We multiply quantity and unit_price to get the revenue
    SUM(quantity * unit_price) AS monthly_revenue,
    -- This calculates the running total using the math
    SUM(SUM(quantity * unit_price)) OVER (ORDER BY MONTH(transaction_date)) AS cumulative_revenue
FROM sales
WHERE transaction_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY MONTH(transaction_date), month_name
ORDER BY MONTH(transaction_date);
