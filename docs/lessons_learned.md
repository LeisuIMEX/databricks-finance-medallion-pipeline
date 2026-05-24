# Lessons Learned

## Project Purpose

The main objective of this project was not only to build a Medallion Architecture, but also to design a reliable and automated data flow from Databricks to Power BI.

The goal was to make sure that the report published in Power BI Service always consumes the latest available data from the Databricks Gold Layer.

## What This Project Solves

In many BI projects, the report is created in Power BI Desktop and then published to Power BI Service, but the refresh process is not always properly connected to the upstream data pipeline.

This project focuses on solving that problem by connecting the final Gold Layer in Databricks to Power BI and coordinating the refresh process.

The intended flow is:

Raw data  
↓  
Databricks Bronze Layer  
↓  
Databricks Silver Layer  
↓  
Data validation  
↓  
Databricks Gold Layer  
↓  
Power BI Desktop  
↓  
Power BI Service semantic model refresh  

## Key Learning 1: The Gold Layer Must Be the Reporting Source

One of the most important decisions was to connect Power BI to the Gold Layer instead of the raw or intermediate layers.

The Gold Layer contains the final analytical model prepared for reporting.

This makes Power BI easier to maintain because the semantic model consumes clean, structured and business-ready tables.

## Key Learning 2: Power BI Desktop Is Not the Final Refresh Engine

Power BI Desktop is useful for building the report, creating the model and validating the connection.

However, once the report is published, the scheduled refresh should happen in Power BI Service.

This means the local Power BI Desktop file does not need to be open for the refresh to work.

The semantic model in Power BI Service connects to Databricks and retrieves the latest data from the Gold Layer.

## Key Learning 3: Refresh Order Matters

The refresh order is critical.

Power BI should refresh after the Databricks pipeline has completed.

If Power BI refreshes before the Gold Layer is updated, the report may show old data or incomplete results.

For this reason, the refresh strategy was designed as follows:

- Databricks Job runs first
- Bronze, Silver and Gold tables are updated
- Validation checks are executed
- Power BI Service refresh runs after the Databricks Job

Example schedule:

- Databricks Job: 15:30
- Power BI Service Refresh: 16:00

This gives the Databricks pipeline time to finish before Power BI starts consuming the updated data.

## Key Learning 4: Automation Requires More Than Scheduling

Scheduling a job is not enough.

A reliable automated flow also needs:

- Clear layer separation
- Stable table names
- Validation checks
- Consistent data types
- Controlled refresh timing
- Monitoring of refresh history
- Secure credential management

The objective is not only to refresh data, but to refresh the correct data at the correct time.

## Key Learning 5: Validation Protects the Reporting Layer

The Silver Layer includes validation checks before the data moves forward to the Gold Layer.

These checks help identify problems such as empty tables or unexpected row counts.

This is important because Power BI should not consume incomplete or invalid data.

Validation adds a control point between data transformation and business reporting.

## Key Learning 6: Naming Consistency Is Important

During the portfolio version of this project, table names were standardized to make the repository easier to understand.

For example:

- `fact_informe` was adapted to `fact_expenses`
- Gold tables were named according to their analytical purpose
- Technical and business names were separated more clearly

This improves readability for external users reviewing the project.

## Key Learning 7: Security Must Be Considered in Public Repositories

A public GitHub repository should never expose private technical details.

For this reason, this project does not include:

- Databricks tokens
- Workspace URLs
- Server hostnames
- HTTP paths
- Internal environment names
- Private business data

All sensitive values were replaced with generic placeholders.

## Final Takeaway

The biggest learning from this project is that a BI solution is not complete when the dashboard is created.

A complete BI solution also needs a reliable data pipeline, a clean analytical layer, validation checks and a refresh strategy that ensures the report always shows the latest available data.

In this project, Databricks prepares the data and Power BI Service consumes it after the Gold Layer is ready.
