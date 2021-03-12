Once you've migrated your database from on-premises to Azure, you need to update your existing applications so that they can access the MySQL in its new location. 

Your original on-premises server and database will contain roles that define the privileges associated with users, the operations they can do, and the objects they perform these operations over. Azure Database for MySQL uses the same authentication and authorization mechanisms as PostgreSQL running on-premises.

In this unit, you'll explore the updates you need to make to your applications to connect to your newly migrated Azure Database for MySQL.

## Create the users manually

Your original on-premises server and database will contain users, the operations they perform, and the objects over which they do these operations. Azure Database for MySQL uses the same authentication and authorization mechanisms as MySQL running on-premises.

When you transfer a MySQL database to Azure Database for MySQL using the Azure Database Migration Service, the users aren't copied. You must manually recreate the necessary user accounts for the administrator and users of the tables in the target database. To do these tasks, you use the SQL language or a utility such as MySQL Workbench. Run the `CREATE USER` command. You use the `GRANT` command to assign the necessary privileges to a user. For example:

```SQL
CREATE USER 'myuseraccount'@'%' IDENTIFIED BY 'mY!P@ss0rd';
GRANT ALL PRIVILEGES ON DATABASE [Database Name].* TO myuseraccount;
FLUSH PRIVILEGES;
```

To view the existing grants in the on-premises database, run the following SQL statement:

```SQL
USE [Database Name];

SHOW GRANTS FOR 'myuseraccount'@'%';;
```

## Reconfigure applications

Reconfiguring an application to connect to Azure Database for MySQL is a straightforward process. However, it's crucial that you develop a strategy for migrating applications.

### Considerations when reconfiguring MySQL applications

In a corporate environment, you might have many applications running against the same MySQL databases. There could be a large number of users running these applications. You want to be assured that, when you switch from the existing system to Azure Database for MySQL, your systems will still work, users can continue doing their jobs, and business-critical operations remain operational. Module 1, Lesson 2, *Considerations for migration*, discussed many of the issues in general terms. 

When migrating a MySQL database to Azure, there are some specifics to consider:

- If you're performing an offline migration, the data in the original MySQL database and the new databases running on Azure might start to diverge quickly if the old database is still being used. An offline migration is suitable when you take a system entirely out of operation for a short while, and then switch all applications to the new system before starting up again. This approach might not be possible for a business-critical system. If you're migrating to MySQL running on an Azure virtual machine, you can configure MySQL replication between your on-premises system and that running in Azure. Native MySQL replication operates in one direction only, but third-party solutions are available that support bidirectional replication between MySQL servers. These solutions won't work with Azure Database for MySQL.
- If you're performing an online migration, the Azure Database for MySQL service sets up replication from the on-premises database to the database running in Azure. After the initial data transfer, replication ensures that any changes made in the on-premises database are copied to the database in Azure, but not the other way round.

In both cases, you should ensure that you don't lose live data through an accidental overwrite. For example, in the online scenario, an application connected to the database running in Azure Database for MySQL could have its changes blindly overwritten by an application still using the on-premises database. Therefore, you should consider the following approaches:

- Migrate applications based on their workload type. An application that accesses the data for reading only can move safely to the database running in Azure Database for MySQL, and will see all changes made by applications still using the on-premises database. You can also adopt the converse strategy if read-only applications don't require fully up-to-data data.
- Migrate users based on their workload type. This strategy is similar to the previous one, except that you might have users who only generate reports while others modify the data. You can have the same application configured to connect to the appropriate database according to the user's requirements.
- Migrate applications based on the datasets they use. If different applications use different subsets of the data, you might be able to migrate these applications independently of each other.

### Reconfiguring an application

To reconfigure an application, you point it at the new database. Most well-written applications should isolate the connection logic—this should be the only part of the code that requires changing. In many cases, connection information might be stored as configuration information, so you just need to update that information.

You'll find the connection information for your Azure Database for MySQL service in the Azure portal, on the **Connection strings** page for your Azure Database for MySQL service. Azure provides the information for many common programming languages and frameworks.

[![Image showing the **Connection strings** page for Azure Database for MySQL item in the Azure portal](../media/2-connection-strings.png)](../media/2-connection-strings.png#lightbox)

### Open network ports

As mentioned in Lesson 1 of this module, Azure Database for MySQL is a protected service that runs behind a firewall. Clients can't connect unless their IP address is recognized by the service. You must add the IP addresses, or address block ranges, for clients running applications that need to connect to your databases.

## Test and verify applications

Before you switch applications and users to the new database, it's important to ensure that you've configured everything correctly.

Start by "dry-running" applications and connect as each role to ensure the correct functionality is available.

Next, perform "soak tests" to mimic the number of users running typical workloads concurrently for a period of time. Monitor the system, and verify that you've allocated sufficient resources to your Azure Database for MySQL service.

You can now start to roll out the system to users. It might be beneficial to implement some form of "canary testing", where a small subset of users is transferred to the system unawares. This gives you an unbiased opinion as to whether users are having the same, better, or worse experience with the new database.
