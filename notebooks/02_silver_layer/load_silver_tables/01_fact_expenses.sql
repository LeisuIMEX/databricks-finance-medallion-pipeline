-- Silver Layer - Fact Expenses Cleaning
-- This notebook cleans, standardizes and prepares the expense fact table for analytical modeling.

-- IMPORTANT:
-- This portfolio version uses generic table names and column names.
-- No private credentials, internal hostnames or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

CREATE OR REPLACE TABLE silver_fact_expenses
USING DELTA
AS
SELECT
    CAST(expense_id AS INT) AS expense_id,

    TRIM(description) AS description,

    CAST(establishment_id AS INT) AS establishment_id,
    CAST(category_id AS INT) AS category_id,

    TRY_CAST(
        NULLIF(
            REPLACE(
                UPPER(TRIM(income_amount)),
                ',',
                '.'
            ),
            ''
        ) AS DECIMAL(18,2)
    ) AS income_amount,

    TRY_CAST(
        NULLIF(
            REPLACE(
                UPPER(TRIM(expense_amount)),
                ',',
                '.'
            ),
            ''
        ) AS DECIMAL(18,2)
    ) AS expense_amount,

    CAST(transaction_date AS DATE) AS transaction_date,

    ingestion_time,
    source_file
FROM bronze_fact_expenses
WHERE expense_id IS NOT NULL;
