

You work as a database engineer supporting cloud-based databases in Azure. Your organization recently deployed Azure Database for PostgreSQL and you need to understand how to view system information in the Azure Database for PostgreSQL databases.

Relational databases can store vast quantities of data, but they also need to hold information about the structure of that data. For an operational database management system (DBMS) information about the structure of tables, and all other objects, security, and concurrency, among many other settings and metrics, is required. This information is known as metadata and is stored in system catalogs in Azure Database for PostgreSQL. In addition to directly accessing system catalogs, you can access system views, which present the data from system catalogs in more understandable or useful ways.

Whenever an insert or delete operation is performed in the database, the old row isn't physically deleted, but marked for deletion. Marking these rows can result in database "bloat" with old rows taking up disk space. PostgreSQL includes a server process to reclaim lost space called **vacuum**.

In this module, we look at how we can optimize our administration of PostgreSQL database systems through the effective use of system views and the vacuum process.

## Learning objectives

After completing this module, you'll be able to:

- Describe system catalogs and system views in Azure Database for PostgreSQL.
- Investigate metadata in Azure Database for PostgreSQL.
- Explain the purpose of the vacuum process.
- Configure vacuum server parameters.

## Prerequisites

- Demonstrate an understanding of relational databases.
- Demonstrate an understanding of basic SQL.
