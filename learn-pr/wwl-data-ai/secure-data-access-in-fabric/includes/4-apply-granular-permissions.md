Item permissions let you share a lakehouse — but they apply to all the data in it. Suppose the data engineer from the previous unit now only needs to see specific patient records tables, not the entire lakehouse. To limit access to specific tables or folders, apply row-level security, or restrict columns, you need granular permissions. The approach depends on how users access the data.

## Apply granular permissions using T-SQL

T-SQL permissions are the compute permissions for the SQL analytics endpoint. When users query lakehouse data using T-SQL, apply granular permissions using Data Control Language (DCL) commands:

- [GRANT](/sql/t-sql/statements/grant-transact-sql?azure-portal=true)
- [DENY](/sql/t-sql/statements/deny-transact-sql?azure-portal=true)
- [REVOKE](/sql/t-sql/statements/revoke-database-permissions-transact-sql?azure-portal=true)

You can also apply row-level security, column-level security, and dynamic data masking. See:

- [Row-level security](/fabric/data-warehouse/row-level-security?azure-portal=true)
- [Column-level security](/fabric/data-warehouse/column-level-security?azure-portal=true)
- [Dynamic data masking](/fabric/data-warehouse/dynamic-data-masking?azure-portal=true)

## Apply granular permissions using OneLake security

OneLake security uses a role-based access control (RBAC) model. You create security roles that define who can access which tables or folders, what level of access they have (Read or ReadWrite), and optional constraints like row or column filters. OneLake enforces these roles consistently across all Fabric compute engines — Spark, SQL, and OneLake APIs.

Users with **Admin**, **Member**, or **Contributor** workspace roles already have full read and write access to all OneLake data — OneLake security roles don't restrict that access. Use OneLake security roles to grant specific data access to users in the **Viewer** workspace role or with only **Read** item permission, who have no OneLake data access by default. Only workspace **Admin** and **Member** roles can create or modify OneLake security roles.

Each OneLake security role has four components:

- **Data** - The tables or folders that users can access.
- **Permission** - The level of access: **Read** (view data) or **ReadWrite** (view and edit data in specific tables or folders without granting a workspace write role).
- **Members** - The users or groups assigned to the role.
- **Constraints** - Optional row or column filters applied to the data in the role.

To create an OneLake security role:

1. In the lake view of the lakehouse, select **Manage OneLake security** from the ribbon.

:::image type="content" source="../media/manage-onelake-data-access.png" alt-text="Screenshot of the Manage OneLake security button in the Home ribbon of a Fabric lakehouse." lightbox="../media/manage-onelake-data-access.png":::

2. Select **New role**, enter a role name, and choose the permission type (Read or ReadWrite).

:::image type="content" source="../media/new-role-dialog.png" alt-text="Screenshot of the New role dialog showing role name field and permission type selection." lightbox="../media/new-role-dialog.png":::

3. Select the tables or folders to grant access to, then save the role. After creation, you can edit the role to add members and optional row or column constraints.

:::image type="content" source="../media/onelake-role-creation.png" alt-text="Screenshot of OneLake security role data selection screen showing tables and folders." lightbox="../media/onelake-role-creation.png":::

> [!IMPORTANT]
> Every new lakehouse automatically includes a **DefaultReader** role. When you share a lakehouse with the **Read all Apache Spark and subscribe to events** permission, the recipient is added to DefaultReader and gets read access to all data. When you restrict a user to a custom role, also remove them from **DefaultReader** — otherwise they still have full read access through the default role.

For more information, see [OneLake security access control model](/fabric/onelake/security/data-access-control-model?azure-portal=true).
