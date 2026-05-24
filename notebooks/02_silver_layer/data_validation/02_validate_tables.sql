-- Silver Layer - Table Validation
-- This validation query raises an error if one or more Silver tables are empty.

-- IMPORTANT:
-- This portfolio version uses generic table names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

SELECT
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM (
                SELECT COUNT(*) AS total_rows FROM silver_fact_expenses
                UNION ALL
                SELECT COUNT(*) AS total_rows FROM silver_dim_category
                UNION ALL
                SELECT COUNT(*) AS total_rows FROM silver_dim_establishment
                UNION ALL
                SELECT COUNT(*) AS total_rows FROM silver_dim_calendar
            ) validation_counts
            WHERE total_rows = 0
        )
        THEN raise_error('Silver validation failed: one or more tables are empty')
        ELSE 'Silver validation passed: all tables contain data'
    END AS validation_result;
