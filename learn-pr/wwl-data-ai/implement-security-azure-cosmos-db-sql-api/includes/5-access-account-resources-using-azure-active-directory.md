Azure Cosmos DB exposes a built-in role-based access control (RBAC) system that lets you:

- Authenticate your data requests with an Azure Active Directory (Azure AD) identity.
- Authorize your data requests with a fine-grained, role-based permission model.

To set up these roles, we'll review the permission model, role definitions ad role assignments RBAC concepts in more detail. Azure portal support for role management is'not available yet.

:::image type="content" source="../media/5-role-assignment.png" alt-text="Diagram that shows the role-based access control options for data access.":::

## Permission model

The permission model covers reading and writing data operations against a database. It won't cover management resource operations like creating, replacing, deleting databases, containers, throughput, Stored Procedures, triggers, or User-defined functions.

The permission model will allow you to grant or deny the following actions:

| **Name** | **Corresponding database operation(s)** |
| :--- | :--- |
| `Microsoft.DocumentDB/databaseAccounts/readMetadata` | Read account metadata. See Metadata requests for details. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/create` | Create a new item. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read` | Read an individual item by its ID and partition key (point-read). |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/replace` | Replace an existing item. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/upsert` | "Upsert" an item, which means create it if it doesn't exist, or replace it if it exists. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/delete` | Delete an item. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery` |Execute a SQL query. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed` | Read from the container's change feed. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeStoredProcedure` | Execute a stored procedure. |
| `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/manageConflicts` | Manage conflicts for multi-write region accounts (that is, list and delete items from the conflict feed). |

Wildcards are also supported for both the container and item levels. 
- `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*`
- `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*`

### Metadata requests

Metadata requests don't return any data stored inside your Azure Cosmos DB account. Metadata requests are issued by the SDKs as read-only request during initialization and to serve specific data requests. They could return information like the partition key of a container, regions the account is in or a list of a container's partitions.

Metadata requests are covered by the action:

- `Microsoft.DocumentDB/databaseAccounts/readMetadata`

They can be assigned at the account, database, or container scope. The actions allowed are:

| **Scope** | **Requests allowed by the action** |
| :--- | :--- |
| Account | - Listing the databases under the account <br/> - For each database under the account, the allowed actions at the database scope |
| Database | - Reading database metadata <br/> - Listing the containers under the database <br/> - For each container under the database, the allowed actions at the container scope |
| Container	| - Reading container metadata <br/> - Listing physical partitions under the container <br/> - Resolving the address of each physical partition |

## Role definitions

Role definitions, contains a list of allowed actions.  Azure Cosmos DB can use either built-in or custom role definitions, let's review those definitions further.

### Built-in role definitions

Azure Cosmos DB exposes the following two built-in roles definitions:

| **ID** | **Name** | **Included actions** |
| :---| :--- | :--- |
| 00000000-0000-0000-0000-000000000001 | Cosmos DB Built-in Data Reader | - Microsoft.DocumentDB/databaseAccounts/readMetadata <br/> - Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/read <br/> -Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/executeQuery <br/> - Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/readChangeFeed |
| 00000000-0000-0000-0000-000000000002 | Cosmos DB Built-in Data Contributor | -Microsoft.DocumentDB/databaseAccounts/readMetadata <br/> - Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/* <br/> - Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/* |

### Custom Role definition

You can define custom role definition using Azure PowerShell, Azure CLI, or Azure Resource Manager templates. When creating a custom role definition, you need to provide:

- The name of your Azure Cosmos DB account.
- The resource group containing your account.
- The type of the role definition: `CustomRole`.
- The name of the role definition.
- A list of actions that you want the role to allow.
- One or multiple scope(s) that the role definition can be assigned at; supported scopes are:
    - `/` (account-level),
    - `/dbs/<database-name>` (database-level),
    - `/dbs/<database-name>/colls/<container-name>` (container-level).

## Role assignments

The final component to define our data plane role base access control is our Roll Assignment. Role definitions get assigned to specific Azure Active Directory identities through role assignments. This assignment also defines the scope that the role definition applies to, the account, the database, or the container. You can define role assignments using Azure PowerShell, Azure CLI, or Azure Resource Manager templates. When creating a role assignment, you need to provide:

- The name of your Azure Cosmos DB account.
- The resource group containing your account.
- The ID of the role definition to assign.
- The principal ID of the identity that the role definition should be assigned to.
- The scope of the role assignment; supported scopes are:
    - `/` (account-level)
    - `/dbs/<database-name>` (database-level)
    - `/dbs/<database-name>/colls/<container-name>` (container-level)

    The scope must match or be a subscope of one of the role definition's assignable scopes.

## Initialize the SDK with Azure AD

To use Azure Cosmos DB RBAC, you'll no longer pass the primary key. You'll pass an instance of a `TokenCredential` class. This instance will provide the Azure Cosmos DB SDK the context to fetch the needed Azure Active Directory token for of the identity you'll use. Your `TokenCredential`instance must resolve to the identity (principal ID) that you've assigned your roles to. In this example, a service principal is used with a `ClientSecretCredential` instance.

```C#
TokenCredential servicePrincipal = new ClientSecretCredential(
    "<azure-ad-tenant-id>",
    "<client-application-id>",
    "<client-application-secret>");
CosmosClient client = new CosmosClient("<account-endpoint>", servicePrincipal);
```

## Use data explorer

The data explorer on your Azure Cosmos DB pane doesn't support the Azure Cosmos DB RBAC yet. To use your Azure AD identity when exploring your data, you must use the **Azure Cosmos DB Explorer** instead. When you access the Azure Cosmos DB Explorer with the specific `?feature.enableAadDataPlane=true` query parameter and sign in.

## Audit data requests

When using the Azure Cosmos DB RBAC, diagnostic logs will now get identity and authorization information for each data operation. This information will allow you to retrieve the Azure Active Directory identity for every request sent to your Azure Cosmos DB account. 

The identity and authorization data will also be added to the DataPlaneRequest logs. You should now see the columns `aadPrincipalId_g`and `aadAppliedRoleAssignmentId_g` for the principal ID of Azure Active Directory and the role assignment used respectively.

## Enforcing RBAC as the only authentication method

When using RBAC, you can disable the Azure Cosmos DB account primary and secondary key if you wish to use RBAC exclusively. Disabling the accounts can be done by setting the `disableLocalAuth` to *true* when creating or updating your Azure Cosmos DB account using Azure Resource Manager templates.

## Limits

- You can create up to 100 role definitions and 2,000 role assignments per Azure Cosmos DB account.
- You can only assign role definitions to Azure AD identities belonging to the same Azure AD tenant as your Azure Cosmos DB account.
- Azure AD group resolution isn't currently supported for identities that belong to more than 200 groups.
- The Azure AD token is currently passed as a header with each individual request sent to the Azure Cosmos DB service, increasing the overall payload size.

