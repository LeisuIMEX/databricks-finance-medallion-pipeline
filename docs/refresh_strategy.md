# Refresh Strategy

## Overview

This document explains the refresh strategy used in this project to keep the Power BI semantic model updated after the Databricks pipeline execution.

The goal is to ensure that Power BI always consumes the latest available Gold layer data.

## Refresh Flow

The refresh process follows this sequence:

Raw files  
↓  
Databricks Job execution  
↓  
Bronze tables update  
↓  
Silver tables update  
↓  
Data validation checks  
↓  
Gold tables update  
↓  
Power BI Service semantic model refresh  

## Databricks Job

The Databricks pipeline is executed through a scheduled Databricks Job.

The job runs the notebooks in the correct order:

1. Bronze layer notebooks
2. Silver layer notebooks
3. Silver data validation notebooks
4. Gold layer notebooks

This ensures that the final Gold tables are only refreshed after the raw and cleaned layers have been processed.

## Power BI Service Refresh

Power BI connects to the Gold layer through Databricks SQL Warehouse.

The Power BI semantic model is scheduled to refresh after the Databricks Job has completed.

Example schedule:

- Databricks Job: 15:30
- Power BI Service Refresh: 16:00

This sequencing gives the Databricks pipeline enough time to finish before Power BI starts consuming the updated tables.

## Why This Refresh Order Matters

Power BI should not refresh before the Databricks pipeline finishes.

If Power BI refreshes too early, it may consume:

- Old Gold tables
- Partially refreshed data
- Incomplete transformations
- Failed or empty tables

By scheduling Power BI after the Databricks Job, the reporting layer is more reliable.

## Validation Before Reporting

Before the Gold layer is consumed by Power BI, the Silver layer includes validation checks.

Current validation checks include:

- Row count checks for each Silver table
- Empty table detection
- Error raising if one or more required tables are empty

These checks help prevent incomplete data from moving forward into the reporting layer.

## Power BI Connection

Power BI Desktop connects to Databricks using Databricks SQL Warehouse.

Once the report is published, Power BI Service uses the configured connection to refresh the semantic model directly from Databricks.

The local Power BI Desktop file is not required for the scheduled refresh to run.

## Security Notes

This public repository does not include:

- Databricks tokens
- Workspace URLs
- Server hostnames
- HTTP paths
- Internal environment names
- Private business data

All connection-related details are intentionally replaced with generic descriptions.

## Operational Considerations

In a real production environment, the refresh process should consider:

- Average Databricks Job runtime
- Power BI refresh duration
- Failure notifications
- Data validation results
- Retry strategy
- Access and credential management
- Monitoring of both Databricks and Power BI refresh history

## Summary

The refresh strategy follows a simple principle:

Databricks prepares the data first.  
Power BI consumes the data after the Gold layer is ready.

This approach helps ensure that the reporting layer remains consistent, reliable and aligned with the latest processed data.
