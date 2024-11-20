Two components of every secure database are authentication and authorization.

Authentication is the process of proving the user is who they claim to be. A user connects to a database using a user account. When a user attempts to connect to a database, they provide a user account and authentication information. The user is authenticated using one of the following two authentication methods:

 -  SQL authentication - With this authentication method, the user submits a user account name and associated password to establish a connection. This password is stored in the master database for user accounts linked to a login or stored in the database containing the user accounts not linked to a login.
 -  Microsoft Entra authentication - With this authentication method, the user submits a user account name and requests that the service uses the credential information stored in Microsoft Entra ID.

You can create user accounts in the master database, and grant permissions in all databases on the server, or you can create them in the database itself (called contained database users). By using contained databases, you obtain enhanced portability and scalability.

Logins and users: In Azure SQL, a user account in a database can be associated with a login that is stored in the master database or can be a user name that is stored in an individual database.

 -  A login is an individual account in the master database, to which a user account in one or more databases can be linked. With a login, the credential information for the user account is stored with the login.
 -  A user account is an individual account in any database that may be but does not have to be linked to a login. With a user account that is not linked to a login, the credential information is stored with the user account.

Authorization to access data and perform various actions are managed using database roles and explicit permissions. Authorization refers to the permissions assigned to a user, and determines what that user is allowed to do. Authorization is controlled by your user account's database role memberships and object-level permissions. As a best practice, you should grant users the least privileges necessary. As a best practice, your application should use a dedicated account to authenticate. This way, you can limit the permissions granted to the application and reduce the risks of malicious activity in case the application code is vulnerable to a SQL injection attack. The recommended approach is to create a contained database user, which allows your app to authenticate directly to the database.

## Existing logins and user accounts after creating a new database

When you first deploy Azure SQL, you can specify a login name and a password for a special type of administrative login, the **Server admin**. The following configuration of logins and users in the master and user databases occurs during deployment:

 -  A SQL login with administrative privileges is created using the login name you specified. A **login** is an individual account for logging in to SQL Database, SQL Managed Instance, and Azure Synapse.<br>
 -  This login is granted full administrative permissions on all databases as a **server-level principal**. The login has all available permissions and can't be limited. In a SQL Managed Instance, this login is added to the **sysadmin fixed server role** (this role does not exist in Azure SQL Database).
 -  When this account signs into a database, they are matched to the special user account `dbo` (**user account**, which exists in each user database. The **dbo** user has all database permissions in the database and is member of the `db_owner` fixed database role.

To identify the **Server admin** account for a logical server, open the Azure portal, and navigate to the **Properties** tab of your server or managed instance.

The name of the **Server admin** account can't be changed after it has been created. To reset the password for the server admin, go to the Azure portal, click **SQL Servers**, select the server from the list, and then click **Reset Password**. To reset the password for the SQL Managed Instance, go to the **Azure portal**, click the instance, and click **Reset password**. You can also use PowerShell or the Azure CLI.
