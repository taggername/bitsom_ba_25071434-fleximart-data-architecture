# FlexiMart Data Architecture Project

**Student Name:** HARSHITA
**Student ID:** bitsom_ba_25071434
**Email:** vp986273@gmail.com
**Date:** January 8, 2026

## Project Overview
FlexiMart is an integrated data engineering solution designed to manage a high-volume retail ecosystem. I built a multi-layered architecture that includes a relational MySQL database for transactional integrity, a MongoDB document store for a flexible product catalog, and a Star Schema data warehouse optimized for analytical processing and business intelligence.



## Repository Structure
```text
├── part1-database-etl/
│   ├── etl_pipeline.py           # Python script for data cleaning and SQL loading
│   ├── schema_documentation.md   # ERD and relational table definitions
│   ├── business_queries.sql      # Operational SQL queries for daily metrics
│   └── data_quality_report.txt   # Results of data validation and cleaning
├── part2-nosql/
│   ├── nosql_analysis.md         # Comparison of SQL vs NoSQL for retail
│   ├── mongodb_operations.js     # CRUD and aggregation scripts for MongoDB
│   └── products_catalog.json     # Sample semi-structured product data
├── part3-datawarehouse/
│   ├── star_schema_design.md     # Dimensional modeling rationale
│   ├── warehouse_schema.sql      # DDL for Fact and Dimension tables
│   ├── warehouse_data.sql        # Sample data for analytical testing
│   └── analytics_queries.sql     # OLAP queries for trend analysis
└── README.md
