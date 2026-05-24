-- Bronze Layer - Fact Expenses Table Creation
-- This notebook creates the Bronze Delta table for raw expense data.

-- IMPORTANT:
-- This portfolio version uses generic table and column names.
-- No private credentials, internal hostnames or sensitive business data are included. 

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE TABLE IF NOT EXISTS bronze_fact_expenses (
    expense_id STRING,
    description STRING,
    establishment_id STRING,
    category_id STRING,
    income_amount STRING,
    expense_amount STRING,
    transaction_date STRING,
    ingestion_time TIMESTAMP,
    source_file STRING
)
USING DELTA;
