Unity Catalog organizes and secures your data and AI assets using a **hierarchical architecture**. Think of it like addressing a specific location: just as you use Country → State → City → Street Address to find a specific place, Unity Catalog uses a three-level namespace to organize, find, and control access to your data assets.

At the top of this hierarchy sits the **metastore**, the top-level container that provides unified governance for multiple Azure Databricks workspaces in the same region. Below that are catalogs, schemas, and finally your data objects (tables, views, volumes, functions, and models).

This hierarchical design solves a key challenge: before Unity Catalog, each workspace managed its own data governance independently - separate permission systems for each workspace. Unity Catalog's shared metastore provides unified governance across all connected workspaces while maintaining clear organizational boundaries.

## Understand the metastore role

The **metastore** is the top-level container for metadata in Unity Catalog that enables multiple Azure Databricks workspaces to share the same data view and security rules.

To understand how this works, think of the metastore as having four key responsibilities:

- **Regional boundary**: Serves as the governance boundary for all workspaces within one Azure region, ensuring data stays within regional compliance requirements (such as GDPR for European regions)
- **Workspace connection**: Multiple workspaces connect to the same metastore, sharing governance rules and data access
- **Metadata management**: Stores information about your data objects (table schemas, permissions, lineage) securely in Databricks' managed services
- **Storage coordination**: Provides a default location for managed table and volume data files

This design delivers unified governance - set permissions once in the metastore, apply them to every query and data access across all connected workspaces. Whether someone queries tables, views, volumes, or functions, Unity Catalog enforces the same security rules consistently. Unity Catalog works alongside existing Hive metastores, which appear as a special `hive_metastore` catalog for backward compatibility.

> [!TIP]
> Each Azure region can have only **one Unity Catalog metastore per Azure Databricks account**. An Azure Databricks account is your organization's top-level container that spans multiple Azure subscriptions and regions. Within each region where you operate, all workspaces in that region share one metastore. For example, all East US workspaces share one metastore, all West Europe workspaces share a different metastore. This regional boundary ensures data residency compliance and optimal performance.

## Explore the three-level namespace

The metastore **exposes** a three-level namespace for organizing data assets. Traditional SQL uses two levels (`schema.object`), but Unity Catalog adds a third level: `catalog.schema.object`.

```text
Metastore (regional boundary - one per Azure region per Databricks account)
└── Catalogs (first level - organize data assets)
    └── Schemas (second level - logical groupings) 
        └── Objects (third level - tables, views, volumes, functions, models)
```

:::image type="content" source="../media/unity-catalog-object-model.png" alt-text="Unity Catalog object hierarchy diagram showing metastore at top, connected to catalog, then schema, then the five object types: Table, View, Volume, and Function including models." lightbox="../media/unity-catalog-object-model.png":::

## Navigate the hierarchy levels

Unity Catalog organizes everything through three main levels: **Catalogs**, **Schemas**, and **Objects**.

**Catalogs** are the topmost containers for data objects inside your metastore. Use catalogs to separate, for example:

- **Environments**: `dev`, `staging`, `production`
- **Departments**: `finance`, `marketing`, `engineering`  
- **Projects**: `customer_analytics`, `fraud_detection`

---

**Schemas** work like traditional databases. They group related data objects together. Within a production catalog, you might have:

- `production.sales` (all sales-related tables and views)
- `production.customers` (customer data objects)
- `production.analytics` (analytical views and summaries)

---

**Objects** are the data assets Unity Catalog governs within schemas:

- **Tables**: Store structured data in rows and columns. There are two types of tables: **managed** (Unity Catalog automatically handles both metadata and data files in its default Azure Data Lake Storage location) and **external** (you choose where data files are stored - different Azure Storage accounts, other cloud providers, or existing data locations)
- **Views**: Stored SQL queries that run when accessed, pointing to underlying tables and dynamically returning results. Views are read-only and useful for applying consistent business logic or exposing filtered data
- **Volumes**: Store non-tabular data like images, documents, JSON files, or other unstructured content. You can query this data directly and like tables, volumes can be managed or external
- **Functions**: User-defined functions that let you create reusable custom logic for SQL queries. Unity Catalog supports SQL functions (recommended for better optimization) that you can share across teams and projects
- **Models**: Machine learning models from MLflow, extending governance beyond data to AI assets with model versioning, access control, and usage tracking

## Work with the three-level namespace

Unity Catalog supports standard SQL context management with `USE CATALOG` and `USE SCHEMA` commands. You can reference objects using full paths or rely on your current context for shorter references:

```sql
-- Set your working context
USE CATALOG production;
USE SCHEMA sales;

-- Now reference tables directly
SELECT * FROM customer_data;

-- Or use full three-level paths from anywhere
SELECT * FROM production.sales.customer_data;
```

The key architectural advantage: this hierarchy enables **unified governance** with privilege inheritance. Set data access policies once at the catalog or schema level, and Unity Catalog automatically applies them to all current and future objects within that container:

```sql
-- Grant SELECT on entire catalog - applies to all schemas and tables
GRANT SELECT ON CATALOG production TO `sales-team`;

-- Grant on schema level - applies to all tables in that schema
GRANT SELECT ON SCHEMA production.finance TO `finance-users`;
```

This inheritance model ensures consistent security across all connected workspaces in your Azure region without requiring individual permissions on every table, view, or function.
