# Pipeline Architecture

## Overview

This project follows a Medallion Architecture approach using Databricks and Delta Lake.

The pipeline transforms raw finance data into clean analytical tables that can be consumed by Power BI.

## Architecture Flow

Raw CSV files  
↓  
Bronze Delta tables  
↓  
Silver cleaned tables  
↓  
Gold analytical model  
↓  
Databricks SQL Warehouse  
↓  
Power BI Desktop  
↓  
Power BI Service scheduled refresh  

## Bronze Layer

The Bronze layer stores raw data loaded from CSV files.

Its main purpose is to preserve the original structure of the source data while adding technical metadata such as ingestion time and source file.

Bronze tables:

- `bronze_fact_expenses`
- `bronze_dim_category`
- `bronze_dim_establishment`
- `bronze_dim_calendar`

## Silver Layer

The Silver layer cleans and standardizes the data.

Main transformations include:

- Data type casting
- Text trimming
- Decimal normalization
- Date conversion
- Null filtering
- Row count validation
- Empty table validation

Silver tables:

- `silver_fact_expenses`
- `silver_dim_category`
- `silver_dim_establishment`
- `silver_dim_calendar`

## Gold Layer

The Gold layer contains the final analytical model used by Power BI.

Gold tables:

- `gold_fact_finance`
- `gold_dim_category`
- `gold_dim_establishment`
- `gold_dim_calendar`

## Power BI Consumption

Power BI connects to the Gold layer through Databricks SQL Warehouse.

The Gold layer is structured as an analytical model, where `gold_fact_finance` acts as the fact table and the other Gold tables act as dimensions.

## Refresh Strategy

The Databricks pipeline is executed first through a scheduled job.

After the Databricks job finishes, Power BI Service refreshes the semantic model to consume the latest Gold layer data.

Example schedule:

- Databricks Job: 15:30
- Power BI Service Refresh: 16:00

This sequencing helps ensure that Power BI refreshes after the data pipeline has completed.
