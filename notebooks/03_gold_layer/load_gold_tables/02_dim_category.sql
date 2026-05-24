-- Gold Layer - Category Dimension
-- This notebook creates the final category dimension table consumed by Power BI.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE gold_dim_category
USING DELTA
AS
SELECT
    category_id,
    category_name,
    budget_2026
FROM silver_dim_category;
