You cannot directly interact with PostgreSQL on the server, you need a client interface. This may be an application, or a client tool used for development. There are many different database client tools that work with PostgreSQL. This unit introduces the most common client tools.

## Pgbench

Pgbench is a program for running benchmarking tests on PostgreSQL databases. It works by running the same SQL commands, or sequence of SQL commands many times over. It then calculates the average transaction rate, measured in seconds.

You can run default pgbench test that includes five SELECT, UPDATE, AND INSERT commands per transaction. You can also write your own script files.

The output from pgbench includes:

- Query mode
- Number of threads
- Number of transactions per client
- Number of transactions actually processed
- Latency average
- Initial connection time
- Transactions per second (without initial connection time)

To ensure that the results from pgbench are useful, use the -t or -T option to make the query run for a few minutes. You may need to run queries for hours to get numbers that are reproducible. Run the same test several times, to find out how reliable the output statistics are.

Also, the default test is sensitive to the accumulation of dead rows in the tables. If **autovacuum** is enabled, it can result in changes to your measurements.

## pgAdmin

pgAdmin is a popular administration and development platform for PostgreSQL. It is open source and can be [downloaded](https://www.pgadmin.org/download/) and used without paying a license fee. pgAdmin works on Linux, Unix, macOS, and Windows and is available as a desktop app, or hosted by a web server.

## psql

psql is a command line utility that allows you to interact with a PostgreSQL server. It can be [downloaded](https://www.postgresql.org/docs/13/functions.html) as part of PostgreSQL. In the setup wizard, when you reach the **Select Components** dialog box, select **Command Line Tools**.

:::image type="content" source="../media/command-line-tools-setup.png" alt-text="Screenshot showing the Select Components dialog box." lightbox="../media/command-line-tools-setup.png":::

### Connect to Azure Database for PostgreSQL with psql

1. Start psql from your menu.
1. The syntax for connecting to the server is:

    ```sql
    psql --host=<servername> --port=<port> --username=<user@servername> --dbname=<dbname>
    ```

1. At the command prompt enter **--host=mypostflex.postgres.database.azure.com** which is the name of the Azure Database for PostgreSQL created in Module 1.

    ```sql
    psql --host=mydemoserver.postgres.database.azure.com --port=5432 --username=myadmin@mydemoserver --dbname=postgres
    ```

1. To create a blank database at the prompt, type:

    ```sql
    CREATE DATABASE mypgsqldb;
    ```

1. At the prompt, execute the following command to switch connection to the newly created database **mypgsqldb**:

    ```sql
    \c mypgsqldb
    ```

1. Now that you have connected to the server, and created a database you can execute familiar SQL queries, such as create tables in the database:

    ```sql
    CREATE TABLE inventory (
        id serial PRIMARY KEY,
        name VARCHAR(50),
        quantity INTEGER
        );
    ```

1. Load data into the tables

    ```sql
    INSERT INTO inventory (id, name, quantity) VALUES (1, 'banana', 150);
    INSERT I1NTO inventory (id, name, quantity) VALUES (2, 'orange', 154);
    ```

1. Query and update the data in the tables

    ```sql
    SELECT * FROM inventory;
    ```

1. Update the data in the tables.

    ```sql
    UPDATE inventory SET quantity = 200 WHERE name = 'banana';
    ```

## DBeaver

DBeaver is an open source multi-platform database tool which supports PostgreSQL, MySQL, SQLite, Oracle, DB2, SQL Server, and MS Access, plus others. The community edition is free to [download](https://dbeaver.io/download/). The Enterprise Edition is a paid for version, with a trial version available.

## Azure Data Studio

Azure Data Studio is a cross-platform database tool that works with on-premises and cloud-based data services. It is available for Windows, macOS, and Linux. Azure Data Studio is open source, and the source code is available on GitHub with the rights to modify and use the software.

Using Azure Data Studio you can connect, query, and manage your on-premises PostgreSQL servers, and Azure Database for PostgreSQL servers. Azure Data Studio can also be used with other relational databases, such as Microsoft SQL Server.
