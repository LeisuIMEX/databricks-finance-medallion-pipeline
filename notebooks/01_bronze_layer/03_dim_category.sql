-- Bronze Layer - Category Dimension Load
-- This notebook loads raw category data into the Bronze Delta table.

-- IMPORTANT:
-- This portfolio version uses generic table names, column names and file paths.
-- No private workspace paths, credentials or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE bronze_dim_category
USING DELTA
AS
SELECT
    ID_CATEGORIA AS category_id,
    CATEGORIA AS category_name,
    BUDGET_2026 AS budget_2026,
    current_timestamp() AS ingestion_time,
    'sample_dim_category.csv' AS source_file
FROM read_files(
    '/Volumes/portfolio_catalog/finance/raw_files/sample_dim_category.csv',
    format => 'csv',
    header => true,
    sep => ';'
);
