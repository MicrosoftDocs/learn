MySQL is a relational database based on the SQL standard. Data is stored on the server, in tables made up of columns and rows. Clients can access the server data via web sites, apps, or using an integrated developer environment (IDE) such as MySQL Workbench or dbForge. Examples in this module use MySQL Workbench.

:::image type="content" source="../media/mysql-architecture.png" alt-text="Screenshot that shows the Graphical user interface Description automatically generated." lightbox="../media/mysql-architecture.png":::

MySQL allows different storage engines to be used. The default storage engine is InnoDB, which is the storage engine supported by Azure Database for MySQL. Data files including databases, tales, log, and status files are stored in the **data directory**. You can display the location of data files by running:

```sql
SELECT @@datadir;
```

> [!NOTE]
> Azure Database for MySQL does not provide access to the underlying file system. You can see where data files are stored, but do not have access to the actual files except through the database.

MySQL holds global parameters in a file called **my.cnf**. In Azure Database for MySQL, most of the server configuration parameters can be managed in the Azure portal. Navigate to your Azure Database for MySQL server and select **Server parameters**. Alternatively, you can use the Azure CLI.

## Query cache

The query cache was a feature of MySQL until version 5.1. In 5.7 the query cache was deprecated, and in version 8.1. it was removed. This was done to improve performance.

## Client/server protocol

The MySQL client/server protocol is half-duplex, which means that it can either send data, or receive data, but not both. If the client sends a complex query, the server must wait until the complete query has been received.

Clients send a query is sent as one packet of data. The **max_allowed_packet** defines the maximum size for a query, a string or parameter. In the Azure portal, navigate to your Azure Database for MySQL server, select **Server parameters** and in the search, enter **max_allowed_packet**.

If the server has a large record set to return, the whole record set must be returned before it is responsive to new queries. It is therefore important to write queries that filter the result set before the server sends it, so only the required records are returned.

The MySQL client/server protocol supports Secure Sockets Layer (SSL) connections between client applications and the database server to help prevent man in the middle attacks. To configure the MySQL Workbench to require an encrypted connection to the Azure Database for MySQL server:

1. From the top menu, select **Database**.
1. Select **Manage Connections**, and either edit an existing connection or create a new connection. The Manage Server Connections dialog box is displayed.
1. Under **Connection**, select the **SSL** tab.
1. Next to **Use SSL**, select **Require**.
1. Next to **SSL CA File**, provide the path to the Certificate Authority file.

In the Azure portal, navigate to your Azure Database for MySQL server, and select **Connection security** from the left menu. Under SSL settings, **Enforce SSL connection** setting can be toggled to **ENABLED** or **DISABLED**. You can also set the **Minimum TLS version**.

## The MySQL daemon

The MySQL daemon, also known as the MySQL Server or **mysqld**, is a service program that manages access to the other MySQL components including the **MySQL data directory, mysqladmin** and the **query optimizer**. The **mysqld** service program is started using the **mysqld_safe** script. This happens behind the scenes whenever you start or restart your Azure Database for MySQL server.

> [!NOTE]
> You can stop your Azure Database for MySQL when it is not in use and restart it when required. This can be done in the Azure portal, in Azure Cloud Shell, MySQL Workbench, or using MySQL for Visual Studio.

The **mysqld** service runs continuously for as long as the server is running. When you stop your Azure Database for MySQL server, no MySQL services can be accessed until the server is restarted.

> [!NOTE]
> Azure Database for MySQL is a service, and does not provide access to individual files such as the MySQL daemon.

## Data types

MySQL supports several categories of data types:

- **Numeric** - Integer (INT), Small integer, Decimal (DEC, FIXED), Numeric, Float, Real, Double Precision (DOUBLE), BIT
- **Date and time** - Date, Time, DateTime, Timestamp, Year
- **String** - CHAR, VARCHAR, BINARY, VARBINARY, BLOB, TEXT, ENUM, and SET.
- **Spatial** - geometry type
- **JSON** - the native JSON data type has been supported since version 5.7.

See the [MySQL Data Types](https://dev.mysql.com/doc/refman/5.7/en/data-types.html) documentation for which storage engines support which data types, synonyms, and updating behavior of certain data types.
