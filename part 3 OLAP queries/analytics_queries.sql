-- Query 1: Monthly Sales Drill-Down
-- Business Scenario: [Copy scenario]
-- Demonstrates: Drill-down from Year to Quarter to Month

SELECT 
    YEAR(transaction_date) AS year,
    CONCAT('Q', QUARTER(transaction_date)) AS quarter,
    MONTHNAME(transaction_date) AS month_name,
    SUM(unit_price * quantity) AS total_sales, -- Use unit_price * quantity if unit_price is per item
    SUM(quantity) AS total_quantity
FROM sales
WHERE YEAR(transaction_date) = 2024
GROUP BY 
    year, 
    quarter, 
    month_name,
    MONTH(transaction_date) -- Keeps grouping correct
ORDER BY 
    year, 
    MONTH(transaction_date); -- Ensures January comes before February


-- Query 2: Top 10 Products by Revenue
-- Business Scenario: [Copy scenario]
-- Includes: Revenue percentage calculation

SELECT 
    p.product_name, 
    p.category, 
    SUM(s.quantity) AS units_sold, 
    SUM(s.unit_price * s.quantity) AS revenue,
    -- Calculate percentage: (Product Revenue / Total Revenue) * 100
    CONCAT(
        ROUND(
            (SUM(s.unit_price * s.quantity) / SUM(SUM(s.unit_price * s.quantity)) OVER()) * 100, 
            1
        ), 
        '%'
    ) AS revenue_percentage
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;


-- Query 3: Customer Segmentation
-- Business Scenario: [Copy scenario]
-- Segments: High/Medium/Low value customers

SELECT
     (
    -- First, calculate total spend for every individual customer
    SELECT 
        customer_id, 
        SUM(unit_price * quantity) AS total_spent
    FROM sales
    GROUP BY customer_id
)
SELECT 
    CASE 
        WHEN total_spent > 50000 THEN 'High Value'
        WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(customer_id) AS customer_count,
    SUM(total_spent) AS total_revenue,
    AVG(total_spent) AS avg_revenue
FROM CustomerSpending
GROUP BY customer_segment
ORDER BY total_revenue DESC;

