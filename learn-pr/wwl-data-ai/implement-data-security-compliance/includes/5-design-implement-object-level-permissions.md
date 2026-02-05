Object-level permissions control what actions users can perform on database objects like tables, views, stored procedures, and functions. While Row-Level Security filters data within objects, object-level permissions determine whether a user can access an object at all and what operations they can perform.

A well-designed permission model goes hand-in-hand with secure authentication. This unit covers both: how to grant the right permissions and how to ensure users authenticate securely, preferably without passwords.

## Understand the permission hierarchy

SQL Server uses a [hierarchical permission model](/sql/relational-databases/security/permissions-hierarchy-database-engine?azure-portal=true) where permissions granted at higher levels flow down to lower levels. Think of it as a cascade: server → database → schema → individual objects.

At the server level, permissions control sign-in management and server configuration. Database-level permissions govern actions within a specific database. Schema-level permissions apply to all objects within a schema, while object-level permissions target specific tables, views, or procedures.

Here's a powerful pattern: when you grant `SELECT` permission on a schema, users can select from all tables and views in that schema—including objects created in the future:

```sql
-- Grant SELECT on all objects in the Sales schema
GRANT SELECT ON SCHEMA::Sales TO SalesAnalyst;

-- Grant EXECUTE on all procedures in the Reports schema
GRANT EXECUTE ON SCHEMA::Reports TO ReportingUsers;
```

## Grant and revoke permissions

Three statements control permissions: [`GRANT`](/sql/t-sql/statements/grant-transact-sql?azure-portal=true) gives users specific permissions, [`REVOKE`](/sql/t-sql/statements/revoke-transact-sql?azure-portal=true) removes previously granted permissions, and [`DENY`](/sql/t-sql/statements/deny-transact-sql?azure-portal=true) explicitly blocks permissions—overriding any grants.

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

What's the difference between `REVOKE` and `DENY`? It matters when users have multiple permission sources. Revoking removes one grant but doesn't prevent access through other grants. Denying blocks access no matter what other grants exist.

## Implement role-based access control

Instead of granting permissions directly to users, create [database roles](/sql/relational-databases/security/authentication-access/database-level-roles?azure-portal=true) that represent job functions. Assign permissions to roles, then add users to the appropriate roles:

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

You can also nest roles to create hierarchical permission structures—adding someone to a parent role automatically gives them all child role permissions.

> [!TIP]
> Document your role hierarchy and use a naming convention that makes each role's purpose clear, such as prefixing with the department or function.

## Apply schema separation for security

[Schemas](/sql/relational-databases/security/authentication-access/create-a-database-schema?azure-portal=true) provide a natural way to organize objects and manage permissions. Group related objects together, then grant permissions at the schema level:

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

SQL databases support multiple authentication methods. SQL authentication uses a username and password stored in the database. It's straightforward, but risky if credentials get compromised. Microsoft Entra authentication extends identity integration to cloud scenarios, working with Azure SQL Database, Azure SQL Managed Instance, SQL Server 2022+, and SQL databases in Microsoft Fabric.

Creating database users from Microsoft Entra identities is simple:

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

[Managed identities](/azure/active-directory/managed-identities-azure-resources/overview?azure-portal=true) are the most secure option for Azure-hosted applications. Azure handles the identity lifecycle automatically, and there are no credentials that could be leaked or stolen.

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

No matter which authentication method you use, protect your connection strings with these best practices:

- Store them in Azure Key Vault or environment variables, not in code
- Use managed identities to eliminate credentials from connection strings entirely
- Enable encrypted connections with `Encrypt=True;TrustServerCertificate=False`
- Limit network access using firewall rules and private endpoints

> [!IMPORTANT]
> When using client secrets for service principals, store them in Azure Key Vault and rotate them regularly. Certificate-based authentication provides stronger security than shared secrets.

## View and audit permissions

You can query system views to understand current permission assignments:

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

Make it a habit to audit permission assignments regularly to ensure they still align with current job functions. And remember, object-level permissions work best when combined with other security features like Row-Level Security and Dynamic Data Masking for comprehensive protection.
