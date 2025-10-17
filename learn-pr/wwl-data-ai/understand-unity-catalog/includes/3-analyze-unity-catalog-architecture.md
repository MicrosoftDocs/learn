A helpful way to think about Unity Catalog's architecture is like an address system. To reliably locate something, you use country, state, city, and street. Unity Catalog applies a similar idea with a **three-level namespace** that tells you exactly where a data object lives and how it's governed: `catalog.schema.object`

Above this structure sits the **metastore**, which isn't part of the namespace itself but defines the **Azure regional governance boundary** that contains it.

Each Azure Databricks account has one metastore per Azure region, ensuring that governance policies remain consistent and data residency rules are respected.

## Understand metastore fundamentals

Before Unity Catalog, each workspace in Databricks had its own Hive metastore, and permissions had to be managed separately.
With Unity Catalog, workspaces in the same region share a single metastore. This design centralizes governance while maintaining compliance with regional boundaries—for example, all **East US** workspaces share one metastore, while all **West Europe** workspaces share another.

The metastore serves four key roles:

- **Regional boundary** – Ensures data stays governed within a single Azure region.
- **Workspace connector** – Allows multiple workspaces to share the same governance policies.
- **Metadata store** – Tracks schemas, tables, views, functions, models, permissions, and lineage.
- **Storage coordinator** – Defines a default location for managed tables and volumes.

For backward compatibility, each workspace still exposes its old Hive metastore as a special catalog called **`hive_metastore`**.

## What's inside the metastore

You can think of the metastore as a **logical construct** for organizing metadata and linking it to storage—not as a physical container.

If we "opened it up," we'd see two main parts:

- **Metadata in the control plane** – Information about objects, such as table names, columns, and permissions, is stored in the control plane. This is what ties a metastore to a specific Azure region.
- **Data in the data plane** – The actual files and tables governed by the metastore reside in an Azure Data Lake Storage container in the same region.

The metastore doesn't hold your data directly. Instead, it acts like a **reference card**—it knows what the data is, where it lives, and who is allowed to use it.

The metastore sits at the regional level, with multiple Azure Databricks workspaces connected to it. Each workspace accesses the same governed data through the metastore, while the underlying data files remain in the associated cloud storage container within that same region. This architecture enables centralized governance while maintaining data residency compliance.

:::image type="content" source="../media/metastore.png" alt-text="Diagram showing Unity Catalog metastore architecture." lightbox="../media/metastore.png":::

The diagram shows how workspaces are assigned to the metastore, the Azure Data Lake Storage Gen 2 storage location where managed data is stored, and the Azure region that defines the governance boundary.

## Explore the three-level namespace

Traditional SQL systems use a two-level namespace to address tables within schemas. Unity Catalog introduces a **third level**, adding **catalogs** above schemas.

A full Unity Catalog reference looks like this:`catalog.schema.object`.

The hierarchy can be visualized like this:

Metastore (region-level governance boundary)  
└─ Catalogs  
&nbsp;&nbsp;&nbsp;&nbsp;└─ Schemas  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ Objects (tables, views, volumes, functions, models)

:::image type="content" source="../media/namespace.png" alt-text="Diagram showing Unity Catalog's three-level namespace hierarchy with metastore at the top containing catalogs, which contain schemas, which contain objects like tables, views, volumes, functions, and models." lightbox="../media/namespace.png":::

This screenshot from the Catalog Explorer shows the three-level namespace in action: the `production` catalog contains the `customers` schema, which contains the `customer_data` table object and its columns.

## Examine each level

### Catalogs

Catalogs are the highest-level containers inside a metastore.
They're often used to separate:

- Environments (for example, `dev`, `staging`, `prod`)
- Departments (for example, `finance`, `marketing`)
- Projects (for example, `fraud_detection`, `customer_analytics`)

### Schemas

Schemas are the next level down and act like databases in traditional SQL systems.
They group related assets together—for example:

- `production.sales` might contain all sales tables.
- `production.customers` might store customer-related data.

### Objects

Objects are the assets inside schemas. Unity Catalog governs:

- **Tables**:  Structured data. Tables can be managed or external.
  - **Managed tables:** Data files are stored in the cloud storage container associated with the metastore. Dropping a managed table deletes both the metadata and the data files.
  - **External tables:** Data files remain in your own cloud storage location. Dropping an external table deletes only the metadata and the data files remain intact.
- **Views**: Saved SQL queries that return dynamic results.
- **Volumes**: For nontabular files like JSON, images, or documents (managed or external).
- **Functions**: User-defined SQL functions to reuse logic.
- **Models**: MLflow machine learning models with versioning and access control.

Each layer refines governance scope: catalogs for broad domains or boundaries, schemas for logical groupings, and objects for the actual governed assets.

## Work with Unity Catalog

You can set your working context by choosing a scope:

```sql
USE CATALOG production;
USE SCHEMA sales;

-- Short reference
SELECT * FROM customer_data;

-- Full path
SELECT * FROM production.sales.customer_data;
```

## Inheritance and security

Unity Catalog uses a hierarchical privilege model. When you grant a privilege on a catalog or schema, it automatically applies to all current and future objects within that container:

```sql
-- Grants apply to everything in the catalog
GRANT SELECT ON CATALOG production TO `sales_team`;

-- Or to everything in a schema
GRANT SELECT ON SCHEMA production.finance TO `finance_users`;
```

This inheritance model means you can manage permissions efficiently at higher levels rather than object by object.
