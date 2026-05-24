## Notebook Structure

The Databricks workspace is organized by Medallion layers:

### 01 Bronze Layer

This layer loads the raw finance data and prepares the base Delta tables.

Notebooks included:

- Configuration
- Fact Finance initial load
- Fact Finance incremental load
- Category dimension
- Establishment dimension
- Calendar dimension

### 02 Silver Layer

This layer cleans, standardizes and validates the data before analytical modeling.

Notebooks included:

- Fact Finance cleaning
- Category dimension cleaning
- Establishment dimension cleaning
- Calendar dimension cleaning
- Row count validation
- Table validation checks

### 03 Gold Layer

This layer creates the final analytical model consumed by Power BI.

Notebooks included:

- Fact Finance
- Dim Category
- Dim Establishment
- Dim Calendar
