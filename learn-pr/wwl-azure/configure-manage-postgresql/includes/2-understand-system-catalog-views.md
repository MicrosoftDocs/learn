
When most people think about a database, they think about the useful information that it contains. This data could be sales orders, employee records, meteorological information, or any of the countless silos of data that we now require. There's also another form of data, called metadata. Metadata is defined as data about data and includes all of the structural information about database objects. The metadata also includes performance data, storage data, security data, and any other information that needs to be stored about the user data.

Metadata is essential to ensure the optimum performance and security of a database. It enables you to list the users that are connected, transaction information and locks, performance data, and index usage among many other useful metrics and values.

In PostgreSQL, metadata is stored in the **pg_catalog** system schema. The **pg_catalog** schema, the catalog tables, and catalog views are automatically created when you create a database.
