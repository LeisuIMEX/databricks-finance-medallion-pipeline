-- Gold Layer - Calendar Dimension
-- This notebook creates the final calendar dimension table consumed by Power BI.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE gold_dim_calendar
USING DELTA
AS
SELECT
    date,
    year,
    month_number,
    period,
    month_year,
    day_number,
    quarter_name,
    week_number,
    week_name,
    short_month_name,
    month_name
FROM silver_dim_calendar;
