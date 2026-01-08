FACT TABLE: fact_sales
Grain: One row per product per order line item
Business Process: Sales transactions

Measures (Numeric Facts):
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied
- total_amount: Final amount (quantity × unit_price - discount)

Foreign Keys:
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

DIMENSION TABLE: dim_date
Purpose: Date dimension for time-based analysis
Type: Conformed dimension
Attributes:
- date_key (PK): Surrogate key (integer, format: YYYYMMDD)
- full_date: Actual date
- day_of_week: Monday, Tuesday, etc.
- month: 1-12
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: 2023, 2024, etc.
- is_weekend: Boolean

DIMENSION TABLE: dim_product
Purpose: Stores descriptive details about every item sold in the store.
Type: Dimension
Attributes:
product_key (PK): Surrogate key (unique integer for the warehouse).
product_id: The original SKU or barcode from the store system (Natural Key).
product_name: The name of the item (e.g., "Wireless Mouse").
category: The group the product belongs to (e.g., "Electronics", "Stationery").
sub_category: Specific group (e.g., "Computer Accessories").
brand: The manufacturer or brand name.
unit_cost: The cost price paid to the supplier.

DIMENSION TABLE: dim_customer
Purpose: Stores demographic information about the people making purchases.
Type: Dimension
Attributes:
customer_key (PK): Surrogate key (unique integer).
customer_id: The ID from the store's CRM or loyalty program.
customer_name: Full name of the customer.
email: Customer's contact email.
city: The city where the customer lives.
state_province: The state or province.
country: The country of residence.
segment: Category of customer (e.g., "Home Office", "Corporate").


