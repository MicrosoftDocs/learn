In this module, you learned how to identify data modeling problems and apply schema design patterns to solve them in Azure DocumentDB.

Your e-commerce team's initial data model handled basic operations, but performance gaps emerged as traffic grew. You addressed those gaps by applying 10 schema design patterns organized by the problem they solve.

To optimize document structure, you used the inheritance pattern for a polymorphic product catalog, the computed pattern for precomputed engagement metrics, and the approximation pattern for high-frequency counters. To reduce lookups and manage change, you applied the extended reference pattern for order and product pages and the schema versioning pattern for downtime-free schema evolution.

For complex data scenarios, you applied five more patterns. The single collection pattern unified event timelines. The subset pattern bounded review arrays while keeping full data accessible. The bucket pattern grouped time-series data. The outlier pattern handled popular products differently from the norm. The archive pattern managed data lifecycle.

You can now evaluate data modeling challenges in your Azure DocumentDB application and select the right pattern based on access patterns, data volume, update frequency, and lifecycle requirements.

## Learn more

- [What is Azure DocumentDB?](/azure/documentdb/overview)
- [MongoDB feature compatibility in Azure DocumentDB](/azure/documentdb/compatibility-features)
- [Indexing best practices in Azure DocumentDB](/azure/documentdb/how-to-create-indexes)
