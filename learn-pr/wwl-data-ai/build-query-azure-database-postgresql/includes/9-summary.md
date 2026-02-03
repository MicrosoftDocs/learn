In this module, you learned how to use Azure Database for PostgreSQL as a data foundation for AI applications. You explored the service architecture, including compute tiers, high availability options, and managed capabilities such as automated backups, PgBouncer connection pooling, and server extensions. You established secure connections using Microsoft Entra authentication with DefaultAzureCredential and configured TLS encryption for data in transit. You designed database schemas with tables, constraints, and data types suited for AI workloads, including JSONB for flexible structured data and appropriate indexes for query performance.

You also learned SQL techniques for querying and manipulating data, including filtering with WHERE clauses and JSONB operators, joining tables, using aggregation with GROUP BY, and building reusable queries with Common Table Expressions. You integrated PostgreSQL into Python applications using the psycopg library, implementing parameterized queries, connection management, and error handling. Finally, you built a practical AI agent tool backend that persists conversation history and task state, demonstrating how these concepts work together in a real scenario.

## Additional resources

Use the following resources to learn more about Azure Database for PostgreSQL and related topics:

- [Azure Database for PostgreSQL documentation](/azure/postgresql/)
- [Connect and query with Python (psycopg)](/azure/postgresql/flexible-server/connect-python)
- [Microsoft Entra authentication with Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication)
- [PostgreSQL data types documentation](https://www.postgresql.org/docs/current/datatype.html)
