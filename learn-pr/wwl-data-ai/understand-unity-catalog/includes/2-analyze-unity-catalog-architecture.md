# Analyze Unity Catalog architecture

## Understand the workspace governance challenge

Understanding Unity Catalog's architecture starts with understanding the problem it solves. In Azure Databricks, organizations typically create **multiple workspaces** to achieve isolation:

- **Development, staging, and production environments**
- **Different business units or teams**  
- **Resource limitations** (each workspace has limits)

**The problem:** Each workspace traditionally had its **own separate governance**. According to Microsoft's documentation: "Unity Catalog provides administrators a unified location to assign permissions... Privileges and metastores are shared across workspaces, allowing administrators to set secure permissions once... and know that end users only have access to the proper data in any Azure Databricks workspace they enter."

**Without Unity Catalog:**

- Workspace A: Manages its own data permissions
- Workspace B: Manages its own data permissions  
- Workspace C: Manages its own data permissions
- Result: **Fragmented governance** - same user needs different permissions in each workspace

**With Unity Catalog:**

- One **metastore** spans multiple workspaces in a region
- **Single governance layer** manages permissions across all workspaces
- Users get **consistent access** regardless of which workspace they use

### Key architectural insight: Many workspaces, shared data access

According to Microsoft's documentation: "You can share a single metastore across multiple Azure Databricks workspaces in an account. Each linked workspace has the same view of the data in the metastore, and you can manage data access control across workspaces."

This means:

- **Multiple workspaces** can connect to the same metastore
- **Same data** is accessible from all connected workspaces (subject to permissions)
- **Unified permissions** apply across all workspaces in the region
- **Flexible workspace isolation** through workspace-catalog binding when needed

This architectural approach connects directly to the enterprise data challenges discussed in Unit 1, where organizations struggle with scattered data stores and inconsistent governance models.

## Understand the Unity Catalog object model

Unity Catalog uses a **three-level hierarchy** to organize everything: metastore contains catalogs, catalogs contain schemas, and schemas contain your actual data objects. This structure provides the foundation for all governance, security, and organization in your data platform.

:::image type="content" source="../media/unity-catalog-object-model.png" alt-text="Unity Catalog three-level object model showing metastore containing catalogs, which contain schemas, which contain tables, views, volumes, functions, and models":::

Think of this hierarchy using familiar database concepts:

- **Metastore**: The entire database server instance
- **Catalogs**: Individual databases within the server (like separate databases in Oracle or SQL Server)
- **Schemas**: Logical namespaces within each database (similar to Oracle schemas or SQL Server schemas)  
- **Data Objects**: The actual tables, views, functions, and procedures within each schema

## Explore metastore fundamentals

### What makes a metastore special

A **metastore** is your central governance hub - the single source of truth for all metadata, permissions, and access rules. Unlike Databricks' older Hive metastore, Unity Catalog metastores provide enterprise-grade governance that spans multiple workspaces, clouds, and teams.

**Key insight**: A metastore is a *logical container*, not a physical one. This design makes it incredibly flexible for large organizations with complex data needs.

### Two-part architecture

Every Unity Catalog metastore works through two connected components:

### Control plane (The "brain")

- Stores metadata: table schemas, column definitions, data types
- Contains all security rules and permissions
- Tracks audit logs and lineage information
- Lives in a specific cloud region for compliance

### Data plane (The "storage")

- Contains your actual data files in cloud storage
- Must be in the same region as the control plane
- In Azure: typically Azure Data Lake Storage Gen2 containers

This separation allows centralized governance while keeping your data distributed where you need it.

## Navigate the three-level namespace

Unity Catalog's most important innovation is extending traditional SQL from two levels to three levels. This addresses the fundamental challenge of organizing data across complex enterprise environments.

### Understanding the namespace evolution

**Without Unity Catalog:**

- Format: `<schema-name>.<table-name>`
- Example: `sales_data.customers`

**With Unity Catalog:**

- Format: `<catalog-name>.<schema-name>.<table-name>`
- Example: `production.sales_data.customers`

According to Microsoft documentation, "Unity Catalog introduces this third level to provide improved data segregation capabilities."

### Practical namespace benefits

The three-level structure enables organizations to unify data stores that were previously scattered across different systems. Instead of managing separate governance models for each data platform, Unity Catalog provides a **single interface** to manage permissions and policies across all your data assets.

### Real data stores Unity Catalog unifies

According to Microsoft's documentation, Unity Catalog integrates with these specific data sources:

**Database systems via Lakehouse Federation:**

- PostgreSQL, MySQL, Oracle
- Microsoft SQL Server, Azure Synapse Analytics
- Amazon Redshift, Google BigQuery
- Snowflake, Teradata, Salesforce Data Cloud

**Cloud storage systems:**

- Azure Data Lake Storage Gen2
- External storage locations with proper credentials

**Other Databricks environments:**

- Legacy Hive metastores (appears as `hive_metastore` catalog)
- Other Databricks workspaces and metastores
- Shared data through Delta Sharing protocol

**Example scenarios:**

- **Cross-environment consistency**: Reference the same logical table across `dev.sales.customers`, `staging.sales.customers`, and `production.sales.customers`
- **Multi-system queries**: Join lakehouse data with live PostgreSQL tables: `SELECT * FROM production.sales.customers JOIN postgres_catalog.crm.contacts`
- **Unified governance**: Apply the same access controls to data whether it lives in your lakehouse, Snowflake, or Azure Synapse

## Master the object hierarchy

Let's walk through each level of the hierarchy using practical examples to understand what goes where and why.

### Level 1: Catalogs (Your main containers)

Catalogs are your primary organizational tool. Think of them as different departments or environments in your data architecture.

**Common catalog patterns:**

- **Environment-based**: `dev`, `staging`, `production`
- **Department-based**: `marketing`, `sales`, `finance`, `engineering`
- **Project-based**: `customer_analytics`, `fraud_detection`, `recommendation_engine`

**Example decision framework**: "Should our marketing team have access to production financial data?" If the answer is no, put them in separate catalogs.

### Level 2: Schemas (Familiar database logic)

Within each catalog, schemas work exactly like traditional databases - they group related tables and views logically.

**Example within a production catalog:**

- `production.sales_data` (contains sales tables and views)
- `production.customer_data` (contains customer-related objects)
- `production.analytics` (contains analytical views and summary tables)

**Pro tip**: Use schemas to group data by business domain or data source, not by technical considerations like file format.

### Level 3: Data objects (Your actual assets)

Within schemas, Unity Catalog governs multiple types of objects. Here are the key ones:

#### Tables (Your structured data)

Unity Catalog offers two table types with a crucial difference:

**Managed Tables** (Recommended for most use cases):

- Unity Catalog stores the data files
- Dropping the table deletes both metadata AND data
- Simpler to manage and secure
- Best for most use cases

**External Tables** (When you need flexibility):

- You store data files in your own cloud storage
- Dropping the table only removes metadata (data files remain)
- More complex but gives you storage flexibility
- Good when you need data accessible from multiple systems

#### Other critical objects

**Views**: Saved SQL queries that execute when accessed - perfect for reusable analytical logic without storing duplicate data

**Volumes**: Containers for unstructured data (files, images, documents) following the same managed/external pattern as tables

**Functions**: Custom SQL or Python functions that you can reuse across queries - great for standardizing business logic

**Models**: Machine learning models from MLflow, demonstrating how Unity Catalog governs AI assets alongside data

## Make the managed vs external decision

This architectural choice impacts everything from security to performance. Here's a practical decision framework:

**Choose Managed when:**

- You want Unity Catalog to handle everything
- Security and governance are top priorities
- You don't need external system access to the data
- You're building new data pipelines

**Choose External when:**

- You need data accessible from non-Databricks systems
- You have existing data lakes to integrate
- You want control over storage costs and locations
- You're migrating from existing systems gradually

## Apply architectural best practices

### Start with managed objects

Prioritize managed tables and volumes whenever possible. They simplify governance, reduce operational complexity, and provide the best integration with Unity Catalog's security and auditing features.

### Design for your organization

Structure catalogs and schemas to reflect how your business actually works - organizational boundaries, compliance requirements, or project structures. This makes permissions logical and data discovery intuitive.

### Plan Azure integration thoughtfully

In Azure environments, Unity Catalog integrates directly with Azure Data Lake Storage Gen2. When external storage is necessary, Unity Catalog uses storage credentials and external locations to maintain security while providing flexible access to existing Azure storage infrastructure.

This integration respects Azure's security model while extending governance capabilities across your entire data estate.

## Summary

Unity Catalog's three-level hierarchy (metastore â†’ catalogs â†’ schemas â†’ objects) provides a foundation for enterprise data governance that scales with your organization. The architecture separates logical organization from physical storage, enabling flexible data management that grows with your needs.

Understanding this hierarchy is crucial because it determines how you'll organize data, set permissions, and enable discovery across your entire data platform. In the next unit, you'll explore how Unity Catalog extends this governance model to external storage systems and federation scenarios.
 
 

