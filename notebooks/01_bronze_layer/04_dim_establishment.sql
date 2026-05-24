-- Bronze Layer - Establishment Dimension Load
-- This notebook loads raw establishment data into the Bronze Delta table.

-- IMPORTANT:
-- This portfolio version uses generic table names, column names and file paths.
-- No private workspace paths, credentials or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE bronze_dim_establishment
USING DELTA
AS
SELECT
    ID_ESTABLECIMIENTO AS establishment_id,
    ESTABLECIMIENTO AS establishment_name,
    current_timestamp() AS ingestion_time,
    'sample_dim_establishment.csv' AS source_file
FROM read_files(
    '/Volumes/portfolio_catalog/finance/raw_files/sample_dim_establishment.csv',
    format => 'csv',
    header => true,
    sep => ';'
);
