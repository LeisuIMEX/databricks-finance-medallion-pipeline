-- Gold Layer - Fact Finance
-- This notebook creates the final finance fact table consumed by Power BI.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE gold_fact_finance
USING DELTA
AS
SELECT
    expense_id,
    description,
    establishment_id,
    category_id,
    income_amount,
    expense_amount,
    transaction_date
FROM silver_fact_expenses;
