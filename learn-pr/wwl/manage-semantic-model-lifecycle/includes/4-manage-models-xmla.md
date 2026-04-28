Version control tracks changes to your semantic models, but it doesn't verify that the model is correct. A renamed column might break relationships. A modified measure might return unexpected results. The XMLA endpoint provides programmatic access to semantic models so you can inspect, validate, and test them through code and external tools.

## What is the XMLA endpoint?

The XMLA (XML for Analysis) endpoint is the protocol that Power BI uses for communication between client applications and the engine that manages semantic models. Every Fabric or Power BI Premium workspace exposes an XMLA endpoint. All data sent over the XMLA protocol is fully encrypted.

By default, the endpoint is enabled for **read-only** access, which lets you query model data and metadata. Capacity administrators can also enable **read-write** access for a workspace. Read-write unlocks additional capabilities like deploying model changes, running scripted operations, and triggering refresh from external tools. This unit focuses on tasks you can complete with read-only access.

The XMLA endpoint connection string follows this format:

```
powerbi://api.powerbi.com/v1.0/[tenant name]/[workspace name]
```

The connection string targets the workspace. After connecting, you specify which semantic model to query. In SemPy, you pass the model name as a parameter. In desktop tools like DAX Studio or Tabular Editor, you select the model as the database or initial catalog.

Applications that work with Azure Analysis Services or SQL Server Analysis Services typically work with Power BI through XMLA with minimal configuration changes.

## SemPy in Fabric notebooks

SemPy is the Python library in Fabric notebooks that connects to semantic models through the XMLA endpoint. It provides a Python-native way to inspect metadata, validate structure, and test calculations without leaving the notebook environment. SemPy is included in Fabric Runtime 1.2 and later, so you don't need to install it separately.

### Inspect model metadata

Use SemPy functions to explore the structure of a published semantic model. These functions return DataFrames you can filter, sort, and analyze programmatically:

```python
import sempy.fabric as fabric

# List all tables in a semantic model
tables = fabric.list_tables("Sales Model", workspace="Sales Workspace")

# List columns for all tables
columns = fabric.list_columns("Sales Model", workspace="Sales Workspace")

# List all measures defined in the model
measures = fabric.list_measures("Sales Model", workspace="Sales Workspace")
```

Metadata inspection helps you understand an unfamiliar model quickly. You can check how many tables a model contains, which columns are available, and what measures are defined, all from a notebook cell rather than opening Power BI Desktop.

### Validate relationships

Relationship errors are a common source of incorrect report results. Foreign key values that don't match primary key values create orphaned rows, which can cause blank rows in reports or incorrect aggregations:

```python
# List all relationships in the model
relationships = fabric.list_relationships("Sales Model", workspace="Sales Workspace")

# Read tables into DataFrames and check for relationship violations (orphaned keys)
tables = {table: fabric.read_table("Sales Model", table, workspace="Sales Workspace")
          for table in fabric.list_tables("Sales Model", workspace="Sales Workspace")["Name"]}
violations = fabric.list_relationship_violations(tables)
```

The `list_relationship_violations()` function takes a dictionary of table DataFrames and uses the relationship metadata from the semantic model to validate data integrity. It returns rows where a foreign key value in one table has no matching primary key value in the related table. If the result is empty, all relationships are intact. If violations exist, you know exactly which tables and keys need attention before the model goes to production.

### Test measure calculations

Verify that DAX measures return expected results by evaluating them programmatically. This is useful after making changes to ensure nothing broke:

```python
# Evaluate a specific measure grouped by dimensions
result = fabric.evaluate_measure(
    "Sales Model",
    measure="Total Revenue",
    groupby_columns=["Date[Year]", "Product[Category]"],
    workspace="Sales Workspace"
)

# Run a custom DAX query
dax_result = fabric.evaluate_dax(
    "Sales Model",
    'EVALUATE SUMMARIZECOLUMNS(Date[Year], "Revenue", [Total Revenue])',
    workspace="Sales Workspace"
)
```

By comparing the output against known values, you create a simple validation check. For example, if total revenue for 2024 should be a specific amount, you can assert that value in Python and flag discrepancies automatically.

### Check data quality

Read table data into a FabricDataFrame to inspect data quality. A FabricDataFrame is a pandas DataFrame that preserves semantic metadata from the model:

```python
# Read a table and check for quality issues
df = fabric.read_table("Sales Model", "Customers", workspace="Sales Workspace")

# Check for null values in key columns
null_counts = df[["CustomerKey", "CustomerName"]].isnull().sum()
print(null_counts)

# Verify unique keys
duplicate_keys = df["CustomerKey"].duplicated().sum()
print(f"Duplicate customer keys: {duplicate_keys}")
```

Data quality checks in notebooks are repeatable. You can run the same notebook before every deployment to catch issues that visual inspection might miss. Over time, these notebooks become a validation suite for your semantic models.

## Validate with external tools

External desktop tools also connect to semantic models through the XMLA endpoint. These tools provide interactive capabilities that complement SemPy's automated approach:

- **DAX Studio** lets you write and test DAX queries interactively against published semantic models. Use it to verify that measures return expected results before deployment.
- **Tabular Editor** lets you inspect and edit model structure through a visual object tree. Its Best Practice Analyzer (BPA) runs configurable rules to catch structural issues like hidden columns referenced in measures, unused tables, or missing descriptions.
- **ALM Toolkit** compares schemas between two semantic models, for example development and production, so you can review differences before deployment.

The Fabric service also includes a built-in Best Practice Analyzer you can run directly from a semantic model's context menu. It generates a notebook that checks more than 60 rules across five categories: Performance, DAX Expressions, Error Prevention, Maintenance, and Formatting. No external tool installation is required.

All three external tools use the same XMLA connection string you'd use in a notebook. The difference is interactivity: choose these tools when you need real-time visual feedback versus SemPy's scripted, repeatable validation.

## Choose the right approach

Both SemPy and external tools access semantic models through XMLA, but they serve different workflows:

| Task | SemPy in notebooks | External tools |
|---|---|---|
| Inspect model metadata | `list_tables()`, `list_measures()`, `list_columns()` | Tabular Editor |
| Validate relationships | `list_relationship_violations()` | Tabular Editor |
| Test measure calculations | `evaluate_measure()`, `evaluate_dax()` | DAX Studio |
| Check data quality | `read_table()` with Python assertions | — |
| Best practice audit | Built-in BPA from semantic model menu | Tabular Editor BPA |
| Schema compare | — | ALM Toolkit |

Use SemPy when you need automated, repeatable validation — run the same notebook before every deployment to catch structural issues programmatically. Use external tools when you need interactive exploration and real-time feedback on the desktop.

> [!NOTE]
> Both SemPy and external tools rely on the XMLA endpoint. If the endpoint is disabled, neither approach works. Verify the endpoint is enabled in the capacity admin portal before starting.

With programmatic validation in place, the **Validate** stage is complete. Next, you move to the **Deploy** stage — promoting tested content to production through deployment pipelines.
