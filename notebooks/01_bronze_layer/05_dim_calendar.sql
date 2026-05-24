-- Bronze Layer - Calendar Dimension Load
-- This notebook loads raw calendar data into the Bronze Delta table.

-- IMPORTANT:
-- This portfolio version uses generic table names, column names and file paths.
-- No private workspace paths, credentials or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE bronze_dim_calendar
USING DELTA
AS
SELECT
    ID_FECHA AS date_id,
    FECHA AS calendar_date,
    ANIO AS year,
    MES AS month,
    NOMBRE_MES AS month_name,
    TRIMESTRE AS quarter,
    current_timestamp() AS ingestion_time,
    'sample_dim_calendar.csv' AS source_file
FROM read_files(
    '/Volumes/portfolio_catalog/finance/raw_files/sample_dim_calendar.csv',
    format => 'csv',
    header => true,
    sep => ';'
);
