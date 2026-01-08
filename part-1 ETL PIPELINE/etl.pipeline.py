import csv
import re
from datetime import datetime

# --- STEP 1: EXTRACT ---

# 1. Read Customers
customers = []
try:
    with open('customers_raw.csv', mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            customers.append(row)
    print("Successfully read customers_raw.csv")
except FileNotFoundError:
    print("Error: customers_raw.csv not found. Make sure the file is in the same folder as your script.")

products = []
try:
    with open('products_raw.csv', mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
           products.append(row)
    print("Successfully read products.csv")
except FileNotFoundError:
    print("Error: products_raw.csv not found. Make sure the file is in the same folder as your script.")

sales = []
try:
    with open('sales_raw.csv', mode='r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
           sales.append(row)
    print("Successfully read sales.csv")
except FileNotFoundError:
    print("Error: sales_raw.csv not found. Make sure the file is in the same folder as your script.")

# --- STEP 2: TRANSFORM ---

# 1. REMOVE DUPLICATES

unique_customers = []
seen_customers = []

for row in customers:
    if row not in seen_customers:
        unique_customers.append(row)
        seen_customers.append(row)
customers = unique_customers

# 2. MISSING VALUES & CATEGORIES
# We fix empty spots or messy words
for row in products:
    # Fix Category: "electronics" -> "Electronics"
    if 'category' in row and row['category'] != "":
        row['category'] = row['category'].strip().capitalize()
    else:
        row['category'] = "General" # Fill missing with a default

# 3. STANDARDIZE PHONE FORMATS
# example - +91-9876543210
for row in customers:
    raw_phone = str(row.get('phone', ''))
    # Keep only the numbers
    only_numbers = re.sub(r'\D', '', raw_phone)
    
    if len(only_numbers) >= 10:
        # Take the last 10 digits and add the prefix
        row['phone'] = "+91-" + only_numbers[-10:]
    else:
        row['phone'] = "+91-0000000000" # Default for broken numbers

# 4. CONVERT DATE FORMATS -(YYYY-MM-DD)
for row in sales:
    raw_date = row.get('sale_date', '2026-01-01')
    try:
        # This part tries to fix common date styles
        if "/" in raw_date: # If it's 01/08/2026
            parts = raw_date.split("/")
            # Assuming format is MM/DD/YYYY
            row['sale_date'] = f"{parts[2]}-{parts[0]}-{parts[1]}"
        elif "-" in raw_date and len(raw_date) > 10: # If it has extra time info
            row['sale_date'] = raw_date[:10]
    except:
        row['sale_date'] = "2026-01-01" # Backup date if it fails

# 5.SURROGATE KEYS (Auto-incrementing IDs)
# We give every row a simple number: 1, 2, 3...
id_number = 1
for row in customers:
    row['cust_id'] = id_number
    id_number = id_number + 1

id_number = 1
for row in products:
    row['prod_id'] = id_number
    id_number = id_number + 1

id_number = 1
for row in sales:
    row['sale_id'] = id_number
    id_number = id_number + 1

print("Transformation is finished! Everything is clean and numbered.")



# --- STEP 3: LOAD (MySQL Version) ---

# --- UPDATED LOAD SECTION ---
from sqlalchemy import create_engine, text
import pandas as pd
import urllib.parse

# 1. Setup
user = 'root'
password = 'H@Rshi8a'
host = 'localhost'
safe_pass = urllib.parse.quote_plus(password)

# 2. First, connect to MySQL without a database name to create it
base_url = f'mysql+pymysql://{user}:{safe_pass}@{host}:3306'
temp_engine = create_engine(base_url)

with temp_engine.connect() as conn:
    # This line creates the database if it doesn't exist
    conn.execute(text("CREATE DATABASE IF NOT EXISTS fleximart"))
    print("Database 'fleximart' is ready!")

# 3. Now connect to the actual 'etl_test' database to load data
db_url = f'mysql+pymysql://{user}:{safe_pass}@{host}:3306/fleximart'
engine = create_engine(db_url)

print("Loading tables...")
pd.DataFrame(customers).to_sql('customers', engine, if_exists='replace', index=False)
pd.DataFrame(products).to_sql('products', engine, if_exists='replace', index=False)
pd.DataFrame(sales).to_sql('sales', engine, if_exists='replace', index=False)

print("--- SUCCESS! ALL DATA LOADED ---")
       

import pandas as pd
from sqlalchemy import create_engine, text, Integer, Text
import urllib.parse
import os

# --- 1. SETUP & CREDENTIALS ---
user = 'root'
password = 'H@Rshi8a'
host = 'localhost'
db_name = 'fleximart'
safe_pass = urllib.parse.quote_plus(password)

# --- 2. EXTRACT (Reading the files) ---
print("Reading files...")
df_cust = pd.read_csv('customers_raw.csv')
df_prod = pd.read_csv('products_raw.csv')
df_sales = pd.read_csv('sales_raw.csv')

# REPORTING: Count how many rows we started with
raw_count = len(df_cust) + len(df_prod) + len(df_sales)

# --- 3. TRANSFORM (Cleaning the data) ---
print("Cleaning data...")

# Count missing values before fixing them
missing_count = df_cust.isnull().sum().sum() + df_sales.isnull().sum().sum()
df_cust = df_cust.fillna('Unknown')
df_sales = df_sales.fillna(0)

# Count duplicates before removing them
before_dedup = len(df_cust)
df_cust = df_cust.drop_duplicates()
dup_count = before_dedup - len(df_cust)

# --- 4. LOAD (Uploading to MySQL) ---
db_url = f'mysql+pymysql://{user}:{safe_pass}@{host}:3306/{db_name}'
engine = create_engine(db_url)

load_count = 0
try:
    with engine.begin() as conn:
        conn.execute(text("SET FOREIGN_KEY_CHECKS = 0;"))
        
        # Load tables
        df_cust.to_sql('customers', conn, if_exists='replace', index=False, 
                       dtype={'customer_id': Text(), 'cust_id': Integer()})
        df_prod.to_sql('products', conn, if_exists='replace', index=False,
                       dtype={'product_id': Text(), 'prod_id': Integer()})
        df_sales.to_sql('sales', conn, if_exists='replace', index=False)
        
        conn.execute(text("SET FOREIGN_KEY_CHECKS = 1;"))
        
    # If successful, count the final records
    load_count = len(df_cust) + len(df_prod) + len(df_sales)
    print("--- SUCCESS! DATA LOADED ---")

except Exception as e:
    print(f"Error during load: {e}")

# --- 5. GENERATE THE REPORT FILE ---
# This part creates the .txt file in your folder
with open("data_quality_report.txt", "w") as f:
    f.write("==========================================\n")
    f.write("      FLEXIMART DATA QUALITY REPORT       \n")
    f.write("==========================================\n\n")
    f.write(f"1. Total Records Processed: {raw_count}\n")
    f.write(f"2. Duplicates Removed:      {dup_count}\n")
    f.write(f"3. Missing Values Handled:  {missing_count}\n")
    f.write(f"4. Records Loaded to MySQL: {load_count}\n\n")
    f.write("Status: COMPLETED SUCCESSFULLY\n")

print("Report has been generated: data_quality_report.txt")
