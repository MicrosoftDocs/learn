<!-- Intentionally no top-level heading (module include file). MD041 suppressed by design. -->
Unity Catalog is Azure Databricks' unified system for organizing, securing, and governing all of your data and AI assets.

A useful way to think about it is like an address system. To reliably locate something, you use country, state, city, and street. Unity Catalog uses a similar idea with a three-level namespace that tells you exactly where a data or AI object lives and how it’s governed:

```sql
catalog.schema.object
```

At the very top is the **metastore**, which defines the governance boundary for a region (one per Azure Databricks account per Azure region). Inside it are **catalogs**, then **schemas**, and finally your governed data and AI assets (tables, views, volumes, functions, and models).

## Why the Metastore Matters

Before Unity Catalog, each workspace in Databricks had its own Hive metastore, and permissions had to be managed separately. 

With Unity Catalog, you get a **shared metastore per Azure region**. This design centralizes governance while still respecting regional data residency rules (for example, all East US workspaces share one metastore, all West Europe workspaces share another).

The metastore plays four key roles:

1. **Regional boundary** – Ensures data stays governed within a single Azure region.
2. **Workspace connector** – Allows multiple workspaces to share the same governance policies.
3. **Metadata store** – Keeps track of schemas, tables, views, functions, models, permissions, and lineage.
4. **Storage coordinator** – Defines a default location for managed tables and volumes.

For backward compatibility, each workspace still exposes its old Hive metastore as a special catalog called `hive_metastore`.

## Exploring the Three-Level Namespace

Traditional SQL environments expose two logical address components: `schema.object`. Unity Catalog inserts a third, higher-order organizational layer so every securable can be fully qualified as:

```sql
catalog.schema.object
```

Visualized, the hierarchy looks like this:

```text
Metastore (region-level container)
└─ Catalogs
  └─ Schemas
    └─ Objects (tables, views, volumes, functions, models)
```

:::image type="content" source="../media/unity-catalog-object-model.png" alt-text="Unity Catalog object model showing metastore, catalogs, schemas, and governed objects" lightbox="../media/unity-catalog-object-model.png":::

That extra catalog level gives you flexibility to segment by domain (finance, marketing), environment (dev, prod), or compliance boundary—while schemas continue to group closely related objects within each domain.

## Breaking Down the Levels

### Catalogs

Catalogs are the highest containers inside a metastore. They're often used to separate:

* Environments (e.g., `dev`, `staging`, `prod`)
* Departments (e.g., `finance`, `marketing`)
* Projects (e.g., `fraud_detection`, `customer_analytics`)

### Schemas

Schemas are the next level down. They work like databases in traditional SQL systems, grouping related assets together.

For example:

* `production.sales` might contain all sales tables.
* `production.customers` might store customer-related data.

### Objects

Objects are the assets inside schemas. Unity Catalog governs:

* **Tables** – Structured data.
  * **Managed**: Unity Catalog (Databricks) handles both metadata and storage.
  * **External**: Metadata in Unity Catalog, but storage in your own location (Azure Data Lake, other cloud storage, etc.).
* **Views** – Saved SQL queries that return dynamic results.
* **Volumes** – For non-tabular files like JSON, images, or documents (managed or external).
* **Functions** – User-defined SQL functions to reuse logic.
* **Models** – MLflow machine learning models with versioning and access control.

Each layer refines governance scope: catalogs for broad domains or boundaries, schemas for logical groupings, and objects for the actual governed assets.

## Working with Unity Catalog

You can set your working context just like moving through folders on your computer:

```sql
USE CATALOG production;
USE SCHEMA sales;

-- Short reference
SELECT * FROM customer_data;

-- Full path
SELECT * FROM production.sales.customer_data;
```

This makes it clear whether you’re working in dev, staging, or prod, and avoids ambiguity across teams.

## Inheritance and Security

One of Unity Catalog’s biggest advantages is **privilege inheritance**. Instead of setting permissions object by object, you assign them once at a higher level and Unity Catalog cascades them down:

```sql
-- Grants apply to everything in the catalog
GRANT SELECT ON CATALOG production TO `sales_team`;

-- Or to everything in a schema
GRANT SELECT ON SCHEMA production.finance TO `finance_users`;
```

This ensures consistent, predictable governance—every workspace attached to the same regional metastore enforces the same rules automatically.

