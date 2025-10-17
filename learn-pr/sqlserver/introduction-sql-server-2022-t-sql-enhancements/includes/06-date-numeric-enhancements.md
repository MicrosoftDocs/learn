# Date and Numeric Enhancements in SQL Server 2025

SQL Server 2025 introduces several improvements to date and numeric functions that simplify time-based logic and aggregate calculations.  
These updates simplify everyday development, help avoid conversion issues, and make working with dates and numeric values more practical in analytics and reporting scenarios.

## Overview of Date and Numeric Enhancements

### CURRENT_DATE  
A new scalar function that returns the current date without a time component.  
It serves as a simpler alternative to `CAST(GETDATE() AS DATE)` and aligns with the ISO SQL standard.

### DATEADD with bigint support  
The `DATEADD` function now supports the `bigint` data type for its interval parameter, allowing developers to add large numbers of units to a date without overflow or conversion issues.  
This enhancement is especially useful for time series calculations or simulations involving long durations.

### PRODUCT() aggregate function  
The new `PRODUCT()` aggregate function multiplies all non-NULL numeric values in a group.  
It complements `SUM()` and `AVG()` by allowing multiplicative aggregation, for example, computing compounded growth rates, scaling factors, or multi-stage probabilities.

### External REST invocation with `sp_invoke_external_rest_endpoint`

SQL Server 2025 adds the system procedure `sp_invoke_external_rest_endpoint`, allowing T-SQL to call external REST APIs directly. This enables integration with external data sources or services without leaving the database engine.

## Example 1: Using CURRENT_DATE for Simpler Date Logic

Before SQL Server 2025, retrieving today’s date required an expression like `CAST(GETDATE() AS DATE)`. Now, you can get it directly with `CURRENT_DATE`.

### Query: Retrieve the Current Date

```sql
SELECT CURRENT_DATE AS TodayDate;
```

### Result

| TodayDate |
|------------|
| 2025-10-14 |

This command eliminates unnecessary type conversions and improves readability in queries and stored procedures.


## Example 2: Adding Large Time Intervals with DATEADD(bigint)

In prior versions, `DATEADD` accepted only `int` values for its interval parameter, which limited date calculations for large datasets.  
SQL Server 2025 now supports `bigint`, enabling large-scale date manipulations.

### Query: Simulate Future Dates Over Long Periods

```sql
DECLARE @StartDate DATE = '2025-01-01';

SELECT
    DATEADD(DAY, CAST(365000 AS bigint), @StartDate) AS TenCenturyFuture,
    DATEADD(MINUTE, CAST(10000000 AS bigint), @StartDate) AS MinutesAhead;
```

### Results

| TenCenturyFuture | MinutesAhead |
|------------------|---------------|
| 3025-10-10 | 2044-02-12 10:40:00 |

This function allows precise control for long-term forecasts, time simulations, or scheduling calculations that exceed previous integer limits.

## Example 3: Calculating Compound Growth with PRODUCT()

The `PRODUCT()` aggregate function simplifies calculating cumulative multipliers.  
For example, in finance or analytics, it can represent compounded growth rates or total scaling factors.

### Query: Compute Compounded Monthly Growth

```sql
CREATE TABLE #GrowthRates (Month INT, Rate DECIMAL(6,4));
INSERT INTO #GrowthRates VALUES
(1, 1.0100),
(2, 1.0200),
(3, 0.9950),
(4, 1.0150);

SELECT PRODUCT(Rate) AS CompoundGrowth
FROM #GrowthRates;
```

### Result

| CompoundGrowth |
|----------------|
| 1.0404 |

In this example, `PRODUCT()` multiplies all rate values to produce a single compounded result.  
It can be combined with `GROUP BY` to calculate results across multiple entities or time periods.

## Example 4: Combining All Three Features

The following query demonstrates all new features together in a reporting scenario.  
It calculates projected inventory growth over time using today’s date as a baseline.

```sql
DECLARE @BaselineDate DATE = CURRENT_DATE;

WITH GrowthCTE AS
(
    SELECT WarehouseID, PRODUCT(GrowthFactor) AS CompoundGrowth
    FROM InventoryGrowth
    GROUP BY WarehouseID
)
SELECT
    WarehouseID,
    @BaselineDate AS StartDate,
    DATEADD(DAY, 365 * 5, @BaselineDate) AS FiveYearProjection,
    CompoundGrowth
FROM GrowthCTE;
```

### Result

| WarehouseID | StartDate | FiveYearProjection | CompoundGrowth |
|--------------|------------|--------------------|----------------|
| 101 | 2025-10-14 | 2030-10-13 | 1.2185 |
| 102 | 2025-10-14 | 2030-10-13 | 1.1052 |

This query demonstrates how `CURRENT_DATE`, `DATEADD(bigint)`, and `PRODUCT()` work together to support analytics and planning workloads in SQL Server 2025.

## Summary

SQL Server 2025 enhances date and numeric handling with simpler syntax and greater computational flexibility.  
`CURRENT_DATE` offers a clear way to retrieve today’s date, `DATEADD(bigint)` expands support for large intervals, and `PRODUCT()` adds a powerful new aggregation method.  
Together, these improvements make T-SQL more expressive, consistent, and capable for modern business and scientific workloads.
