Object-level permissions control what actions users can perform on database objects like tables, views, stored procedures, and functions. Unlike Row-Level Security that filters data within objects, object-level permissions determine whether a user can access an object at all and what operations they can perform.

Designing effective permission strategies requires understanding the permission hierarchy, how permissions flow through security principals, and best practices for managing access at scale. A well-designed permission model reduces administrative overhead while maintaining the principle of least privilege.

## Understand the permission hierarchy

SQL Server uses a hierarchical permission model where permissions granted at higher levels flow down to lower levels. The hierarchy flows from server to database to schema to individual objects. Understanding this hierarchy helps you grant permissions efficiently without excessive administrative burden.

At the server level, permissions control login management, database creation, and server configuration. Database-level permissions govern actions within a specific database, such as creating tables or managing users. Schema-level permissions apply to all objects within a schema, while object-level permissions target specific tables, views, or procedures.

When you grant `SELECT` permission on a schema, users can select from all tables and views in that schema, including objects created in the future. This approach simplifies administration compared to granting permissions on each object individually.

```sql
-- Grant SELECT on all objects in the Sales schema
GRANT SELECT ON SCHEMA::Sales TO SalesAnalyst;

-- Grant EXECUTE on all procedures in the Reports schema
GRANT EXECUTE ON SCHEMA::Reports TO ReportingUsers;
```

## Grant and revoke permissions

The `GRANT` statement gives users specific permissions on objects. The `REVOKE` statement removes previously granted permissions, and `DENY` explicitly blocks permissions, overriding any grants.

Grant basic data access permissions:

```sql
-- Allow reading data
GRANT SELECT ON dbo.Customers TO CustomerServiceRole;

-- Allow data modifications
GRANT INSERT, UPDATE ON dbo.Orders TO OrderProcessingRole;

-- Allow executing a stored procedure
GRANT EXECUTE ON dbo.usp_ProcessPayment TO PaymentProcessors;
```

When granting permissions, you can include the `WITH GRANT OPTION` clause to allow the recipient to grant the same permission to others:

```sql
GRANT SELECT ON dbo.Products TO ProductManager WITH GRANT OPTION;
```

The `DENY` statement takes precedence over grants. If a user belongs to a role that grants `SELECT` on a table but also belongs to a group with `DENY SELECT`, the denial wins:

```sql
-- Explicitly deny access to sensitive data
DENY SELECT ON dbo.EmployeeSalaries TO HRAssistants;
```

To remove a permission without explicitly denying it, use `REVOKE`:

```sql
REVOKE INSERT ON dbo.Customers FROM CustomerServiceRole;
```

The difference between `REVOKE` and `DENY` matters when users have multiple permission sources. Revoking removes one grant but doesn't prevent access through other grants. Denying blocks access regardless of other grants.

## Implement role-based access control

Rather than granting permissions directly to users, create database roles that represent job functions. Assign permissions to roles, then add users to appropriate roles. This approach simplifies management when employees change positions or leave the organization.

Create roles aligned with business functions:

```sql
-- Create roles for different job functions
CREATE ROLE DataReaders;
CREATE ROLE DataWriters;
CREATE ROLE ReportExecutors;

-- Grant appropriate permissions to each role
GRANT SELECT ON SCHEMA::dbo TO DataReaders;
GRANT INSERT, UPDATE, DELETE ON SCHEMA::dbo TO DataWriters;
GRANT EXECUTE ON SCHEMA::Reports TO ReportExecutors;
```

Add users to roles based on their job requirements:

```sql
-- Add users to roles
ALTER ROLE DataReaders ADD MEMBER JohnSmith;
ALTER ROLE DataWriters ADD MEMBER JaneDoc;
ALTER ROLE DataReaders ADD MEMBER JaneDoc;  -- Jane can read AND write
ALTER ROLE ReportExecutors ADD MEMBER AnalystTeam;
```

You can nest roles to create hierarchical permission structures:

```sql
-- Create a senior role that includes permissions from other roles
CREATE ROLE SeniorAnalyst;
ALTER ROLE DataReaders ADD MEMBER SeniorAnalyst;
ALTER ROLE ReportExecutors ADD MEMBER SeniorAnalyst;

-- Now adding someone to SeniorAnalyst gives them both role's permissions
ALTER ROLE SeniorAnalyst ADD MEMBER ExperiencedAnalyst;
```

> [!TIP]
> Document your role hierarchy and permission assignments. Use a naming convention that makes the role's purpose clear, such as prefixing with the department or function.

## Apply schema separation for security

Schemas provide a natural boundary for organizing objects and managing permissions. By placing related objects in dedicated schemas, you can grant permissions at the schema level rather than on individual objects.

Create schemas for different functional areas:

```sql
CREATE SCHEMA Sales AUTHORIZATION dbo;
CREATE SCHEMA Inventory AUTHORIZATION dbo;
CREATE SCHEMA HR AUTHORIZATION dbo;
CREATE SCHEMA Reports AUTHORIZATION dbo;
```

Move or create objects in appropriate schemas:

```sql
-- Create new table in the Sales schema
CREATE TABLE Sales.Orders (
    OrderID int PRIMARY KEY,
    CustomerID int,
    OrderDate datetime2
);

-- Move existing table to HR schema
ALTER SCHEMA HR TRANSFER dbo.Employees;
```

Grant schema-level permissions to roles:

```sql
-- Sales team can read and write sales data
GRANT SELECT, INSERT, UPDATE ON SCHEMA::Sales TO SalesTeam;

-- HR has full control of their schema
GRANT CONTROL ON SCHEMA::HR TO HRAdministrators;

-- Everyone can execute report procedures
GRANT EXECUTE ON SCHEMA::Reports TO public;
```

## View and audit permissions

Query system views to understand current permission assignments:

```sql
-- View all permissions for a specific principal
SELECT 
    prin.name AS PrincipalName,
    prin.type_desc AS PrincipalType,
    perm.permission_name,
    perm.state_desc AS PermissionState,
    obj.name AS ObjectName,
    obj.type_desc AS ObjectType
FROM sys.database_permissions perm
INNER JOIN sys.database_principals prin ON perm.grantee_principal_id = prin.principal_id
LEFT JOIN sys.objects obj ON perm.major_id = obj.object_id
WHERE prin.name = 'SalesAnalyst';
```

Check effective permissions for the current user on a specific object:

```sql
SELECT * FROM fn_my_permissions('Sales.Orders', 'OBJECT');
```

To see what permissions a different user has, use `EXECUTE AS`:

```sql
EXECUTE AS USER = 'SalesAnalyst';
SELECT * FROM fn_my_permissions('Sales.Orders', 'OBJECT');
REVERT;
```

> [!IMPORTANT]
> Regularly audit permission assignments to ensure they align with current job functions. Remove unnecessary permissions when employees change roles or leave the organization.

Permission management requires ongoing attention. Establish processes for requesting, approving, and reviewing access. Combine object-level permissions with other security features like Row-Level Security and Dynamic Data Masking for comprehensive data protection.
