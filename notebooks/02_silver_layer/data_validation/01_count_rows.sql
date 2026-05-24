-- Silver Layer - Row Count Validation
-- This validation query counts the number of rows in each Silver table.

-- IMPORTANT:
-- This portfolio version uses generic table names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

SELECT
    'silver_fact_expenses' AS table_name,
    COUNT(*) AS total_rows
FROM silver_fact_expenses

UNION ALL

SELECT
    'silver_dim_category' AS table_name,
    COUNT(*) AS total_rows
FROM silver_dim_category

UNION ALL

SELECT
    'silver_dim_establishment' AS table_name,
    COUNT(*) AS total_rows
FROM silver_dim_establishment

UNION ALL

SELECT
    'silver_dim_calendar' AS table_name,
    COUNT(*) AS total_rows
FROM silver_dim_calendar;
