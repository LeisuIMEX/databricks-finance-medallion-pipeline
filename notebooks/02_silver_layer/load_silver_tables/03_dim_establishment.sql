-- Silver Layer - Establishment Dimension Cleaning
-- This notebook cleans and standardizes the establishment dimension table.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE silver_dim_establishment
USING DELTA
AS
SELECT
    CAST(establishment_id AS INT) AS establishment_id,
    TRIM(establishment_name) AS establishment_name,

    ingestion_time,
    source_file
FROM bronze_dim_establishment
WHERE establishment_id IS NOT NULL;
