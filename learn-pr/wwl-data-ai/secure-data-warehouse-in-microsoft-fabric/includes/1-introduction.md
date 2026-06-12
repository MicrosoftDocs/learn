When sensitive data lives in a Fabric warehouse, a single access control isn't enough. Different users need different levels of visibility — some should see a table but not a column; others should see only their own rows. The following layers give you that precision, and this module focuses on the data protection layer: dynamic data masking, row-level security, column-level security, and SQL granular permissions.

## Security layers in a Fabric warehouse

- **Workspace roles** – Admin, Member, Contributor, and Viewer roles control who can access and manage items within a workspace. These roles are your first line of access control before a user ever touches a warehouse.

- **Item permissions** – Individual warehouses can have permissions granted directly to them. Item permissions let you share a warehouse for downstream use without granting broad workspace access.

- **Data protection** – T-SQL commands give you fine-grained control at the object, column, and row level — without requiring application changes. This is the focus of this module.

- **Audit logs** – SQL audit logs capture user activity, including logins, queries, and permission changes. Audit data is available through Microsoft Purview and PowerShell, with configurable event categories and retention policies. Audit logs are essential for compliance reporting and detecting unauthorized access.

- **Encryption** – All warehouse data is encrypted at rest by default using Microsoft-managed keys. For greater control, configure customer-managed keys (CMK) through Azure Key Vault.
