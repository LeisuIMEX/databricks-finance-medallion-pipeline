-- Bronze Layer - Fact Expenses Incremental Load
-- This notebook incrementally loads raw expense records into the Bronze Delta table.

-- IMPORTANT:
-- This portfolio version uses generic table names, column names and file paths.
-- No private workspace paths, credentials or sensitive business data are included.

USE CATALOG portfolio_catalog;
USE SCHEMA finance;

MERGE INTO bronze_fact_expenses AS target
USING (
    SELECT
        ID_INFORME AS expense_id,
        DESCRIPCION AS description,
        ID_ESTABLECIMIENTO AS establishment_id,
        ID_CATEGORIA AS category_id,
        INGRESOS AS income_amount,
        GASTOS AS expense_amount,
        FECHA AS transaction_date,
        current_timestamp() AS ingestion_time,
        'sample_finance_data.csv' AS source_file
    FROM read_files(
        '/Volumes/portfolio_catalog/finance/raw_files/sample_finance_data.csv',
        format => 'csv',
        header => true,
        sep => ';'
    )
) AS source
ON target.expense_id = source.expense_id

WHEN NOT MATCHED THEN
INSERT (
    expense_id,
    description,
    establishment_id,
    category_id,
    income_amount,
    expense_amount,
    transaction_date,
    ingestion_time,
    source_file
)
VALUES (
    source.expense_id,
    source.description,
    source.establishment_id,
    source.category_id,
    source.income_amount,
    source.expense_amount,
    source.transaction_date,
    source.ingestion_time,
    source.source_file
);
