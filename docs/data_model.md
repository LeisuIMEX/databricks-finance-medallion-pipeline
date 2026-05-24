# Data Model

## Overview

The Gold layer is designed to be consumed by Power BI as a simple analytical star schema.

The model contains one fact table and three dimension tables.

## Fact Table

### `gold_fact_finance`

This table contains the financial transactions used for reporting and analysis.

Main fields:

- `expense_id`
- `description`
- `establishment_id`
- `category_id`
- `income_amount`
- `expense_amount`
- `transaction_date`

This table is used to calculate financial KPIs such as total expenses, total income, category performance and budget comparison.

## Dimension Tables

### `gold_dim_category`

This table contains the category information used to group and analyze expenses.

Main fields:

- `category_id`
- `category_name`
- `budget_2026`

The `budget_2026` field allows budget 2026 vs actual analysis in Power BI.

### `gold_dim_establishment`

This table contains establishment information.

Main fields:

- `establishment_id`
- `establishment_name`

It allows reporting by establishment where the expenses have been made.

### `gold_dim_calendar`

This table contains calendar attributes used for time intelligence analysis.

Main fields:

- `date`
- `year`
- `month_number`
- `period`
- `month_year`
- `day_number`
- `quarter_name`
- `week_number`
- `week_name`
- `short_month_name`
- `month_name`

This table supports time-based reporting such as monthly trends, YTD analysis and year-over-year comparisons.

## Relationships

The Power BI semantic model is designed with the following relationships:

- `gold_fact_finance[category_id]` → `gold_dim_category[category_id]`
- `gold_fact_finance[establishment_id]` → `gold_dim_establishment[establishment_id]`
- `gold_fact_finance[transaction_date]` → `gold_dim_calendar[date]`

## Model Design

The Gold layer follows a star schema approach:

- The fact table stores measurable business events.
- Dimension tables provide descriptive context.
- The model is optimized for Power BI reporting and DAX calculations.

## Analytical Use Cases

This data model supports:

- Expense analysis by category
- Expense analysis by establishment
- Budget vs actual tracking
- YTD performance analysis
- Monthly trend analysis
- Power BI dashboard reporting
