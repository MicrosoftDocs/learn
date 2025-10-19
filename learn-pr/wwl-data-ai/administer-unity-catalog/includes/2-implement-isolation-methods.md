# Understand Unity Catalog isolation methods

## Introduction

Unity Catalog helps organizations implement secure and scalable data governance across multiple workspaces.  
As your platform grows, different teams, regions, or projects often need their own administrative boundaries, compute environments, and storage locations.

Isolation in Unity Catalog provides the flexibility to meet these requirements while maintaining consistent governance.  
In this unit, you’ll learn how Unity Catalog enforces isolation at the **administrative**, **workspace**, and **storage** levels, and how to combine these layers for effective delegation and control.

---

## Administrative roles and isolation boundaries

Unity Catalog separates governance responsibilities through two main administrative roles:

| **Role** | **Responsibilities** | **Scope** |
|-----------|----------------------|------------|
| **Account Admin** | Manages workspaces, users, and Unity Catalog metastores. | Entire Databricks account |
| **Metastore Admin** | Manages catalogs, schemas, and data objects within a single metastore. | Specific metastore |

Administrative isolation ensures that no single person or workspace has unrestricted access to all governed data.  
Instead, privileges are assigned where needed, promoting accountability and compliance.

> 🟦 **Consider adding a UI image:** Screenshot of **Account Console → Data → Metastore settings** view, showing admin assignments and roles.

---

## Explore isolation boundary types

Unity Catalog implements isolation at three key boundaries.  
Each boundary provides a different level of control and serves a different purpose.

---

### 1. Administrative isolation (Delegation of management)

Administrative isolation mean that data is managed by designated administrators or teams based on ownership or business unit.

**Example:**

A single Unity Catalog metastore can contain multiple catalogs—each managed by a different business unit admin. For example, a Finance Admin manages the `finance_data` catalog, while the HR Admin manages the `hr_data` catalog.

To conceptualize this visually, in the following diagram, in the top section entitled 'Delegation of Management', Admin A manages Catalog 1 and Admin B manages Catalog 2.
 
:::image type="content" source="../media/isolation-features.png" alt-text="Diagram showing Unity Catalog isolation features including administrative roles, workspace boundaries, and storage locations." lightbox="../media/isolation-features.png":::

### 2. Workspace-to-catalog binding

Workspaces define the **execution environment**—clusters, notebooks, and policies—while catalogs define **logical data domains**. Unity Catalog lets you bind one or more workspaces to one or more catalogs within the same metastore. You do this to keep sensitive or production catalogs visible only in the right workspace, preventing accidental access or changes from other environments.

**To implement workspace-to-catalog binding:** 

1. In the Databricks workspace, open **Data → Catalogs**.  
2. Assign workspace access to the desired catalog using Unity Catalog permissions (for example, `USE CATALOG` and `SELECT` privileges).  
3. Verify access through SQL Editor or notebook queries using the fully qualified name:

    ```sql
    SELECT * FROM finance_data.hr_salaries;
    ```

> 🟩 **Insert Image:** “Unity Catalog Isolation features” *(middle section showing Workspace to catalog binding).*  
> 🟦 **Optional UI image:** Screenshot of the catalog permissions tab in the workspace.

---

### 3. Storage isolation

You can isolate data physically by assigning different **Azure Data Lake Storage Gen2 (ADLS Gen2)** locations for each catalog or schema.  
Each location represents a unique path in Azure storage, such as:

abfss://finance@adlsaccount.dfs.core.windows.net/
abfss://marketing@adlsaccount.dfs.core.windows.net/


**Implementation steps:**

1. In the metastore, configure **Managed Storage** for default data paths.  
2. Define **External Locations** with separate credentials for catalogs that require isolation.  
3. Use catalog-level privileges to control who can create or access tables in each location.

> 🖼️ **Insert Image:** “Unity Catalog Isolation features” *(bottom section showing Storage isolation).*  
> 🟦 **Optional UI image:** Example of creating an external location in the Databricks UI.

---

## Combine isolation boundaries for layered control

Organizations often use multiple isolation methods together to balance security, manageability, and data sharing.

> 🖼️ **Insert Image:** “Unity Catalog Isolation combined” *(shows all three working together).*

**Example architecture:**

- **Business Unit A:** Has its own admin, workspace, and storage location.  
- **Business Unit B:** Shares the same metastore but uses separate catalogs and ADLS Gen2 containers.  
- **Business Unit C:** Operates independently for compliance reasons.

This pattern provides:

- **Delegated management:** Each admin manages only their catalog.  
- **Workspace isolation:** Teams work in separate environments.  
- **Storage separation:** Data is stored in distinct containers or regions.

---

## Summary

Unity Catalog isolation enables you to control:

- **Who manages data** – through delegated administrative roles.  
- **Where data is used** – by binding workspaces to specific catalogs.  
- **Where data resides** – using separate ADLS Gen2 storage paths.

Combining these boundaries lets you design a secure, compliant, and scalable data platform that supports both collaboration and independence across teams.

---

### Recommended image order

1. **Unity Catalog Isolation features** – introduces each isolation type.  
2. **Unity Catalog Isolation combined** – illustrates how all boundaries work together.

### Recommended optional UI screenshots

- Metastore admin view (showing role assignments).  
- Catalog permissions view (workspace-to-catalog binding).  
- External location setup (ADLS Gen2 configuration).
