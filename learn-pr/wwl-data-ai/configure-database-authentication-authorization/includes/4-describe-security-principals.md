*Security Principals* are entities that can request SQL Server resources and to which you can (usually) grant permissions. There are several sets of security principals in SQL Server. Security principals exist at either the server level or the database level and can be either individuals or collections. Some sets have a membership controlled by the SQL Server administrators, and some have a fixed membership.

Logins and Server Roles are the server-level security principals we will be discussing. New logins can be added by administrators, but new server roles cannot be added.

At the database level, we’ll look at users, database roles, application roles.

## Schemas and securables

Before we look at the details of security principals, we need to understand the concepts of securables and schemas. SQL Server and Azure SQL Database have three scopes for securables. Securables are the resources within the database to which the authorization system manages access. For example, a table is a securable. To simplify access control, SQL Server contains securables in nested hierarchies called scopes. The three securable scopes are the server, the database, and the schema. A schema is a collection of objects within your database, which allows objects to be grouped into separate namespaces.

Every user has a default schema. If a user tries to access an object without specifying a schema name, as in: SELECT name FROM customers, it is assumed the object is in the user’s default schema. If there is no such object in the default schema, SQL Server will check to see if the object is in the pre-defined dbo schema. If there is no object of the specified name in either the user’s default schema, or in the dbo schema, the user will receive an error message. It is considered best practice to always specify the schema name when accessing objects, so the previous select would be something like:
‎SELECT name FROM SalesSchema.customers. If a user has not been given a default schema, their default schema is set to dbo.

By default, if no schema is specified when a user creates an object, SQL Server will attempt to create it in the user’s default schema. If the user has not been granted permission to create objects in their default schema, the object cannot be created.

## Logins and users

No matter the mode of authentication that is used, a login name used to access your SQL database is set up as a login within the instance. Those logins are set up at the instance level of SQL Server and stored in the master database. However, you can configure contained users, which are added at the database level. These users can be configured as SQL Server Authentication users as well as either Windows Authentication users or Azure Active Directory users (depending on which platform you are using). In order to create these users, the database must be configured for partial containment, which is configured by default in Azure SQL Database, and optionally configurable in SQL Server.

These users only have access to the database that the user is set up with. For the purposes of Azure SQL Database, it is considered a best practice to create users at the scope of the user database, and not in the master database as shown below.

```sql
CREATE USER [dba@contoso.com] FROM EXTERNAL PROVIDER;

GO
```

The create user statement is executed in the context of the user database. In the example above, the user is an Azure Active Directory user as indicated with the FROM EXTERNAL PROVIDER syntax. 

If logins are created at the instance level in SQL Server, a user should then be created within the database, which maps the user to the server-based login as shown in the following example.

```sql
USE Master

GO

CREATE LOGIN demo WITH PASSWORD = 'Pa55.w.rd'

GO

USE WideWorldImporters

GO

CREATE USER demo FROM LOGIN demo

GO
```

The login is first created in the master database, and then in the WideWorldImporters database a user is created to map to that user. Logins are used to access the SQL Server or the Azure SQL Database, but to do any work within a database, the login must be mapped to a username. The username is used for all authentication.

Logins and usernames are the most important security principals you need to be aware of, but the next sections describe some of the other concepts and terms when dealing with authorization.

## Database roles

As you can imagine, database security can get complicated for applications with many users. In order to make it easier for both administrators and auditors, most database applications use role-based security. Roles are effectively security groups that share a common set of permissions. Combining permissions into a role allows a set of roles to be created for a given application. Some examples of roles would be administrators who had full access to all of the databases and servers, reporting users who only read the database, and an application account that had access to write data into the database. The roles can be defined when the application is designed, and then users can be assigned to those roles as they need access to the database. Role-based access control or RBAC is a common architecture across computer systems and is how authorization is managed in Azure Resource Manager.

SQL Server and Azure SQL Database both include built-in roles that are defined by Microsoft, and also provide the option to create custom roles. Custom roles can be created at the server or database level. However, server roles cannot be granted access to objects within a database directly. Server roles are only available in SQL Server and Azure SQL Managed Instance, not in Azure SQL Database.

Within a database, permissions can be granted to the users that exist within the database. If multiple users all need the same permissions, you can create a database role within the database and grant the needed permissions to this role. Users can be added as members of the database role. The members of the database role will inherit the permissions of the database role.

```sql
CREATE USER [DP300User1] WITH PASSWORD = 'Pa55.w.rd'

GO

CREATE USER [DP300User2] WITH PASSWORD = 'Pa55.w.rd'

GO

CREATE ROLE [SalesReader]

GO

ALTER ROLE [SalesReader] ADD MEMBER [DP300User1]

GO

ALTER ROLE [SalesReader] ADD MEMBER [DP300User2]

GO

GRANT SELECT, EXECUTE ON SCHEMA::Sales TO [SalesReader]

GO
```

In the above example, you can see that two users are created, and then a role called SalesReader is created. The two new users are added to the newly created role, and then finally the role is granted SELECT and EXECUTE permissions on the Sales schema. Any user who is in that role can select from any object in the Sales schema, as well as execute any stored procedure in the schema.

## Application roles

Application roles can also be created within a SQL Server database or Azure SQL Database. Unlike database roles, users are not made members of an application role. An application role is activated by the user, by supplying the pre-configured password for the application role. Once the role is activated the permissions that are applied to the application role are applied to the user until that role is deactivated.

## Built-in database roles

Microsoft SQL Server contains several fixed database roles within each database for which the permissions are predefined. Users can be added as members of one or more roles. These roles give their members a pre-defined set of permissions. These roles work the same within Azure SQL Database and SQL Server.

Users that need to create other users within the database can be granted membership in the role db_accessadmin. This role does not grant access to the schema of any of the tables, nor does it grant access to the data within the database.

Users that need to back up a database in a SQL Server or Managed Instance can be made members of the role db_backupoperator. The role db_backupoperator does not confer any permissions in an Azure SQL Database.

Users that need the ability to read from every table and view within the database can be made members of the role db_datareader.

Users that need the ability to INSERT, UPDATE, and DELETE data from every table and view within the database can be made members of the role db_datawriter.

Users who need the ability to create or modify objects within the database can be made members of the role db_ddladmin. Members of this role can change the definition of any object, of any type, but members of this role are not granted access to read or write any data within the databases.

The role db_denydatareader can be used for users who need to be prevented from reading data from any object in the database, when those users have been granted rights through other roles or directly.

The role db_denydatawriter can be used for users who need to be prevented from writing data to any object in the database, when those users have been granted rights through other roles or directly.

Users who need administrative access to the database can be made members of the role db_owner. Members of the db_owner role can perform any action within the database by default. However, unlike the actual database owner, who has the user name *dbo*, users in the db_owner role can be blocked from accessing data by placing them in other database roles, such as db_denydatareader, or by denying them access to objects. Membership in this database role should be limited to only trusted users.

Users who need to be able to grant access to other users within the database can be made members of the role db_securityadmin. Members of this role are not specifically granted access to the data within the database; however members of this role can grant themselves access to the tables within the database. Membership in this database role should be limited to only trusted users.

All users within a database are automatically members of the public role. By default, this role has no permissions granted to it. Permissions can be granted to the public role, but you should consider carefully whether that is really something you want to do. Granting permissions to the public role would grant these permissions to any user, including the guest account, if the guest account was enabled.

The built-in database roles do meet the needs of many applications; however with applications that require more granular security (for example, when you only want to grant access to a specific subset of tables) a custom role is often a better choice. 

 > [!NOTE] 
 >By default, users in roles like db_owner can always see all of the data in the database. Applications should take advantage of encryption options like Always Encrypted to protect sensitive data from privileged users.

Azure SQL Database has two additional roles that are defined in the master database of Azure SQL server.

The role dbmanager within the master database allows its members to create additional databases within the Azure SQL Database environment. This role is the equivalent of the dbcreator fixed server role in an on-premises Microsoft SQL Server.

The role loginmanager within the master database allows its members to create additional logins at the server level. This role is the equivalent of the securityadmin fixed server role in an on-premises Microsoft SQL Server.

## Fixed server roles

In addition to database roles, SQL Server and Azure SQL Managed Instance both provide several fixed server roles. These roles assign permissions at the scope of the entire server. Server level principals, which include SQL Server logins, Windows accounts, and Windows group can be added into fixed server roles. The permissions for fixed server roles are predefined, and no new server roles can be added. The fixed server roles are:

**Sysadmin**—Members of the sysadmin role can perform any activity on the server.

**Serveradmin**—Members of the serveradmin role can change server-wide configuration settings (for example Max Server Memory) and can shut down the server.

**Securityadmin**—Members of the securityadmin role can manage logins and their properties (for example, changing the password of a login). The members can also grant and revoke server and database level permissions. This role should be treated as being equivalent to the sysadmin role.

**Processadmin**—Members of the processadmin role can kill processes running inside of SQL Server.

**Setupadmin**—Members of the setupadmin role can add and remove linked servers using T-SQL.

**Bulkadmin**—Members of the bulkadmin role can run the BULK INSERT T-SQL statement.

**Diskadmin**—Members of the diskadmin role have the ability to manage backup devices in SQL Server.

**Dbcreator**—Members of the dbcreator role have the ability to create, restore, alter, and drop any database.

**Public**—Every SQL Server login belongs to the public user role. Unlike the other fixed server roles, permissions can be granted, denied, or revoked from the public role.
