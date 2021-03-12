Once you've migrated your database from on-premises to Azure, you need to update your existing applications so that they can access the PostgreSQL in its new location. 

Your original on-premises server and database will contain roles that define the privileges associated with users, the operations they can do, and the objects they perform these operations over. Azure Database for PostgreSQL uses the same authentication and authorization mechanisms as PostgreSQL running on-premises.

In this unit, you'll explore the updates you need to make to your applications to connect to your newly migrated Azure Database for PostgreSQL.
## Create the user roles manually

When you transfer a PostgreSQL database to Azure Database for PostgreSQL using the Azure Database Migration Service, the roles and role assignments aren't copied. You must manually recreate the necessary roles and user accounts for the administrator and users of the tables in the target database. You use the psql or pgAdmin utilities to do these tasks. Run the `CREATE ROLE` command. You use the `GRANT` command to assign the necessary privileges to a role. For example:

```SQL
CREATE ROLE myuseraccount WITH LOGIN NOSUPERUSER CREATEDB PASSWORD 'mY!P@ss0rd';
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuseraccount;
```

> [!NOTE]
> You also use the `createuser` command from the bash prompt to create PostgreSQL roles.

To view the existing roles in the on-premises database, run the following SQL statement:

<!-- NOTE TO REVIEWER. "rolname" is not a type. It isn't "rolename" -->

```SQL
SELECT rolname
FROM pg_roles;
```

You can use the **\du** command in the psql utility to display the privileges assigned to roles.

```Text
                              List of roles
   Role name   |               Attributes                                   | Member of
---------------+------------------------------------------------------------+-----------
 azureuser     | Superuser, Create DB                                       | {}
 myuseraccount | Create DB                                                  | {}
 postgres      | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

> [!Note]
> Note that Azure Database for PostgreSQL adds some roles of its own. These roles include `azure_pg_admin`, `azure_superuser`, and the administrator user that you specified when you created the service. You sign in using your administrative accounts, but the other two roles are reserved for use by Azure—you shouldn't attempt to use them.

## Reconfigure applications

Reconfiguring an application to connect to Azure Database for PostgreSQL is a straightforward process. However, it's more important to determine a strategy for migration applications.

### Considerations when reconfiguring PostgreSQL applications

In a corporate environment, you might have many applications running against the same PostgreSQL databases. There could be a large number of users running these applications. You want to be assured that, when you switch from the existing system to Azure Database for PostgreSQL, your systems will still work, users can continue doing their jobs, and your business-critical operations remain operational. Module 1, Lesson 2, *Considerations for migration*, discussed many of the issues in general terms. When you migrate a PostgreSQL database to Azure, there are some specifics to note:

- If you're performing an offline migration, the data in the original PostgreSQL database and the new databases running on Azure can start to diverge quickly if the old database is still being used. An offline migration is suitable when you take a system out of operation entirely for a short while, and then switch all applications to the new system before starting up again. This approach might not be possible for a business-critical system. If you're migrating to PostgreSQL running on an Azure virtual machine, you configure PostgreSQL replication between your on-premises system and that running in Azure. Native PostgreSQL replication operates in one direction only, but third-party solutions are available that support bidirectional replication between PostgreSQL servers (these solutions won't work with Azure Database for PostgreSQL).
- If you're performing an online migration, the Azure Database for PostgreSQL service sets up replication from the on-premises database to the database running in Azure. After the initial data transfer, replication ensures that any changes made in the on-premises database are copied to the database in Azure, but not the other way round.

In both cases, you should ensure that you don't lose live data through an accidental overwrite. For example, in the online scenario, an application connected to the database running in Azure Database for PostgreSQL could have its changes blindly overwritten by an application still using the on-premises database. With this in mind, you should consider the following approaches:

- Migrate applications based on their workload type. An application that accesses the data for reading only can move safely to the database running in Azure Database for PostgreSQL, and will see all changes made by applications still using the on-premises database. You can also adopt the converse strategy if read-only applications don't require fully up-to-date data.
- Migrate users based on their workload type. This strategy is similar to the previous one, except that you might have users that only generate reports while others modify the data. You might have the same application configured to connect to the appropriate database according to user requirements.
- Migrate applications based on the datasets they use. If different applications utilize different subsets of the data, you might be able to migrate these applications independently of each other.

### Reconfiguring an application

To reconfigure an application, you point it at the new database. Most well-written applications will isolate the connection logic, and this should be the only part of the code that requires changing. In many cases, the connection information might be stored as configuration information—you only need to update that information.

You'll find the connection information for your Azure Database for PostgreSQL service in the Azure portal, on the **Connection strings** page for your service. Azure provides the information for many common programming languages and frameworks.

[![Image showing the **Connection strings** page for Azure Database for PostgreSQL item in the Azure portal](../media/3-connection-strings.png)](../media/3-connection-strings.png#lightbox)

### Open network ports

As mentioned in Lesson 1 of this module, Azure Database for PostgreSQL is a protected service that runs behind a firewall. Clients can't connect unless their IP address is recognized by the service. You must add the IP addresses, or address block ranges, for clients running applications that need to connect to your databases.

## Test and verify applications

Before you switch your applications and users to the new database, it's important to ensure that you've configured everything correctly.

Start by "dry-running" applications and connect each role to ensure the correct functionality is available.

Next, perform "soak tests" to mimic the typical number of users running representative workloads concurrently for a period of time. Monitor the system, and verify that you've allocated sufficient resources to your Azure Database for PostgreSQL service.

At this point, you can start to roll out the system to users. It might be beneficial to implement some form of "canary testing", where a small subset of users is transferred to the system unawares. This gives you an unbiased opinion as to whether users are having the same, better, or worse experience with the new database.
