-- 1. Insert 30 Dates (Jan 2024)
INSERT INTO dim_date VALUES 
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, 0),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, 0),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, 0),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, 0),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, 0),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, 1),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, 1),
-- ... (Logic: Repeat for 30 days)
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, 0),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, 0),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, 0),
(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, 0),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, 0),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, 1),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, 1),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, 0),
(20240116, '2024-01-16', 'Tuesday', 16, 1, 'January', 'Q1', 2024, 0),
(20240117, '2024-01-17', 'Wednesday', 17, 1, 'January', 'Q1', 2024, 0),
(20240118, '2024-01-18', 'Thursday', 18, 1, 'January', 'Q1', 2024, 0),
(20240119, '2024-01-19', 'Friday', 19, 1, 'January', 'Q1', 2024, 0),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, 1),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, 1),
(20240122, '2024-01-22', 'Monday', 22, 1, 'January', 'Q1', 2024, 0),
(20240123, '2024-01-23', 'Tuesday', 23, 1, 'January', 'Q1', 2024, 0),
(20240124, '2024-01-24', 'Wednesday', 24, 1, 'January', 'Q1', 2024, 0),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, 0),
(20240126, '2024-01-26', 'Friday', 26, 1, 'January', 'Q1', 2024, 0),
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January', 'Q1', 2024, 1),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, 1),
(20240129, '2024-01-29', 'Monday', 29, 1, 'January', 'Q1', 2024, 0),
(20240130, '2024-01-30', 'Tuesday', 30, 1, 'January', 'Q1', 2024, 0);

-- 2. Insert 15 Products
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P01', 'Gaming Laptop', 'Electronics', 'PC', 85000.00),
('P02', 'Smartphone Z', 'Electronics', 'Mobile', 45000.00),
('P03', 'LED Monitor', 'Electronics', 'Display', 12000.00),
('P04', 'Mixer Grinder', 'Appliances', 'Kitchen', 4500.00),
('P05', 'Refrigerator', 'Appliances', 'Kitchen', 35000.00),
('P06', 'Microwave', 'Appliances', 'Kitchen', 8000.00),
('P07', 'Office Chair', 'Furniture', 'Seating', 7500.00),
('P08', 'Dining Table', 'Furniture', 'Tables', 25000.00),
('P09', 'Bookshelf', 'Furniture', 'Storage', 5000.00),
('P10', 'Smart Watch', 'Electronics', 'Wearable', 3500.00),
('P11', 'Air Purifier', 'Appliances', 'Home', 12000.00),
('P12', 'Sofa Set', 'Furniture', 'Seating', 45000.00),
('P13', 'Tablet', 'Electronics', 'Mobile', 22000.00),
('P14', 'Vacuum Cleaner', 'Appliances', 'Home', 9500.00),
('P15', 'Floor Lamp', 'Furniture', 'Decor', 2500.00);

-- 3. Insert 12 Customers
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C01', 'Amit Kumar', 'Mumbai', 'Maharashtra', 'Premium'),
('C02', 'Sara Khan', 'Mumbai', 'Maharashtra', 'Standard'),
('C03', 'John Doe', 'Delhi', 'Delhi', 'Standard'),
('C04', 'Priya Rai', 'Delhi', 'Delhi', 'Premium'),
('C05', 'Rajesh V', 'Bangalore', 'Karnataka', 'Corporate'),
('C06', 'Anjali S', 'Bangalore', 'Karnataka', 'Standard'),
('C07', 'Vikram M', 'Chennai', 'Tamil Nadu', 'Premium'),
('C08', 'Neha P', 'Chennai', 'Tamil Nadu', 'Standard'),
('C09', 'Suresh K', 'Mumbai', 'Maharashtra', 'Corporate'),
('C10', 'Meena R', 'Delhi', 'Delhi', 'Standard'),
('C11', 'Arjun T', 'Bangalore', 'Karnataka', 'Premium'),
('C12', 'Pooja B', 'Chennai', 'Tamil Nadu', 'Corporate');

-- 4. Insert 40 Sales Transactions
-- (Note: Ensure date_key, product_key, and customer_key exist above)
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101, 1, 1, 1, 85000.00, 5000.00, 80000.00),
(20240101, 4, 2, 2, 4500.00, 200.00, 8800.00),
(20240102, 10, 3, 1, 3500.00, 0, 3500.00),
(20240106, 2, 4, 1, 45000.00, 1000.00, 44000.00), -- Weekend
(20240107, 12, 5, 1, 45000.00, 5000.00, 40000.00), -- Weekend
(20240107, 15, 6, 3, 2500.00, 0, 7500.00), -- Weekend
-- (Add 34 more rows here with varied dates/products to reach 40 total)
(20240108, 3, 7, 1, 12000.00, 500.00, 11500.00),
(20240108, 7, 8, 2, 7500.00, 1000.00, 14000.00),
(20240110, 1, 9, 1, 85000.00, 0, 85000.00),
(20240112, 13, 10, 1, 22000.00, 2000.00, 20000.00),
(20240113, 5, 11, 1, 35000.00, 3000.00, 32000.00), -- Weekend
(20240114, 8, 12, 1, 25000.00, 1000.00, 24000.00), -- Weekend
(20240115, 4, 1, 1, 4500.00, 0, 4500.00),
(20240115, 6, 2, 1, 8000.00, 500.00, 7500.00),
(20240117, 9, 3, 4, 5000.00, 1000.00, 19000.00),
(20240118, 11, 4, 1, 12000.00, 1000.00, 11000.00),
(20240120, 1, 5, 1, 85000.00, 5000.00, 80000.00), -- Weekend
(20240120, 2, 6, 1, 45000.00, 2000.00, 43000.00), -- Weekend
(20240121, 10, 7, 2, 3500.00, 0, 7000.00), -- Weekend
(20240121, 14, 8, 1, 9500.00, 500.00, 9000.00), -- Weekend
(20240122, 13, 9, 1, 22000.00, 0, 22000.00),
(20240122, 3, 10, 1, 12000.00, 1000.00, 11000.00),
(20240123, 15, 11, 2, 2500.00, 0, 5000.00),
(20240124, 7, 12, 1, 7500.00, 500.00, 7000.00),
(20240125, 4, 1, 1, 4500.00, 100.00, 4400.00),
(20240126, 6, 2, 1, 8000.00, 0, 8000.00),
(20240127, 2, 3, 1, 45000.00, 3000.00, 42000.00), -- Weekend
(20240127, 5, 4, 1, 35000.00, 0, 35000.00), -- Weekend
(20240128, 12, 5, 1, 45000.00, 4000.00, 41000.00), -- Weekend
(20240128, 1, 6, 1, 85000.00, 5000.00, 80000.00), -- Weekend
(20240129, 8, 7, 1, 25000.00, 2000.00, 23000.00),
(20240129, 9, 8, 1, 5000.00, 0, 5000.00),
(20240130, 11, 9, 1, 12000.00, 500.00, 11500.00),
(20240130, 14, 10, 1, 9500.00, 1000.00, 8500.00),
(20240101, 10, 11, 1, 3500.00, 0, 3500.00),
(20240105, 3, 12, 2, 12000.00, 2000.00, 22000.00),
(20240113, 15, 1, 4, 2500.00, 1000.00, 9000.00), -- Weekend
(20240120, 7, 2, 2, 7500.00, 0, 15000.00), -- Weekend
(20240127, 4, 3, 1, 4500.00, 500.00, 4000.00), -- Weekend
(20240128, 6, 4, 1, 8000.00, 1000.00, 7000.00); -- Weekend