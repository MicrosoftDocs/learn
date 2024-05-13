You can't directly interact with PostgreSQL on the server. You need a client interface. This interface could be an application, or a client tool used for development. There are many different database client tools that work with PostgreSQL. This unit introduces the most common client tools.

## Pgbench

Pgbench is a program for running benchmarking tests on PostgreSQL databases. It works by running the same SQL commands, or sequence of SQL commands many times over. It then calculates the average transaction rate, measured in seconds.

You can run default pgbench test that includes five SELECT, UPDATE, AND INSERT commands per transaction. You can also write your own script files.

The output from pgbench includes:

- Query mode
- Number of threads
- Number of transactions per client
- Number of transactions processed
- Latency average
- Initial connection time
- Transactions per second (without initial connection time)

To ensure that the results from pgbench are useful, use the -t or -T option to make the query run for a few minutes. You could need to run queries for hours to get numbers that are reproducible. Run the same test several times to find out how reliable the output statistics are.

Also, the default test is sensitive to the accumulation of dead rows in the tables. If **autovacuum** is enabled, it can result in changes to your measurements.

## pgAdmin

pgAdmin is a popular administration and development platform for PostgreSQL. It's open source and can be [downloaded](https://www.pgadmin.org/download/) and used without paying a license fee. pgAdmin works on Linux, Unix, macOS, and Windows and is available as a desktop app, or hosted by a web server.

## psql

**psql** is a command line utility that allows you to interact with a PostgreSQL server. It can be [downloaded](https://sbp.enterprisedb.com/getfile.jsp?fileid=1258893) as part of PostgreSQL. In the setup wizard, when you reach the **Select Components** dialog box, select **Command Line Tools**.

![Screenshot showing the Select Components dialog box.](../media/3-command-line-tools-setup.png)

You can then connect to your database using psql from a command prompt by typing:

    ```sql
    psql --host=<servername> --port=<port> --username=<user@servername> --dbname=<dbname>
    ```

## DBeaver

DBeaver is an open source multi-platform database tool, which supports PostgreSQL, MySQL, SQLite, Oracle, DB2, SQL Server, and MS Access, plus others. The community edition is free to [download](https://dbeaver.io/download/). The Enterprise Edition is a paid-for version, with a trial version available.

## Azure Data Studio

Azure Data Studio is a cross-platform database tool that works with on-premises and cloud-based data services. It's available for Windows, macOS, and Linux. Azure Data Studio is open source, and the source code is available on GitHub with the rights to modify and use the software.

Using Azure Data Studio you can connect, query, and manage your on-premises PostgreSQL servers, and Azure Database for PostgreSQL servers. Azure Data Studio can also be used with other relational databases, such as Microsoft SQL Server.
