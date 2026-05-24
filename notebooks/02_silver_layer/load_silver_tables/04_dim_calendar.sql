-- Silver Layer - Calendar Dimension Cleaning
-- This notebook cleans and standardizes the calendar dimension table.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE silver_dim_calendar
USING DELTA
AS
SELECT
    CAST(calendar_date AS DATE) AS date,
    CAST(year AS INT) AS year,
    CAST(month_number AS INT) AS month_number,
    CAST(period AS INT) AS period,
    TRIM(month_year) AS month_year,
    CAST(day_number AS INT) AS day_number,
    TRIM(quarter_name) AS quarter_name,
    CAST(week_number AS INT) AS week_number,
    TRIM(week_name) AS week_name,
    TRIM(short_month_name) AS short_month_name,
    TRIM(month_name) AS month_name,

    ingestion_time,
    source_file
FROM bronze_dim_calendar
WHERE calendar_date IS NOT NULL;
