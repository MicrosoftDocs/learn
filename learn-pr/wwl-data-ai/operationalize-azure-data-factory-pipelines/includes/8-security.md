Securing an Azure Data Factory deployment involves controlling who can access your factory, how the factory authenticates to other services, and how data at rest is protected. Understanding these security capabilities helps you design pipelines that meet your organization's compliance requirements.

## Control access with role-based access control

Azure Data Factory uses Azure role-based access control (RBAC) to manage who can do what in a factory. Rather than granting broad permissions, assign the minimum level of access each team member needs.

The built-in roles most relevant to Data Factory are:

| Role | Scope | What it allows |
|---|---|---|
| **Data Factory Contributor** | Resource group or factory | Create and manage all Data Factory resources; publish changes to the service |
| **Reader** | Factory | View factory resources and monitor runs; can't make changes or publish |
| **Contributor** | Factory | Edit factory resources but can't access the **Publish** and **Publish All** buttons in the studio |

For finer-grained control, you can create custom roles. For example, you might create a role that lets users test linked service connections and preview data without being able to modify pipelines or publish changes.

> [!TIP]
> When using Git integration, restrict who can publish to the Data Factory service by granting the **Data Factory Contributor** role only to a small group. All other contributors can work in Git branches and submit pull requests without being able to push directly to the live factory.

## Authenticate to other services with managed identities

When a Data Factory pipeline reads from Azure Storage, writes to Azure SQL Database, or retrieves a secret from Key Vault, it needs credentials. Storing credentials directly in linked service definitions creates a security risk. Instead, use managed identities so the factory authenticates without any stored secret.

Azure Data Factory supports two types of managed identity:

- **System-assigned managed identity**: Azure automatically creates and manages an identity tied to the lifetime of the factory. When the factory is deleted, the identity is deleted. This is the simplest option for most scenarios.
- **User-assigned managed identity**: You create and manage the identity independently of any specific factory. Use this when you need the same identity shared across multiple Azure resources, or when you need the identity to persist independently of the factory.

To use a managed identity, grant it an appropriate role on the target resource. For example, to allow the factory to read from an Azure Data Lake Storage account, assign the **Storage Blob Data Reader** role to the factory's managed identity on that storage account. No connection strings or passwords are stored anywhere in the factory.

## Protect secrets with Azure Key Vault

For services that don't support managed identity authentication, store connection strings and passwords in Azure Key Vault rather than in Data Factory linked service definitions. Data Factory retrieves secrets from Key Vault at runtime using the factory's managed identity, so no credentials appear in the factory's Git repository or ARM templates.

> [!IMPORTANT]
> For security reasons, Data Factory doesn't store linked service secrets in Git. Any changes to a linked service that contains a secret (such as a password or connection string) are published immediately and directly to the Data Factory service, bypassing the Git collaboration workflow.

When setting up Key Vault integration for CI/CD pipelines across multiple environments, use a separate key vault for each environment (development, test, production). Keep the secret **names** the same across vaults, and only change the key vault name as a CI/CD parameter. This approach avoids parameterizing individual connection strings while still isolating environment credentials.

## Encrypt factory metadata with customer-managed keys

By default, Azure Data Factory encrypts factory metadata using Microsoft-managed keys. If your organization requires control over the encryption key lifecycle—for example, to meet regulatory requirements—you can configure **customer-managed keys** (CMK) stored in Azure Key Vault.

When CMK is enabled, Data Factory uses the factory's managed identity to authenticate to Key Vault and retrieve the key for encryption and decryption operations. The key vault must have **Soft Delete** and **Purge Protection** enabled to prevent accidental key deletion.

CMK can be configured during factory creation in the Azure portal, or after creation from the Data Factory studio.

## Apply the principle of least privilege

Across all security controls, apply least privilege consistently:

- Assign built-in RBAC roles at the narrowest scope possible (factory level, not subscription level) and review role assignments regularly.
- Grant managed identities only the specific permissions they need on downstream resources. Avoid assigning broad roles such as **Owner** or **Contributor** on storage accounts or databases.
- Use separate Key Vault instances per environment to prevent production secrets from being accessible in development environments.
- Audit activity logs regularly using Azure Monitor to detect unexpected access patterns.

For more information on roles and permissions in Azure Data Factory, see [Roles and permissions for Azure Data Factory](/azure/data-factory/concepts-roles-permissions).
