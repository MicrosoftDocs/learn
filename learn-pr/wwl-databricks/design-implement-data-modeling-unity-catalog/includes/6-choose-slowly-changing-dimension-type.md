>[!VIDEO https://learn-video.azurefd.net/vod/player?id=ef81731a-cc31-4098-9baa-841144ed261a]

Dimension tables in a data warehouse capture descriptive attributes about business entities like customers, products, or employees. These attributes change over time, and how you handle those changes directly affects your ability to perform accurate historical analysis. Slowly changing dimensions (SCDs) provide frameworks for managing these changes, and choosing the right SCD type is a critical design decision.

As a data engineer, you're expected to understand SCD types and implement them when directed. While data architects often make the initial design decisions, you need sufficient knowledge to evaluate trade-offs, recommend approaches, and execute implementations correctly. This unit helps you understand the characteristics of each SCD type so you can select the appropriate approach for your business requirements.

## Understand dimension changes

Before selecting an SCD type, consider what happens when source data changes. Imagine a customer named Hank Zoeng moves from Seattle to Portland. Your customer dimension table currently shows Seattle as his city. You have three fundamental options:

- **Overwrite** the existing value with Portland, losing all record that he was ever in Seattle.
- **Preserve** the Seattle record and create a new version showing Portland, maintaining the complete history.
- **Track** a limited history by adding a "previous city" column alongside the current value.

Each approach serves different analytical needs. Sales reports that show "current customer location" need different handling than analyses tracking "customer migration patterns" or "sales by customer's region at time of purchase."

## SCD Type 0

**SCD Type 0** represents the simplest approach: never update dimension attributes after the initial insert. The original values remain permanently, regardless of source system changes.

:::image type="content" source="../media/6-slowly-changing-dimension-type-0.png" alt-text="Diagram explaining SCD type 0." border="false" lightbox="../media/6-slowly-changing-dimension-type-0.png":::

This type works well for:

- **True constants**: Birth dates, original registration dates, or founding dates that genuinely never change.
- **Audit requirements**: When regulations require preserving the original value exactly as first recorded.
- **Reference data**: Lookup values that represent permanent classifications.

Type 0 is rarely used in isolation because most dimension attributes do change over time. However, individual columns within a dimension table might use Type 0 treatment while other columns use different SCD types.

## SCD Type 1

**SCD Type 1** overwrites the existing dimension record with new values. When Hank moves from Seattle to Portland, you update his row directly. The dimension table always reflects the current state of the source system.

:::image type="content" source="../media/6-slowly-changing-dimension-type-1.png" alt-text="Diagram explaining SCD type 1." border="false" lightbox="../media/6-slowly-changing-dimension-type-1.png":::

Type 1 is appropriate when:

- **Historical values don't matter**: Correcting data entry errors, updating email addresses, or refreshing phone numbers.
- **Analysis focuses on current state**: Reports that answer "where do our customers live today?" rather than "where did they live when they made purchases?"
- **Simplicity is prioritized**: Type 1 requires no additional columns or versioning logic.

> [!IMPORTANT]
> Type 1 changes affect historical aggregations. If Hank purchased $10,000 of products while in Seattle, those sales now appear attributed to Portland after the update. This behavior might misrepresent historical performance by region.

Consider using Type 1 for supplementary attributes that don't affect analytical accuracy, such as:

- Contact information (email, phone, address corrections).
- Descriptive text fields (product descriptions, customer notes).
- Error corrections in any attribute.

## SCD Type 2

**SCD Type 2** preserves complete history by inserting new rows for each version of a dimension member. When Hank moves to Portland, the existing Seattle row remains and a new Portland row is created. Both rows share the same natural key (customer ID) but have different surrogate keys.

> [!NOTE]
> A natural key is also referred to as a **business key** or **source system key**. It represents the unique identifier from the original data source, such as customer ID, employee number, or product code.

Type 2 dimensions require additional tracking attributes:

| Attribute               | Purpose                                                  |
| ----------------------- | -------------------------------------------------------- |
| **Surrogate key**       | Unique identifier for each version                       |
| **Validity start date** | When this version became effective                       |
| **Validity end date**   | When this version expired (often 12/31/9999 for current) |
| **Current flag**        | Boolean indicating the active version                    |

The following table shows how Hank Zoeng's customer record appears after moving from Seattle to Portland:

| SK   | CustomerID | Name       | City     | ValidFrom  | ValidTo    | Current |
| ---- | ---------- | ---------- | -------- | ---------- | ---------- | ------- |
| 1001 | C-555      | Hank Zoeng | Seattle  | 2020-01-15 | 2024-03-01 | FALSE   |
| 1002 | C-555      | Hank Zoeng | Portland | 2024-03-01 | 9999-12-31 | TRUE    |

Type 2 is appropriate when:

- **Historical accuracy matters**: Analyzing sales by the customer's location at the time of purchase.
- **Audit trails are required**: Tracking employee assignments, territory changes, or organizational restructuring over time.
- **Trend analysis is needed**: Understanding how dimension attributes evolved.

Type 2 increases complexity and storage requirements. Each version creates a new row, and fact tables reference specific versions through surrogate keys. Query complexity increases because analysts must understand the versioning model.

> [!TIP]
> Reserve Type 2 for attributes where historical perspective affects business decisions. Don't apply Type 2 to every changing attribute—the overhead isn't justified for supplementary data like phone numbers.

## SCD Type 3

**SCD Type 3** tracks limited history by adding columns for previous values. Instead of creating new rows, you add a "previous city" column alongside "current city." This approach tracks only the most recent change, not the complete history.

The following table shows how Hank Zoeng's customer record appears after moving from Seattle to Portland:

| CustomerID | Name       | CurrentCity | PreviousCity |
| ---------- | ---------- | ----------- | ------------ |
| C-555      | Hank Zoeng | Portland    | Seattle      |

Type 3 is appropriate when:

- **Only the previous value matters**: Comparing current versus prior organizational structure.
- **Storage constraints exist**: When Type 2 versioning would create too many rows.
- **Analysis compares before and after**: Product reformulations, price tier changes, or policy updates.

Type 3 is the least common SCD type because:

- It captures only one prior value (or a fixed number of prior values).
- Adding columns for each tracked attribute can widen tables significantly.
- Semantic models can find Type 3 structures difficult to use.

Most scenarios that seem to need Type 3 are better served by Type 2, which provides complete history without schema changes for each attribute.

## Compare SCD types

The following table summarizes when to select each SCD type:

| Consideration               | Type 0                        | Type 1                             | Type 2                                | Type 3                   |
| --------------------------- | ----------------------------- | ---------------------------------- | ------------------------------------- | ------------------------ |
| **History preserved**       | Original only                 | None                               | Complete                              | Limited                  |
| **Storage impact**          | Minimal                       | Minimal                            | High                                  | Moderate                 |
| **Query complexity**        | Simple                        | Simple                             | Complex                               | Moderate                 |
| **Common use cases**        | Constants, audit requirements | Error corrections, contact updates | Sales attribution, territory tracking | Before/after comparisons |
| **Fact table relationship** | Natural key                   | Natural key                        | Surrogate key                         | Natural key              |

## Apply mixed SCD strategies

Production dimension tables often combine multiple SCD types. A customer dimension might handle attributes differently based on their analytical significance:

- **Type 0**: Original registration date (never changes).
- **Type 1**: Email address, phone number (current state is sufficient).
- **Type 2**: Assigned sales region (historical accuracy required for sales attribution).

This hybrid approach balances storage efficiency with analytical requirements. When designing dimensions, evaluate each attribute individually to determine the appropriate change handling strategy.

Understanding when to apply each SCD type enables you to implement dimensions that accurately support your organization's analytical requirements. The implementation details for loading and maintaining SCD tables in Azure Databricks are covered in later units.
