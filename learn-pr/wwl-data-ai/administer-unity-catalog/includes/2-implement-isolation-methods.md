Unity Catalog helps your organization implement secure and scalable data governance across multiple workspaces. As your platform grows, different teams, regions, or projects often need their own administrative boundaries, compute environments, and storage locations. Isolation in Unity Catalog provides the flexibility to meet these requirements while maintaining consistent governance.

In this unit, you’ll learn how Unity Catalog enforces isolation at the administrative, workspace, and storage levels, and how to combine these layers for effective delegation and control.

## Administrative roles and isolation boundaries

Unity Catalog separates governance responsibilities through two main administrative roles:

| **Role** | **Responsibilities** | **Scope** |
|-----------|----------------------|------------|
| **Account Admin** | Manage the Azure Databricks account, including enabling Unity Catalog, user provisioning, and account-level identity management. | Entire Databricks account |
| **Metastore Admin** | Manage privileges and ownership for all securable objects within a Unity Catalog metastore, such as who can create catalogs or query a table. | Specific metastore |

Administrative isolation ensures that no single person or workspace has unrestricted access to all governed data. Instead, privileges are assigned where needed, promoting accountability and compliance.

## Explore isolation boundary types

Unity Catalog implements these isolation controls through three key boundaries, each shown in a different section of the following diagram.

:::image type="content" source="../media/isolation-features.png" alt-text="Diagram showing Unity Catalog isolation features including administrative roles, workspace boundaries, and storage locations." lightbox="../media/isolation-features.png":::

Let's explore each isolation boundary:

### 1. Delegation of management (admin isolation)

Administrative isolation controls **who manages data** by designated administrators or teams based on ownership or business unit.

A single Unity Catalog metastore can contain multiple catalogs—each managed by a different business unit admin. For example, a Finance Admin manages the `finance_data` catalog, while the HR Admin manages the `hr_data` catalog.

### 2. Workspace-to-catalog binding

Workspace-to-catalog binding **controls where data is used** by restricting catalog access to specific workspaces. When you bind a catalog to designated workspaces, Unity Catalog makes that catalog visible and accessible only from those workspaces. Catalogs not bound to a workspace simply don't appear in that workspace's catalog explorer, and any queries attempting to access them will fail.

**To implement workspace-to-catalog binding:**

1. In the Databricks workspace, click **Catalog**.
2. In the **Catalog** pane, select the catalog you want to bind.
3. On the **Workspaces** tab, clear the **All workspaces have access** checkbox.
4. Click **Assign to workspaces** and select the specific workspaces that should have access.

### 3. Storage isolation

Storage isolation controls **where data resides** by assigning different **Azure Data Lake Storage Gen2 (ADLS Gen2)** locations for each catalog or schema. Each location represents a unique path in Azure storage, such as:

abfss://finance@adlsaccount.dfs.core.windows.net/
abfss://marketing@adlsaccount.dfs.core.windows.net/

To configure storage isolation, you establish the connection between Unity Catalog and your Azure storage containers, then assign different containers as the default storage for different catalogs. This ensures that when users create tables in the `finance_data` catalog, the data automatically goes to the finance container, while tables in the `marketing_data` catalog go to the marketing container. Unity Catalog handles the routing based on your configuration, providing seamless isolation without users needing to specify storage paths manually.

## Combine isolation boundaries for layered control

Most organizations use all three isolation controls together. For example, you might want the Finance team to manage their own data, access it only from their production workspace, and store it in a dedicated container for compliance.

When you combine all three boundaries, they address different governance requirements while working together to provide complete control over your data platform.

:::image type="content" source="../media/isolation-combined.png" alt-text="Diagram showing Unity Catalog isolation boundaries working together with business units controlling administrative access, workspace access, and storage locations." lightbox="../media/isolation-combined.png":::

The diagram illustrates how each business unit operates with complete isolation:

- **Business Unit A:** Admin A controls who manages Catalog 1 (admin isolation), Catalog 1 is accessible only from Workspace A (workspace isolation), and data resides in Storage Location X (storage isolation).
- **Business Unit B:** Admin B controls who manages Catalog 2, Catalog 2 is accessible only from Workspace B, and data resides in Storage Location Y.
- **Business Unit C:** Admin C controls who manages Catalog 3, Catalog 3 is also accessible from Workspace B, but data resides in separate Storage Location Z.