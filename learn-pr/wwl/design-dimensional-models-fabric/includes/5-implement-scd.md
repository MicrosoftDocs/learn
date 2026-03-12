Dimension data changes over time. Customers move to new cities, products get renamed, and employees transfer between departments. A primary role of a data warehouse is to describe the past accurately, so you need a strategy for handling these changes. Slowly changing dimension (SCD) patterns define how your dimensional model responds when source data changes.

## Understand SCD types

Different business requirements call for different approaches to tracking change. The following SCD types range from ignoring changes entirely to maintaining full historical records.

### Type 0: Retain original

Type 0 preserves the original value and never allows changes. Use Type 0 for fixed reference data that shouldn't change, such as an original credit score at the time of application or a date of birth.

### Type 1: Overwrite

Type 1 overwrites the existing value with the new value. No history is maintained. This approach is appropriate when:

- The change is a correction to an error.
- Historical accuracy for the changed attribute isn't important.
- You need the simplest possible maintenance.

For example, if a customer's email address changes, a Type 1 update replaces the old email with the new one. All historical facts associated with that customer now reflect the current email address.

> [!NOTE]
> Type 1 changes can affect historical analysis. If a salesperson is reassigned to a new region and you overwrite the region, all their past sales appear under the new region. Consider whether this behavior meets your reporting requirements.

### Type 2: Add new row

Type 2 inserts a new row for each change, maintaining full history. The original row remains, and each version of the dimension member gets its own surrogate key. This SCD type is most common for attributes where historical accuracy matters.

A Type 2 implementation requires additional columns:

| Column | Purpose |
|--------|---------|
| **Start date** | When this version became effective |
| **End date** | When this version was superseded (current rows use a far-future date like 9999-12-31) |
| **Is current flag** | Identifies the active version for lookups during fact table loads |

When a change occurs, the ETL process:

1. Updates the existing current row by setting its end date and changing the current flag to `FALSE`.
2. Inserts a new row with the new attribute values, a new surrogate key, the start date set to the change date, and the current flag set to `TRUE`.

Type 2 is essential when you need to analyze the past accurately. For example, if you need to report sales by the region a salesperson was assigned to at the time of each sale, Type 2 tracking preserves that context.

:::image type="content" source="../media/scd-type-2.svg" alt-text="Before-and-after diagram of SCD Type 2, showing how a customer's region change creates a new dimension row with updated surrogate key, dates, and current flag while the original row is expired." lightbox="../media/scd-type-2.svg":::

### Type 3: Add new column

Type 3 adds a column to store the previous value alongside the current value. This approach tracks limited history, typically just the most recent change.

For example, a salesperson dimension might include both `CurrentSalesRegion` and `PreviousSalesRegion` columns. When the salesperson moves, the current region shifts to the previous column, and the new region becomes current.

Type 3 is useful when you only need to compare the current state with one prior state. However, it's not commonly used because you lose all intermediate changes.

### Type 6: Hybrid approach

Type 6 combines elements of Type 1, Type 2, and Type 3. It maintains full version history (Type 2) while also storing the current value on every row (Type 1 overwrite on a specific column) and the previous value (Type 3).

This hybrid enables queries to access both the historical and current context from any version row. However, it adds complexity to the ETL process because every row for a dimension member must be updated when the current value changes.

## Choose the right SCD type

Use the following guidance to select the appropriate SCD type:

| Requirement | Recommended type |
|-------------|-----------------|
| Fixed reference data that never changes | Type 0 |
| Corrections, or history not needed | Type 1 |
| Full historical accuracy required | Type 2 |
| Only need current vs. previous comparison | Type 3 |
| Need both current and historical views on every row | Type 6 |

## Consider implementation tradeoffs

Each SCD type has cost and complexity implications:

- **Storage**: Type 2 dimensions grow over time as new version rows accumulate. Plan for increased storage and consider how the growth affects query performance.
- **Query complexity**: Joining fact tables to Type 2 dimensions requires matching on effective dates or using the current flag, which adds complexity to queries.
- **ETL complexity**: Type 2 and Type 6 require more sophisticated ETL logic to detect changes, expire old rows, and insert new versions.
- **Business requirements**: The choice of SCD type should be driven by business needs. Don't track history where it isn't needed, and don't skip history tracking where it is.

> [!TIP]
> Avoid applying Type 2 tracking to every attribute in a dimension. Only track history on attributes where the business requires historical analysis. Use Type 1 for the rest to keep the dimension manageable.

