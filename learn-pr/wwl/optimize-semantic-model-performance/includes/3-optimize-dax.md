When Performance analyzer identifies a slow DAX query, the next step is to optimize the DAX itself. Inefficient DAX is one of the most common causes of poor semantic model performance. Small changes to measure definitions can reduce query times significantly.

## Use variables to eliminate repeated calculations

One of the most effective DAX optimization techniques is using variables (`VAR` / `RETURN`). When a formula evaluates the same expression more than once, the engine recalculates it each time. Variables store the result of an expression once and reuse it, which can cut query time roughly in half for formulas with repeated subexpressions.

Consider this year-over-year growth measure:

```dax
Sales YoY Growth % =
DIVIDE(
    ([Sales] - CALCULATE([Sales], PARALLELPERIOD('Date'[Date], -12, MONTH))),
    CALCULATE([Sales], PARALLELPERIOD('Date'[Date], -12, MONTH))
)
```

The `PARALLELPERIOD` expression evaluates twice: once in the numerator and once in the denominator. Rewriting with a variable eliminates the redundancy:

```dax
Sales YoY Growth % =
VAR SalesPriorYear =
    CALCULATE([Sales], PARALLELPERIOD('Date'[Date], -12, MONTH))
RETURN
    DIVIDE(([Sales] - SalesPriorYear), SalesPriorYear)
```

The result is the same, but the engine evaluates `SalesPriorYear` only once. Variables also improve readability: descriptive variable names make complex formulas easier to understand and maintain.

> [!TIP]
> Variables also simplify debugging. You can temporarily change the `RETURN` expression to output just the variable value, which lets you inspect intermediate results without rewriting the entire formula.

## Understand FILTER vs. KEEPFILTERS

How you apply filter modifications in DAX directly affects on performance. The `FILTER` function iterates over a table row by row to evaluate a condition. When applied to a large table, this iteration can be expensive.

```dax
-- Expensive: FILTER iterates the entire Sales table
High Value Sales =
CALCULATE(
    [Total Sales],
    FILTER(Sales, Sales[Amount] > 1000)
)
```

When you use `FILTER` on a table with millions of rows, the engine creates a row-by-row iteration context. If the filter logic only involves a single column, you can often replace `FILTER` with a simpler Boolean expression:

```dax
-- More efficient: column filter
High Value Sales =
CALCULATE(
    [Total Sales],
    Sales[Amount] > 1000
)
```

`KEEPFILTERS` serves a different purpose. It preserves existing filter context instead of replacing it. Use `KEEPFILTERS` when you want to add a filter condition without overriding what's already applied by slicers or other visuals:

```dax
Online Sales =
CALCULATE(
    [Total Sales],
    KEEPFILTERS(Sales[Channel] = "Online")
)
```

The performance difference between `FILTER` and direct column predicates is most noticeable on large tables. As a general rule, avoid `FILTER` on entire tables when a column-level predicate achieves the same result.

## Manage iterator function costs

Iterator functions like `SUMX`, `AVERAGEX`, `MAXX`, and `COUNTX` evaluate an expression for each row in a table and then aggregate the results. They're powerful and sometimes necessary, but they come with a cost: especially on large tables.

```dax
-- Iterates every row in the Sales table
Weighted Average Price =
SUMX(
    Sales,
    Sales[Quantity] * Sales[UnitPrice]
) / SUM(Sales[Quantity])
```

This formula works correctly, but if the Sales table has 50 million rows, `SUMX` evaluates the multiplication for every row. When an equivalent non-iterator expression exists, use it:

```dax
-- Non-iterator equivalent (if LineTotal is a column)
Total Revenue = SUM(Sales[LineTotal])
```

Iterator functions aren't inherently bad. They're the right choice when you need row-level calculation logic that can't be expressed with a simple aggregation. The key is understanding the cost: iterator performance scales with table size, so an iterator over 1,000 rows is fine, but the same iterator over 100 million rows can become a bottleneck.

## Avoid expensive patterns

Certain DAX patterns are known to cause performance problems. Recognizing them helps you write better formulas from the start.

**COUNTROWS(FILTER(...)) on large tables.** This pattern iterates an entire table to count rows matching a condition. Replace it with `CALCULATE` and `COUNTROWS` with a filter argument:

```dax
-- Expensive
Large Orders = COUNTROWS(FILTER(Sales, Sales[Amount] > 1000))

-- Better
Large Orders = CALCULATE(COUNTROWS(Sales), Sales[Amount] > 1000)
```

**Nested CALCULATE with complex filters.** Each nested `CALCULATE` creates a new filter context transition. Deeply nested formulas with multiple context changes are hard to optimize. Simplify by breaking complex measures into smaller component measures that each handle a single filter modification.

**Mixing aggregation grains.** Measures that combine data at different levels of granularity (for example, comparing a single row's value to a table-level total) require context transitions that can be expensive. Use variables to evaluate the total once and reuse it:

```dax
Pct of Total =
VAR TotalSales = CALCULATE([Total Sales], REMOVEFILTERS())
RETURN
    DIVIDE([Total Sales], TotalSales)
```

## Move calculations to the data layer

If a DAX measure computes the same result on every query refresh and the underlying data doesn't change between refreshes, consider materializing that calculation in the data layer instead.

For example, a calculated column that concatenates first and last name runs during data refresh and stores the result. But the same logic as a measure would run on every query. For static transformations like this, you have two options:

- **Power Query computed columns**: Define the transformation in M during data load. These columns compress more efficiently than DAX calculated columns because the VertiPaq engine can optimize storage during load.
- **Source-level calculations**: If the data source is a SQL database, add the calculation to the SQL view or query. This uses the database engine's optimization capabilities.

Reserve DAX calculated columns for scenarios that require DAX-specific functions, such as evaluating measures or using time intelligence functions that depend on the semantic model's relationships.

> [!IMPORTANT]
> Moving calculations upstream doesn't just improve query performance: it also reduces data refresh times, because DAX calculated columns are evaluated after all Power Query tables finish loading.

## Consider the AI experience

DAX performance directly affects AI-powered experiences. In Microsoft Fabric, IQ data agents and Copilot chat query your semantic model by generating DAX queries behind the scenes. A measure that takes five seconds for a human user takes the same five seconds for Copilot: and AI interactions often have tighter timeout thresholds than interactive reports.

Optimizing DAX isn't just about faster reports. It's about making your data responsive enough to support natural language queries, automated agents, and real-time analytics.
