Even though we may be able to connect to the database over the network, that doesn't mean we can actually gain access to the data itself. Following a layered approach, we'll want to ensure that only users who need access to the data can actually access it. This is where authentication and authorization come in to play.

## Authentication

Authentication is the process of verifying an identity. This identity could be a user, a service running on a system, or a system itself (such as a virtual machine). Through the process of authentication, we ensure that the person or system is who they claim to be. SQL Database supports two types of authentication: SQL authentication and Azure Active Directory authentication.

### SQL authentication

SQL authentication method uses a username and password. User accounts can be created in the master database and can be granted permissions in all databases on the server, or they can be created in the database itself (called contained users) and given access to only that database. When you created the logical server for your database, you specified a "server admin" login with a username and password. Using these credentials, you can authenticate to any database on that server as the database owner, or "dbo".

### Azure Active Directory authentication

This authentication method uses identities managed by Azure Active Directory (AD) and is supported for managed and integrated domains. Use Azure AD authentication (integrated security) whenever possible. With Azure AD authentication, you can centrally manage the identities of database users and other Microsoft services in one central location. Central ID management provides a single place to manage database users and simplifies permission management. If you want to use Azure AD authentication, you must create another server admin called the "Azure AD admin," which is allowed to administer Azure AD users and groups. This admin can also perform all operations that a regular server admin can.

## Authorization

Authorization refers to what an identity can do within an Azure SQL Database. This is controlled by permissions granted directly to the user account and/or database role memberships. A database role is used to group permissions together to ease administration, and a user is added to a role to be granted the permissions the role has. These permissions can grant things such as the ability to log in to the database, the ability to read a table, and the ability to add and remove columns from a database. As a best practice, you should grant users the least privileges necessary. The process of granting authorization to both SQL and Azure AD users is the same.

In our example here, the server admin account you are connecting with is a member of the db_owner role, which has authority to do anything within the database.

## Authentication and authorization in practice

Let's now take a look at how to set up a user and grant them access to a database. In this case we'll use SQL authentication for our user, but the process would be essentially the same if we were using Azure AD authentication.

### Create a database user

Let's go ahead and create a new user that we can use to grant access to.

1. In cloud shell, on your _appServer_ VM, connect to your database again as your `ADMINUSER`.

    ```bash
    sqlcmd -S tcp:server<12345>.database.windows.net,1433 -d marketplaceDb -U <username> -P <password> -N -l 30
    ```

1. Run the following command to create a new user. This will be a _contained user_ and will only allow access to the _marketplace_ database. Feel free to adjust the password as necessary, but be sure and note it as we'll need it for a future step.

    ```sql
    CREATE USER ApplicationUser WITH PASSWORD = 'YourStrongPassword1';
    GO
    ```

With these credentials, the user will be able to authenticate to the database, but they aren't authorized to access any data. Let's grant this user access.

### Grant permissions to a user

Let's make the user a member of the `db_datareader` and `db_datawriter` roles, granting access to read and write to the database, respectively. We also want to prevent this user from accessing a table with addresses.

1. While still connected to `sqlcmd` on _appServer_, run the following T-SQL to grant the `db_datareader` and `db_datawriter` roles to the user we just created.

    ```sql
    ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
    ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
    GO
    ```

1. We can narrow the scope of access further. We could deny a user's access to other elements within the database using the DENY operator. Run the following T-SQL to deny the user _ApplicationUser_ the ability to select data from the `SalesLT.Address` table.

    ```sql
    DENY SELECT ON SalesLT.Address TO ApplicationUser;
    GO
    ```

Let's now log in as that user and take a look at this in action.

1. While still at the T-SQL prompt, type `exit` to exit your session.

1. Now let's log back in to the database, but as the user we just created.

    ```bash
    sqlcmd -S tcp:server<12345>.database.windows.net,1433 -d marketplaceDb -U ApplicationUser -P <password> -N -l 30
    ```

1. Run the following query. This is pulling data from a table that the user is authorized to access.

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

1. Now let's see what happens when we try to query a table that we don't have access to.

    ```sql
    SELECT * FROM SalesLT.Address;
    GO
    ```

    You should get a message that you don't have access to this table.

    ```output
    Msg 229, Level 14, State 5, Server server-22942, Line 1
    The SELECT permission was denied on the object 'Address', database 'marketplace', schema 'SalesLT'.
    ```

As you can see here, even though we've granted read/write access to the database, we can further secure access to data by explicitly denying access to tables. If you had multiple users who shared similar access, you could create custom roles with the proper permissions and simplify your administration.

It's important to properly secure your database, and only grant access where necessary. Azure SQL Database provides the built-in ability to fully control the ability to authenticate and authorize identities to access the data in your database.