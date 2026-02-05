Object-level permissions control what actions users can perform on database objects like tables, views, stored procedures, and functions. While Row-Level Security filters data within objects, object-level permissions determine whether a user can access an object at all and what operations they can perform.

A well-designed permission model works hand-in-hand with secure authentication. This unit covers both how to grant the right permissions AND how to ensure users authenticate securely, preferably without passwords.

## Understand the permission hierarchy

SQL Server uses a [hierarchical permission model](/sql/relational-databases/security/permissions-hierarchy-database-engine?azure-portal=true) where permissions granted at higher levels flow down to lower levels. The hierarchy flows from server to database to schema to individual objects.

At the server level, permissions control sign-in management and server configuration. Database-level permissions govern actions within a specific database. Schema-level permissions apply to all objects within a schema, while object-level permissions target specific tables, views, or procedures.

When you grant `SELECT` permission on a schema, users can select from all tables and views in that schema, including objects created in the future:

```sql
-- Grant SELECT on all objects in the Sales schema
GRANT SELECT ON SCHEMA::Sales TO SalesAnalyst;

-- Grant EXECUTE on all procedures in the Reports schema
GRANT EXECUTE ON SCHEMA::Reports TO ReportingUsers;
```

## Grant and revoke permissions

The [`GRANT`](/sql/t-sql/statements/grant-transact-sql?azure-portal=true) statement gives users specific permissions. The [`REVOKE`](/sql/t-sql/statements/revoke-transact-sql?azure-portal=true) statement removes previously granted permissions, and [`DENY`](/sql/t-sql/statements/deny-transact-sql?azure-portal=true) explicitly blocks permissions, overriding any grants.

```sql
-- Allow reading data
GRANT SELECT ON dbo.Customers TO CustomerServiceRole;

-- Allow data modifications
GRANT INSERT, UPDATE ON dbo.Orders TO OrderProcessingRole;

-- Explicitly deny access to sensitive data (overrides any grants)
DENY SELECT ON dbo.EmployeeSalaries TO HRAssistants;

-- Remove a permission without explicitly denying it
REVOKE INSERT ON dbo.Customers FROM CustomerServiceRole;
```

The difference between `REVOKE` and `DENY` matters when users have multiple permission sources. Revoking removes one grant but doesn't prevent access through other grants. Denying blocks access regardless of other grants.

## Implement role-based access control

Rather than granting permissions directly to users, create [database roles](/sql/relational-databases/security/authentication-access/database-level-roles?azure-portal=true) that represent job functions. Assign permissions to roles, then add users to appropriate roles:

```sql
-- Create roles for different job functions
CREATE ROLE DataReaders;
CREATE ROLE DataWriters;

-- Grant appropriate permissions to each role
GRANT SELECT ON SCHEMA::dbo TO DataReaders;
GRANT INSERT, UPDATE, DELETE ON SCHEMA::dbo TO DataWriters;

-- Add users to roles
ALTER ROLE DataReaders ADD MEMBER JohnSmith;
ALTER ROLE DataWriters ADD MEMBER JaneDoc;
```

You can nest roles to create hierarchical permission structures. Adding someone to a parent role automatically gives them all child role permissions.

> [!TIP]
> Document your role hierarchy and use a naming convention that makes each role's purpose clear, such as prefixing with the department or function.

## Apply schema separation for security

[Schemas](/sql/relational-databases/security/authentication-access/create-a-database-schema?azure-portal=true) provide a natural boundary for organizing objects and managing permissions:

```sql
CREATE SCHEMA Sales AUTHORIZATION dbo;
CREATE SCHEMA HR AUTHORIZATION dbo;

-- Sales team can read and write sales data
GRANT SELECT, INSERT, UPDATE ON SCHEMA::Sales TO SalesTeam;

-- HR has full control of their schema
GRANT CONTROL ON SCHEMA::HR TO HRAdministrators;
```

## Configure Microsoft Entra authentication

Modern applications should use passwordless authentication whenever possible. [Microsoft Entra authentication](/azure/azure-sql/database/authentication-aad-overview?azure-portal=true) eliminates the risks associated with password management, including credential theft and the operational burden of rotating secrets.

SQL databases support multiple authentication methods. SQL authentication uses a username and password stored in the database—straightforward but risky if credentials are compromised. Microsoft Entra authentication extends identity integration to cloud scenarios, working with Azure SQL Database, Azure SQL Managed Instance, SQL Server 2022+, and SQL databases in Microsoft Fabric.

Create database users from Microsoft Entra identities:

```sql
-- Create users for Entra accounts, managed identities, or groups
CREATE USER [app-service-identity] FROM EXTERNAL PROVIDER;
CREATE USER [developer@contoso.com] FROM EXTERNAL PROVIDER;
CREATE USER [DataAnalystsGroup] FROM EXTERNAL PROVIDER;

-- Grant permissions just like SQL users
ALTER ROLE db_datareader ADD MEMBER [developer@contoso.com];
ALTER ROLE db_datawriter ADD MEMBER [app-service-identity];
```

## Implement managed identity authentication

[Managed identities](/azure/active-directory/managed-identities-azure-resources/overview?azure-portal=true) provide the most secure option for Azure-hosted applications. Azure automatically manages the identity lifecycle, and no credentials exist that could be leaked or stolen.

For an Azure App Service connecting to Azure SQL Database, enable the system-assigned managed identity, then create a database user:

```sql
CREATE USER [MyWebApp] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [MyWebApp];
ALTER ROLE db_datawriter ADD MEMBER [MyWebApp];
```

Update your application connection string to use managed identity authentication:

```
Server=tcp:myserver.database.windows.net,1433;Database=mydb;Authentication=Active Directory Managed Identity;Encrypt=True;
```

> [!TIP]
> Use user-assigned managed identities when multiple applications need the same database permissions. This reduces the number of database users to manage.

## Secure connection strings

Regardless of authentication method, protect your connection strings:

- Store connection strings in Azure Key Vault or environment variables, not in code
- Use managed identities to eliminate credentials from connection strings entirely
- Enable encrypted connections with `Encrypt=True;TrustServerCertificate=False`
- Limit network access using firewall rules and private endpoints

> [!IMPORTANT]
> When using client secrets for service principals, store them in Azure Key Vault and rotate them regularly. Certificate-based authentication provides stronger security than shared secrets.

## View and audit permissions

Query system views to understand current permission assignments:

```sql
-- View all permissions for a specific principal
SELECT 
    prin.name AS PrincipalName,
    perm.permission_name,
    perm.state_desc AS PermissionState,
    obj.name AS ObjectName
FROM sys.database_permissions perm
INNER JOIN sys.database_principals prin ON perm.grantee_principal_id = prin.principal_id
LEFT JOIN sys.objects obj ON perm.major_id = obj.object_id
WHERE prin.name = 'SalesAnalyst';

-- Check effective permissions for the current user
SELECT * FROM fn_my_permissions('Sales.Orders', 'OBJECT');
```

Regularly audit permission assignments to ensure they align with current job functions. Combine object-level permissions with other security features like Row-Level Security and Dynamic Data Masking for comprehensive data protection.
