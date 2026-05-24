-- Silver Layer - Category Dimension Cleaning
-- This notebook cleans and standardizes the category dimension table.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE silver_dim_category
USING DELTA
AS
SELECT
    CAST(category_id AS INT) AS category_id,

    TRIM(category_name) AS category_name,

    TRY_CAST(
        NULLIF(
            REPLACE(
                UPPER(TRIM(budget_2026)),
                ',',
                '.'
            ),
            ''
        ) AS DECIMAL(18,2)
    ) AS budget_2026,

    ingestion_time,
    source_file
FROM bronze_dim_category
WHERE category_id IS NOT NULL;
