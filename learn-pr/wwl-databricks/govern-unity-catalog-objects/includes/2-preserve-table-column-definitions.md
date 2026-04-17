**Well-documented table and column definitions** are the foundation of effective data governance. When you create and preserve comprehensive **metadata** for your data assets, you enable data consumers to discover, understand, and trust the data they need. This becomes especially important as AI-driven data discovery tools rely on high-quality metadata to surface relevant information.

In this unit, you learn how to create tables with descriptive comments and tags, and use discovery tools to explore your data assets in Unity Catalog.

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=4dcfda01-41a5-403a-a5ad-badfd736e74c]

## Add comments to tables and columns

**Comments** provide human-readable descriptions that help data consumers understand the purpose and content of your data assets. You can add comments to any securable object in Unity Catalog, including catalogs, schemas, tables, views, and columns.

Consider the following example, where we add comments directly to columns as part of the `profiles` table definition:

```sql
CREATE TABLE sales.customers.profiles (
    customer_id   BIGINT COMMENT 'Unique identifier for each customer',
    email         STRING COMMENT 'Customer primary email address',
    created_date  DATE   COMMENT 'Date when customer account was created',
    preferences   STRUCT<notifications: BOOLEAN, language: STRING> 
                         COMMENT 'Customer preference settings'
);
```

### Add comments using SQL

Use the `COMMENT ON` statement to add or update comments on existing objects:

```sql
-- Add a comment to a table
COMMENT ON TABLE sales.customers.profiles 
IS 'Contains customer profile information including contact details and preferences';

-- Add a comment to a column
ALTER TABLE sales.customers.profiles 
ALTER COLUMN email COMMENT 'Primary email address used for account notifications';
```

You can also use markdown formatting in your comments to add structure:

```sql
COMMENT ON TABLE sales.orders.transactions IS 
'## Order Transactions
Contains all customer orders with the following key fields:
- **order_id**: Unique order identifier
- **customer_id**: Foreign key to customers table
- **order_date**: Date order was placed';
```

### Use AI-generated comments

Unity Catalog can automatically generate comments using AI-powered suggestions. This feature analyzes your table schema and column names to create initial descriptions. To generate AI comments in Catalog Explorer:

1. Open Catalog Explorer and select your table.
2. In the **About this table** panel, select **AI generate**.
3. Review the suggested comment and select **Accept** or **Edit** to modify it.

For column comments, select **AI generate** above the column list to generate suggestions for all columns.

:::image type="content" source="../media/2-use-ai-generated-comments.png" alt-text="Screenshot of AI-generated comments." lightbox="../media/2-use-ai-generated-comments.png":::

> [!IMPORTANT]
> **AI-generated comments** are suggestions based on schema analysis. Always review these comments before saving, as AI models might generate inaccurate descriptions. Don't rely on AI comments for data classification tasks like detecting personally identifiable information (PII).

### Required permissions for comments

To add or edit comments, you need:

- Ownership of the object, or
- `MODIFY` and `SELECT` privileges on the table
- `USE CATALOG` and `USE SCHEMA` on the parent catalog and schema

After adding comments, any user with the `BROWSE` privilege can view them in Catalog Explorer.

## Apply tags for organization and discovery

**Tags** are key-value pairs that help you organize and categorize data assets in Unity Catalog. Unlike comments, which provide descriptive text, tags enable structured classification and improve search functionality.

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=7f00114e-2681-48ea-a6dc-f59b73cf6d01]
    
### Add tags using SQL

Use the `ALTER` command with `SET TAGS` to apply tags:

```sql
-- Add tags to a table
ALTER TABLE sales.customers.profiles
SET TAGS ('domain' = 'sales', 'data_classification' = 'internal');

-- Add tags to a specific column
ALTER TABLE sales.customers.profiles
ALTER COLUMN email
SET TAGS ('pii' = 'email', 'sensitivity' = 'high');
```

To remove tags, use `UNSET TAGS`:

```sql
ALTER TABLE sales.customers.profiles
UNSET TAGS ('domain');
```

### Use governed tags

**Governed tags** provide centralized control over tag definitions. With governed tags, administrators define allowed keys and values at the account level, ensuring consistent classification across the organization. Governed tags appear with a lock icon in Catalog Explorer.

System tags are a special type of governed tag predefined by Azure Databricks for common use cases like data classification, ownership tracking, and lifecycle management.

### Tag constraints

Keep these constraints in mind when working with tags:

- Maximum 50 tags per securable object
- Maximum 1,000 column tags per table
- Tag keys have a 255-character limit
- Tag values have a 1,000-character limit
- Tag keys are case-sensitive

## Explore and discover database objects

After you create and document your data assets, you need ways to find and explore them. Unity Catalog provides several tools for data discovery.

### Use Catalog Explorer

**Catalog Explorer** provides a visual interface for navigating your data assets. When you select a table, you can:

- View the **Columns** tab to see column names, data types, and comments
- Select the **Sample Data** tab to preview table contents
- Check the **Details** tab for table properties and metadata
- Review the **History** tab for Delta table version history

The **Insights** tab shows frequent queries and users who accessed the table in the past 30 days, helping you understand how data is being used.

### Explore objects using SQL

Use SQL commands to programmatically explore your catalog:

```sql
-- List all catalogs available to you
SHOW CATALOGS;

-- List schemas in a catalog
SHOW SCHEMAS IN sales;

-- List tables in a schema
SHOW TABLES IN sales.customers;

-- View table details including comments
DESCRIBE TABLE EXTENDED sales.customers.profiles;

-- View table columns
SHOW COLUMNS IN sales.customers.profiles;

-- View table properties
SHOW TBLPROPERTIES sales.customers.profiles;
```

You can filter results using pattern matching:

```sql
-- Find tables matching a pattern
SHOW TABLES IN sales.customers LIKE 'profiles_*';
```

### Search using tags

Use the workspace search bar to find tables and views by their tags. Enter tag keys or values to locate matching objects. Only objects you have at least the `BROWSE` privilege on appear in search results.

### View table relationships

For tables with defined foreign keys, select **View relationships** in Catalog Explorer to display an Entity Relationship Diagram (ERD). This diagram visualizes how tables connect through primary and foreign key relationships.

### Integrate with AI/BI tools

AI-powered discovery tools like **AI/BI Genie** use your table comments and tags to provide natural language search and question answering. High-quality metadata directly improves the accuracy of AI-assisted data exploration.

Maintaining comprehensive table and column definitions is an ongoing responsibility. As your data evolves, update your comments and tags to keep them accurate. This investment in metadata quality pays dividends through improved discoverability, governance compliance, and AI-readiness.
