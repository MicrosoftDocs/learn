Let's assume you're running a website and an attacker gained access to your database. The attacker gained access to a dbo account and can perform any operation on the database. A dbo account can access and manipulate information such as metadata and perform all levels of access.

If the attacker only gained access to a regular user account, they could only access tables, views, stored procedures, and other objects defined for that user account. For example, if a website accessing a database was compromised due to a SQL injection attack, the attacker would have limited capabilities.

If a security breach occurs, restricted access reduces the impact of the breach. Let's look at how to restrict access to the SQL Azure database at the user layer.

## Reduce the attack surface of the database

To reduce the impact of any security breach, you restrict the surface area of the attack. If you're connecting to your database using a dbo or administrator account and an attacker gets access to the database, the attacker will have access to perform all operations on the database. Access could include querying the database metadata, determining what data is available and/or sensitive, and exploiting this information.

You avoid this security risk by creating database users that have restricted permissions. We'll use the term least-privilege here, as the users should only have access to the tables, views, stored procedures, and other entities needed to do their work.

## Create a database user

To create a user with reduced privileges, you'll create a database user and then associate that user with the database. Let's create a SQL Server user and give the user permissions to the database.

> [!Note]
> There are thirteen (13) types of users in SQL Server. If you need to create another type of database user, use the appropriate link to find out the correct syntax. See [Create a database user](https://docs.microsoft.com/sql/relational-databases/security/authentication-access/create-a-database-user?view=sql-server-2017).

The preferred practice is to create the user at a database level. This step prevents user permissions from going outside the boundaries of the database that you are trying to protect.

1. First, select the database.
2. Then, create the user using the following query:

   ```sql
   CREATE USER MyWebAppUser WITH PASSWORD = '<YourSuperStrongPassword>';
   ```

   The previous query creates the user *MyWebUser*. By default the user will not have access to any tables, views, or stored procedures.

3. Now, create appropriate permissions for the user by adding them to roles such as db_datareader and db_datawriter.

   The db_datareader role will allow the user access to all user tables and views within the database. Likewise, the db_datawriter role will allow the user access to read, write, update, and delete rows in the database.

   ```sql
   ALTER ROLE db_datareader ADD MEMBER MyWebAppUser;
   ALTER ROLE db_datawriter ADD MEMBER MyWebAppUser;
   ```

You can deny a user's access to other elements within the database using the DENY operator. Here you're denying the user MyWebAppUser the ability to select data from the Customers table.

```sql
DENY SELECT ON Customers TO MyWebAppUser;
```

You can also use the GRANT permission to explicitly give permissions to a user or role.

```sql
GRANT SELECT ON Customers TO MyWebAppUser;
```

You'll continue to refine the operations on the database in order to get the user to the level of access needed. Instead of a user, you can create a role with the minimum permissions needed and then add the user to the role.

If you have multiple users that have the same permissions, you could create those users as part of a role. Once all the access permissions have been granted or denied, new users will have access only to the things that they need.
If an attacker gains access to the database through a newly created user, they will only see and execute the same data and operations the user can. Locking down user access greatly reduces the surface area of attack on the database.
