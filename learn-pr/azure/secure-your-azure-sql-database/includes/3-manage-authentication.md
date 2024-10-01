Even though you might be able to connect to the database over the network that doesn't mean you can actually gain access to the data itself. Following a layered approach, you want to ensure that only users who need access to the data can actually access it. This access is where authentication and authorization come in to play.

## Authentication

Authentication is the process of verifying an identity. This identity could be a user, a service that runs on a system, or a system itself, such as a virtual machine. Through the process of authentication, you ensure that the person or system is who they claim to be. SQL Database supports two types of authentication: _SQL authentication_ and _Microsoft Entra authentication_.

### SQL authentication

The SQL authentication method uses a username and password. User accounts can be created in the main database and can be granted permissions in all databases on the server. You can also create users in the database itself, called contained users, and give them access to only that database. When you created the logical server for your database, you specified a _server admin_ sign-in with a username and password. Using these credentials, you can authenticate to any database on that server as the database owner, or _dbo_.

<a name='azure-active-directory-authentication'></a>

### Microsoft Entra authentication

This authentication method uses identities managed by Microsoft Entra ID and is supported for managed and integrated domains. Use Microsoft Entra authentication (integrated security) whenever possible. With Microsoft Entra authentication, you can manage the identities of database users and other Microsoft services in one central location. Central ID management provides a single place to manage database users and simplifies permission management. If you want to use Microsoft Entra authentication, you must create another server administrator called the *Microsoft Entra admin*, which is allowed to administer Microsoft Entra users and groups. This admin can also perform all operations that a regular server admin can.

## Authorization

Authorization refers to what an identity can do within an Azure SQL Database. This authorization is controlled by permissions granted directly to the user account and database role memberships. A database role is used to group permissions together to ease administration. Add a user to a role to grant the permissions the role has. These permissions can include the ability to sign in to the database, the ability to read a table, and the ability to add and remove columns from a database. As a best practice, you should grant users the least privileges necessary. The process of granting authorization to both SQL and Microsoft Entra users is the same.

In the example here, the server admin account that you connect with is a member of the db_owner role, which has authority to do anything within the database.

## Authentication and authorization in practice

As a best practice, your application should use a dedicated account to authenticate. This way, you can limit the permissions granted to the application and reduce the risks of malicious activity in case the application code is vulnerable to a SQL injection attack. We recommend that you create a contained database user, which allows your app to authenticate directly to the database. For more information, see [Contained Database Users - Making Your Database Portable](/sql/relational-databases/security/contained-database-users-making-your-database-portable).

Use Microsoft Entra authentication to centrally manage identities of database users and as an alternative to SQL Server authentication.

Take a look at how to set up a user and grant them access to a database. In this case, you use SQL authentication for your user, but the process would be essentially the same if you use Microsoft Entra authentication.

### Create a database user

Create a new user that you can use to grant access to.

1. In Cloud Shell, on your _appServer_ VM, connect to your database again as your `ADMINUSER`.

    ```bash
    sqlcmd -S tcp:[server-name].database.windows.net,1433 -d marketplaceDb -U '[username]' -P '[password]' -N -l 30
    ```

1. Run the following command to create a new user. This user is a _contained user_ that has only allow access to the _marketplace_ database. Feel free to adjust the password as necessary, but be sure and note it because you need it for a future step.

    ```sql
    CREATE USER ApplicationUser WITH PASSWORD = 'YourStrongPassword1';
    GO
    ```

With these credentials, the user is able to authenticate to the database, but they aren't authorized to access any data. Grant this user access.

### Grant permissions to a user

Make the user a member of the `db_datareader` and `db_datawriter` roles, granting access to read and write to the database, respectively. You also want to prevent this user from accessing a table with addresses.

1. While still connected to `sqlcmd` on _appServer_, run the following T-SQL to grant the `db_datareader` and `db_datawriter` roles to the user you created.

    ```sql
    ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
    ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
    GO
    ```

1. You can narrow the scope of access further. You could deny a user's access to other elements within the database using the DENY operator. Run the following T-SQL to deny the user _ApplicationUser_ the ability to select data from the `SalesLT.Address` table.

    ```sql
    DENY SELECT ON SalesLT.Address TO ApplicationUser;
    GO
    ```

Now sign in as that user and take a look at this configuration in action.

1. While still at the T-SQL prompt, enter `exit` to exit your session.

1. Now sign back in to the database, but as the user you created.

    ```bash
    sqlcmd -S tcp:[server-name].database.windows.net,1433 -d marketplaceDb -U 'ApplicationUser' -P '[password]' -N -l 30
    ```

1. Run the following query. This query pulls data from a table that the user is authorized to access.

    ```sql
    SELECT FirstName, LastName, EmailAddress, Phone FROM SalesLT.Customer;
    GO
    ```

    You should get back a listing of customers.

    ```output
    FirstName      LastName       EmailAddress                    Phone
    -------------- -------------- ------------------------------- ------------
    Orlando        Gee            orlando0@adventure-works.com    245-555-0173
    Keith          Harris         keith0@adventure-works.com      170-555-0127
    Donna          Carreras       donna0@adventure-works.com      279-555-0130
    Janet          Gates          janet1@adventure-works.com      710-555-0173
    ...
    ```

1. See what happens when you try to query a table that you don't have access to.

    ```sql
    SELECT * FROM SalesLT.Address;
    GO
    ```

    You should get a message that you don't have access to this table.

    ```output
    Msg 229, Level 14, State 5, Server server-22942, Line 1
    The SELECT permission was denied on the object 'Address', database 'marketplace', schema 'SalesLT'.
    ```

As you can see here, even though you granted read/write access to the database, you can further secure access to data by explicitly denying access to tables. If you had multiple users who shared similar access, you could create custom roles with the proper permissions and simplify your administration.

It's important to properly secure your database, and only grant access where necessary. Azure SQL Database provides the built-in ability to fully control the ability to authenticate and authorize identities to access the data in your database.
