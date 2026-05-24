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
    FECHA AS calendar_date,
    `Año` AS year,
    Mes AS month_number,
    Periodo AS period,
    Mes_Año AS month_year,
    NrDia AS day_number,
    Trimestre AS quarter_name,
    DiaSemana AS week_number,
    NombreDia AS week_name,
    Mes_Corto AS short_month_name,
    MesNombreFull AS month_name,
    current_timestamp() AS ingestion_time,
    'sample_dim_calendar.csv' AS source_file
FROM read_files(
    '/Volumes/portfolio_catalog/finance/raw_files/sample_dim_calendar.csv',
    format => 'csv',
    header => true,
    sep => ';'
);
