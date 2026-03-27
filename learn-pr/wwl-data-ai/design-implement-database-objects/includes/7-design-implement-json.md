Relational databases work best when every row in a table has the same columns. You define the structure once, and every record follows it. This design works well for data like customers, orders, or invoices where the fields are predictable. But some data varies from record to record. The attributes you need to store depend on the type of item, the source of the data, or choices made by users. Traditional table design forces you to either create many columns that are empty for most rows, or split data across many tables. JSON columns offer another option: store the variable parts as JSON while keeping the predictable parts in regular columns.

For example, an e-commerce product catalog has common fields like product name, price, and category that apply to every item. But a shirt needs size and color, a laptop needs processor speed and screen size, and a book needs author and other attributes. With JSON, you store the common fields as columns and put the category-specific attributes in a JSON column. You can add new product types without changing the table structure.

## Understand when to use JSON columns

[JSON columns](/sql/relational-databases/json/json-data-sql-server?azure-portal=true) let you query and index semi-structured data using familiar SQL syntax. You don't need a separate NoSQL database to handle flexible data. Consider JSON for these scenarios:

- **User preferences** - Settings like theme, language, and notification options differ per user and change as you add features.
- **API responses** - Data from external services has nested structures that may change when the provider updates their API.
- **Audit logs** - Records that capture before and after states need to adapt as your table schemas evolve.
- **Multi-tenant applications** - Different customers require different custom fields.
- **Flexible metadata** - Tags, labels, and properties that vary by record and don't fit a fixed schema.

## Create and query JSON columns

SQL Server 2025 introduces a native [**json** data type](/sql/t-sql/data-types/json-data-type?azure-portal=true) that stores JSON documents in a binary format optimized for querying and manipulation. The native type provides more efficient reads (the document is already parsed), more efficient writes (updates can modify individual values without rewriting the entire document), and better storage compression compared to storing JSON as `NVARCHAR(MAX)`.

For earlier versions of SQL Server, you store JSON in an `NVARCHAR(MAX)` column.

To read values from JSON, you use [JSON functions](/sql/t-sql/functions/json-functions-transact-sql?azure-portal=true) like `JSON_VALUE` to extract a single value or `JSON_QUERY` to return an object or array. If you query a JSON property frequently, you can create an index on a computed column that extracts that property.

The following example creates a table with a JSON column, inserts documents, queries specific properties, updates values, and creates an index on a frequently accessed field:

```sql
-- Create table with native JSON type (SQL Server 2025+)
CREATE TABLE ConfigurationData (
    ConfigID INT PRIMARY KEY,
    ConfigSettings JSON NOT NULL
);

-- Insert JSON documents
INSERT INTO ConfigurationData (ConfigID, ConfigSettings) 
VALUES (1, '{"theme":"dark","language":"en","notifications":true}');

INSERT INTO ConfigurationData (ConfigID, ConfigSettings) 
VALUES (2, '{"theme":"light","language":"fr","notifications":false}');

-- Query JSON properties
SELECT ConfigID,
       JSON_VALUE(ConfigSettings, '$.theme') AS Theme,
       JSON_VALUE(ConfigSettings, '$.language') AS Language,
       JSON_QUERY(ConfigSettings, '$') AS FullConfig
FROM ConfigurationData;

-- Update a single property using the modify method (SQL Server 2025+ preview)
UPDATE ConfigurationData
SET ConfigSettings.modify('$.theme', 'light')
WHERE ConfigID = 1;

-- Alternative: JSON_MODIFY works with both JSON and NVARCHAR(MAX) columns
UPDATE ConfigurationData
SET ConfigSettings = JSON_MODIFY(CAST(ConfigSettings AS NVARCHAR(MAX)), '$.notifications', CAST(0 AS BIT))
WHERE ConfigID = 1;

-- Create index on frequently queried JSON property
ALTER TABLE ConfigurationData
ADD ThemeValue AS JSON_VALUE(ConfigSettings, '$.theme');

CREATE INDEX IX_Theme ON ConfigurationData(ThemeValue);
```

This example creates a table with a `JSON` column that stores user configuration settings. The `INSERT` statements add JSON documents as string literals. To read specific values, `JSON_VALUE` extracts scalar values like the theme and language, while `JSON_QUERY` returns the entire JSON object. The `.modify()` method (currently in preview) updates a single property without rewriting the whole document. Because the `json` type can't be used as an index key column, the example creates a computed column that extracts the theme value, then indexes that computed column.

## Combine relational and JSON structure

JSON columns work best for data that varies by record. If every row has the same fields with consistent data types, regular columns are a better fit. You get native data type validation, simpler queries without JSON path syntax, and direct indexing on columns. Use JSON for the parts of your data that need flexibility, and keep the predictable parts in typed columns.

You can combine relational structure with JSON flexibility for products requiring variable metadata. Here's an example:

```sql
-- Product with flexible metadata (SQL Server 2025+)
CREATE TABLE ProductMetadata (
    ProductID INT PRIMARY KEY,
    AdditionalAttributes JSON NOT NULL
        CHECK (JSON_PATH_EXISTS(AdditionalAttributes, '$.weight') = 1),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Store flexible product attributes
INSERT INTO ProductMetadata (ProductID, AdditionalAttributes) 
VALUES (1, '{"dimensions":{"length":10,"width":5,"height":8},"weight":2.5,"color":"blue"}');

-- Query nested JSON properties
SELECT ProductID,
       JSON_VALUE(AdditionalAttributes, '$.weight') AS Weight,
       JSON_VALUE(AdditionalAttributes, '$.dimensions.length') AS Length
FROM ProductMetadata;
```

## Consider JSON design principles

Apply these principles when implementing JSON columns:

- **Use JSON for semi-structured data** - Store flexible data structures that vary by record, not data with consistent schemas.
- **Index frequently queried paths** - Create computed columns with indexes on JSON properties you query often.
- **Validate required properties** - Use `CHECK` constraints with `JSON_PATH_EXISTS` to ensure required fields are present.
- **Balance flexibility with structure** - Keep predictable data in regular columns and use JSON only for the variable parts.

JSON columns provide schema flexibility for variable data while maintaining SQL query capabilities, but should complement rather than replace relational design for structured data.
