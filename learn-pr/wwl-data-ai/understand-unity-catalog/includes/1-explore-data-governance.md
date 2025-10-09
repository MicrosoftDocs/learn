# Data Governance in Azure Databricks

Modern enterprises manage data across many systems: data lakes, warehouses, ML pipelines, and BI dashboards. Each system often comes with its own governance rules and permissions model, which creates serious challenges.  

For example, storage systems like Azure Data Lake provide only file- and folder-level permissions. Warehouses allow table or column-level controls, but their models differ from the lake. Analytics tools add their own workspace-level permissions. The result is duplication, inconsistent policies, and silos. A data scientist might be able to query a table, but not access the underlying files; an analyst might see conflicting results because data was copied between systems and fell out of sync.  

This is the governance problem that Unity Catalog was designed to solve.  

## What Is Data Governance?

Data governance is the discipline of ensuring that data is secure, trustworthy, and usable while meeting compliance requirements. It ensures data is available to the right people and protected from unauthorized use.  

In practice, governance involves four major capabilities:

- **Access control**: defining who can do what with which datasets.  
- **Auditing**: tracking how data was used, by whom, and when.  
- **Lineage**: tracing how data flows and transforms through systems.  
- **Discovery**: making datasets searchable and understandable, so duplication is minimized.  

## Explore Unity Catalog's governance capabilities

Unity Catalog is the central governance layer in Azure Databricks. Instead of managing separate permissions for each workspace or tool, Unity Catalog provides a single, consistent model that spans all workspaces in a region.  

### Unified permission model  
Unity Catalog uses a familiar ANSI SQL `GRANT`/`REVOKE` syntax for access control. Policies can be defined once and applied consistently across data, AI models, dashboards, and files. Permissions cascade down Unity Catalog’s object hierarchy:

Metastore → Catalog → Schema → Objects (tables, views, functions, models, volumes)


### Fine-grained security  
Permissions can be applied at the catalog, schema, table, view, or column level. Row-level access control can also be enforced using dynamic views or policy-based filters. These mechanisms allow administrators to restrict data visibility so that users only see the rows they are authorized to access, without restructuring the underlying data.  

### Centralized management  
All securable objects are managed in one place, including tables, views, models, volumes, external locations, and storage credentials. This ensures governance applies consistently, whether data is in ADLS, registered as a Delta table, or coming from an external database.  

### Built-in auditing and lineage  
Unity Catalog automatically logs access events into system tables, making it easy to audit who accessed which datasets. It also captures lineage across notebooks, SQL queries, jobs, and dashboards, so teams can trace transformations and build trust in the results.  

### Federated governance  
Unity Catalog extends governance beyond Databricks-managed data by supporting connections to external systems through **connections** and **foreign catalogs**. This allows organizations to apply the same access controls and auditing, even when data stays in place outside of Databricks.  
