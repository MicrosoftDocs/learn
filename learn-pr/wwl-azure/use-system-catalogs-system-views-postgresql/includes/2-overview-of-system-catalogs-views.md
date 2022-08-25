When most people think about a database, they think about the useful information that it contains, whether that is sales orders, employee records, meteorological information, or any of the countless silos of data that we now require. There is also another form of data, called metadata. Metadata is defined as data about data and includes all of the structural information about database objects as well as performance data, storage data, security data, and any other information that needs to be stored about the user data.

Metadata is essential to ensure the optimum performance and security of a database. It enables you to list the users that are connected, transaction information and locks, performance data, and index usage amongst many other useful metrics and values.

In PostgreSQL, metadata is stored in the **pg_catalog** system schema. The **pg_catalog** schema, the catalog tables, and catalog views are automatically created when you create a database.

## System information in Azure Database for PostgreSQL Hyperscale (Citus)

Azure Database for PostgreSQL Hyperscale (Citus) is a scalable database solution that runs over multiple nodes. Because of its distributed nature, Azure Database for PostgreSQL Hyperscale (Citus) has additional system tables to maintain the distributed structure and for the coordinator node to plan how to send queries to the worker nodes.

For more information about system information in Azure Database for PostgreSQL Hyperscale (Citus), see [System tables and views](/azure/postgresql/hyperscale/reference-metadata).