-- Gold Layer - Establishment Dimension
-- This notebook creates the final establishment dimension table consumed by Power BI.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE gold_dim_establishment
USING DELTA
AS
SELECT
    establishment_id,
    establishment_name
FROM silver_dim_establishment;
