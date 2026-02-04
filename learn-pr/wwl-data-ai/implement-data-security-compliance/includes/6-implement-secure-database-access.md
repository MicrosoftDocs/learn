Secure database access extends beyond granting permissions to the right users. Modern applications require authentication methods that minimize credential exposure while maintaining operational flexibility. Passwordless authentication using Microsoft Entra ID provides a more secure approach than traditional SQL authentication with usernames and passwords.

Moving to passwordless authentication eliminates the risks associated with password management, including credential theft, password reuse, and the operational burden of rotating secrets. This unit explores how to implement secure, passwordless database access across SQL Server, Azure SQL, and SQL databases in Microsoft Fabric.

## Understand authentication methods

SQL databases support multiple authentication methods, each with different security characteristics. Understanding these options helps you choose the appropriate method for each scenario.

SQL authentication uses a username and password stored in the database. While straightforward to implement, this approach requires managing credentials in application configuration, creates risks if credentials are compromised, and doesn't integrate with enterprise identity systems.

Windows authentication (for on-premises SQL Server) uses Active Directory credentials. Users authenticate to the domain, and SQL Server trusts that authentication. This approach works well for applications running on domain-joined servers.

Microsoft Entra authentication extends identity integration to cloud scenarios. Applications can authenticate using Microsoft Entra ID credentials, managed identities, or service principals. This method works with Azure SQL Database, Azure SQL Managed Instance, SQL Server 2022+, and SQL databases in Microsoft Fabric.

## Configure Microsoft Entra authentication

To use Microsoft Entra authentication with Azure SQL Database, first set a Microsoft Entra administrator for the logical server:

```sql
-- Connect using the Entra admin account, then create database users
CREATE USER [app-service-identity] FROM EXTERNAL PROVIDER;
CREATE USER [developer@contoso.com] FROM EXTERNAL PROVIDER;
CREATE USER [DataAnalystsGroup] FROM EXTERNAL PROVIDER;
```

The `FROM EXTERNAL PROVIDER` clause tells SQL to look up the identity in Microsoft Entra ID. You can create users for individual accounts, managed identities, or Microsoft Entra groups.

Grant permissions to these Entra-based users just like SQL users:

```sql
ALTER ROLE db_datareader ADD MEMBER [developer@contoso.com];
ALTER ROLE db_datawriter ADD MEMBER [app-service-identity];
```

For SQL Server 2022 and later, enable Microsoft Entra authentication through server configuration:

```sql
-- Enable Azure AD authentication on SQL Server 2022
EXEC sp_configure 'external authentication providers', 1;
RECONFIGURE;
```

## Implement managed identity authentication

Managed identities provide the most secure option for Azure-hosted applications. Azure automatically manages the identity lifecycle, and no credentials exist that could be leaked or stolen.

For an Azure App Service or Azure Function connecting to Azure SQL Database, enable the system-assigned managed identity in the Azure portal or through Azure CLI:

```powershell
# Enable managed identity for App Service
az webapp identity assign --name MyWebApp --resource-group MyResourceGroup
```

Create a database user for the managed identity:

```sql
CREATE USER [MyWebApp] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [MyWebApp];
ALTER ROLE db_datawriter ADD MEMBER [MyWebApp];
```

Update your application connection string to use Microsoft Entra authentication:

```
Server=myserver.database.windows.net;Database=mydb;Authentication=Active Directory Managed Identity;
```

For .NET applications using Microsoft.Data.SqlClient:

```csharp
var connectionString = "Server=myserver.database.windows.net;Database=mydb;Authentication=Active Directory Managed Identity;";
using var connection = new SqlConnection(connectionString);
await connection.OpenAsync();
```

User-assigned managed identities work similarly but allow you to share an identity across multiple resources:

```sql
-- Create user for a user-assigned managed identity
CREATE USER [my-shared-identity] FROM EXTERNAL PROVIDER;
```

> [!TIP]
> Use user-assigned managed identities when multiple applications need the same database permissions. This reduces the number of database users to manage and ensures consistent access across related services.

## Configure service principal authentication

Service principals provide identity for non-Azure applications or CI/CD pipelines that need database access. Unlike managed identities, service principals require credential management, but they work from any environment.

Register an application in Microsoft Entra ID to create a service principal, then create a database user:

```sql
CREATE USER [my-cicd-pipeline] FROM EXTERNAL PROVIDER;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO [my-cicd-pipeline];
```

Applications authenticate using client credentials (certificate or secret) to obtain a token, then use that token to connect:

```csharp
var credential = new ClientSecretCredential(tenantId, clientId, clientSecret);
var token = await credential.GetTokenAsync(
    new TokenRequestContext(new[] { "https://database.windows.net/.default" }));

var connection = new SqlConnection(connectionString);
connection.AccessToken = token.Token;
await connection.OpenAsync();
```

> [!IMPORTANT]
> When using client secrets, store them in Azure Key Vault and rotate them regularly. Certificate-based authentication provides stronger security than shared secrets.

## Implement contained database users

Contained database users exist only within the database, without requiring a server-level sign-in. This approach simplifies deployment and supports database portability across servers.

Create a contained user with a password when Microsoft Entra authentication isn't available:

```sql
CREATE USER AppUser WITH PASSWORD = 'ComplexPassword123!';
ALTER ROLE db_datareader ADD MEMBER AppUser;
```

Contained users with passwords still require credential management. Prefer Entra-based contained users when possible:

```sql
-- Contained user backed by Entra identity
CREATE USER [webapp@contoso.com] FROM EXTERNAL PROVIDER;
```

Check the database containment setting:

```sql
SELECT containment_desc FROM sys.databases WHERE name = DB_NAME();
```

For contained databases, set the containment option:

```sql
ALTER DATABASE MyDatabase SET CONTAINMENT = PARTIAL;
```

## Secure connection strings

Regardless of authentication method, protect your connection strings from exposure:

- Store connection strings in Azure Key Vault or environment variables, not in code
- Use managed identities to eliminate credentials from connection strings entirely
- Enable encrypted connections with `Encrypt=True;TrustServerCertificate=False`
- Limit network access using firewall rules and private endpoints

A secure connection string for Azure SQL with managed identity:

```
Server=tcp:myserver.database.windows.net,1433;Database=mydb;Authentication=Active Directory Managed Identity;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

For SQL databases in Microsoft Fabric, connections use Microsoft Entra authentication through the workspace identity. Configure access by adding Microsoft Entra users or groups to workspace roles, which automatically grant appropriate database permissions.
