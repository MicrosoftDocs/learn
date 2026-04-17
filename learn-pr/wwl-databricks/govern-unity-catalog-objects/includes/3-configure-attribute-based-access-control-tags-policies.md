>[!VIDEO https://learn-video.azurefd.net/vod/player?id=5c876d18-dc54-41e5-a8db-12a6e0b7fd41]

Attribute-based access control (ABAC) provides a flexible, scalable approach to data governance in Unity Catalog. Instead of managing individual permissions for every table and user combination, you define policies based on attributes. When you tag data assets with meaningful classifications, ABAC policies automatically enforce the right access controls.

> [!IMPORTANT]
> ABAC in Unity Catalog is currently in **Public Preview**. Features may change before general availability.

In this unit, you learn how to use governed tags and ABAC policies to implement dynamic, centralized access control across your Unity Catalog environment.

## Understand governed tags

Governed tags differ from the standard tags you've already encountered. While standard tags help with organization and discovery, governed tags add enforcement and consistency at the account level. Administrators define governed tags with specific allowed values, and only authorized users can assign them.

:::image type="content" source="../media/3-understand-governed-tags.png" alt-text="Diagram explaining standard and governed tags." border="false" lightbox="../media/3-understand-governed-tags.png":::

Consider the following differences between tag types:

| Aspect           | Standard tags                     | Governed tags                      |
| ---------------- | --------------------------------- | ---------------------------------- |
| Scope            | Any key-value pair                | Predefined keys and allowed values |
| Control          | Any user with `APPLY TAG` privilege | Only users with `ASSIGN` permission  |
| Purpose          | Organization and discovery        | Policy enforcement and compliance  |
| Visual indicator | None                              | Lock icon in Catalog Explorer      |

Governed tags serve as the foundation for ABAC policies. When you tag a table with `sensitivity=high`, you can then create a policy that masks certain columns for all tables with that tag. This approach scales efficiently because adding the tag to new tables automatically applies the policy.

### Create governed tags

To create a governed tag, select **Catalog** > **Governance** > **Governed Tags**, then select **Create governed tag**. Enter a tag key, an optional description, and define the allowed values. Only these predefined values can be assigned to objects with this tag key.

For example, you might create a governed tag with key `pii` and allowed values `ssn`, `email`, and `address`. This ensures consistent classification of personally identifiable information across your organization.

:::image type="content" source="../media/3-create-governed-tag.png" alt-text="Screenshot showing the create governed tag dialog box." lightbox="../media/3-create-governed-tag.png":::

> [!NOTE]
> Tag data is stored as plain text. Don't use tag names or values that contain sensitive information.

### Assign governed tags to objects

After creating a governed tag, apply it to columns, tables, schemas, or catalogs using the `SET TAGS` command:

```sql
-- Tag a column as containing SSN data
ALTER TABLE customers.profiles
ALTER COLUMN SSN
SET TAGS ('pii' = 'ssn');

-- Tag an entire table as containing sensitive data
ALTER TABLE customers.profiles
SET TAGS ('sensitivity' = 'high');
```

Governed tags applied to catalogs or schemas automatically inherit to all objects within them. This inheritance simplifies governance across large data estates.

> [!NOTE]
> Tag inheritance applies only at the catalog and schema levels. Tags on individual table columns aren't inherited.

## Create row filter policies

Row filter policies control which rows users can see based on governed tags. You define a user-defined function (UDF) that returns `TRUE` for rows the user should see and `FALSE` for rows to hide.

Before creating a policy, you need a UDF that implements your filtering logic. The following example creates a function that filters out European addresses:

```sql
CREATE OR REPLACE FUNCTION filter_non_eu(address STRING)
RETURNS BOOLEAN
RETURN NOT (
    LOWER(address) LIKE '%eu%' OR
    LOWER(address) LIKE '%europe%'
);
```

Now create a row filter policy that uses this function:

```sql
CREATE POLICY hide_eu_customers
ON CATALOG sales
ROW FILTER filter_non_eu
TO `analysts`
FOR TABLES
MATCH COLUMNS
    hasTagValue('pii', 'address') AS addr
USING COLUMNS (addr);
```

This policy applies the `filter_non_eu` function to any table in the `sales` catalog that has a column tagged with `pii=address`. The `analysts` group only sees rows where the function returns `TRUE`.

You can also create policies using Catalog Explorer. Select the catalog or schema, choose the **Policies** tab, and select **New policy**. The visual interface guides you through selecting principals, scope, and conditions.

:::image type="content" source="../media/3-create-policy.png" alt-text="Screenshot for creating policies using Catalog Explorer." lightbox="../media/3-create-policy.png":::

## Create column mask policies

Column mask policies control what values users see in specific columns. Like row filters, these policies rely on UDFs to implement the masking logic.

Create a masking function that returns a redacted value:

```sql
CREATE OR REPLACE FUNCTION mask_ssn(ssn STRING)
RETURNS STRING
DETERMINISTIC
RETURN '***-**-****';
```

Then create a column mask policy:

```sql
CREATE POLICY mask_sensitive_ssn
ON SCHEMA customers
COLUMN MASK mask_ssn
TO `all_users`
EXCEPT `compliance_team`
FOR TABLES
MATCH COLUMNS
    hasTagValue('pii', 'ssn') AS ssn_col
ON COLUMN ssn_col;
```

This policy masks SSN values for all users except the compliance team. Any column in the `customers` schema tagged with `pii=ssn` displays `***-**-****` instead of the actual value.

## Follow UDF best practices

The functions that power your ABAC policies run on every query against protected tables. Poorly designed UDFs can significantly impact query performance.

Follow these guidelines when writing UDFs for ABAC:

- **Keep logic simple**: Use basic `CASE` statements and boolean expressions
- **Stay deterministic**: The same input should always produce the same output
- **Avoid external calls**: Don't make API calls or lookups to other databases
- **Reference only table columns**: This enables query optimization and predicate pushdown
- **Test at scale**: Validate performance with at least 1 million rows

Avoid common performance pitfalls:

- Calling `is_account_group_member()` or `is_member()` inside UDFs
- Using complex subqueries or joins within the function
- Performing heavy regex operations on large text fields
- Including non-deterministic logic that prevents caching

Keep access control decisions in the policy definition, not the UDF. The policy specifies who the rules apply to; the UDF specifies how to transform the data.

## Understand policy inheritance and scope

ABAC policies follow an inheritance model that simplifies governance at scale. A policy defined at the catalog level automatically applies to all schemas and tables within that catalog. Similarly, schema-level policies apply to all tables in the schema.

Policy quotas limit how many policies you can create:

- 10 policies per catalog
- 10 policies per schema
- 5 policies per table

Only one row filter can apply to any given table, and only one column mask can apply to any given column. If multiple policies would result in multiple filters or masks, Azure Databricks blocks access and throws an error.

:::image type="content" source="../media/3-understand-policy-inheritance-scope.png" alt-text="Diagram explaining policy inheritance and scope." border="false" lightbox="../media/3-understand-policy-inheritance-scope.png":::

> [!IMPORTANT]
> You must use Databricks Runtime 16.4 or above, or serverless compute, to access tables secured by ABAC policies. Users not subject to the policy can use any runtime.

When you configure ABAC effectively, you create a governance model that scales with your organization. Adding the appropriate governed tag to a new table immediately brings it under the protection of existing policies, without requiring additional configuration.
