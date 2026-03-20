In this module, you built a decision framework for choosing between the three primary analytical data stores in Microsoft Fabric:

- **Lakehouse** for mixed data formats, Spark-based engineering, and data science workloads with dual access through Spark and a read-only SQL analytics endpoint.
- **Warehouse** for SQL-first teams building dimensional models with full T-SQL DML support, multi-table ACID transactions, and strict schema governance.
- **Eventhouse** for streaming and time-series data with KQL-powered real-time dashboards, IoT telemetry, and log analysis.

These stores aren't mutually exclusive—many Fabric solutions use multiple stores together, connected through OneLake shortcuts and cross-database queries. Your data store choice also affects AI readiness, so metadata quality is as important as data quality when preparing for AI.

You also learned that Fabric includes SQL database in Fabric and Cosmos DB in Fabric for operational purposes such as OLTP workloads, application backends, and low-latency NoSQL access. These workloads serve different needs than the analytical data stores covered in this module.

By evaluating data format, query language, write patterns, team skills, and workload type, you can make informed recommendations that set the foundation for a well-architected analytics solution.

## Further reading

- [Microsoft Fabric decision guide: choose a data store](/fabric/fundamentals/decision-guide-data-store)
- [Choose between Warehouse and Lakehouse](/fabric/fundamentals/decision-guide-lakehouse-warehouse)
- [Eventhouse overview](/fabric/real-time-intelligence/eventhouse)
