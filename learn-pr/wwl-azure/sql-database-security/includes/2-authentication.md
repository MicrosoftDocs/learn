
Two components of every secure database are authentication and authorization.

**Authentication** is the process of proving the user is who they claim to be. A user connects to a database using a user account. When a user attempts to connect to a database, they provide a user account and authentication information. The user is authenticated using one of the following two authentication methods:

 -  **SQL authentication** \- With this authentication method, the user submits a user account name and associated password to establish a connection. This password is stored in the master database for user accounts linked to a login or stored in the database containing the user accounts not linked to a login.
 -  **Azure Active Directory Authentication** \- With this authentication method, the user submits a user account name and requests that the service use the credential information stored in Azure Active Directory.

You can create user accounts in the master database, and grant permissions in all databases on the server, or you can create them in the database itself (called contained database users). By using contained databases, you obtain enhance portability and scalability.

**Logins and users**: In Azure SQL, a user account in a database can be associated with a login that is stored in the master database or can be a user name that is stored in an individual database.

 -  A **login** is an individual account in the master database, to which a user account in one or more databases can be linked. With a login, the credential information for the user account is stored with the login.
 -  A **user account** is an individual account in any database that may be but does not have to be linked to a login. With a user account that is not linked to a login, the credential information is stored with the user account.

**Authorization** to access data and perform various actions are managed using database roles and explicit permissions. Authorization refers to the permissions assigned to a user, and determines what that user is allowed to do. Authorization is controlled by your user account's database role memberships and object-level permissions. As a best practice, you should grant users the least privileges necessary. As a best practice, your application should use a dedicated account to authenticate. This way, you can limit the permissions granted to the application and reduce the risks of malicious activity in case the application code is vulnerable to a SQL injection attack. The recommended approach is to create a contained database user, which allows your app to authenticate directly to the database.

:::image type="content" source="../media/az500-database-authentication-e61f1571.png" alt-text="Data authentication flow for AAD and SQL server. An Azure AD database adminstrator and SQL database administrator are shown.":::


> [!IMPORTANT]
> Use Azure Active Directory authentication to centrally manage identities of database users and as an alternative to SQL Server authentication.
