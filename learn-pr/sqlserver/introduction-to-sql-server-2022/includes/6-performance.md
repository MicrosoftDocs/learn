[SQL Server 2025](/sql/database-engine/sql-server-database-engine-overview) includes improvements to query processing and performance optimization. This unit covers query processing features, resource governance, and maintenance capabilities.

## Optimize query processing with IQP

SQL Server 2025 takes [Intelligent Query Processing (IQP)](/sql/relational-databases/performance/intelligent-query-processing) to the next level by combining traditional plan optimization with AI-driven insights and support for modern data types. These enhancements allow the engine to adapt dynamically to workload patterns, optimize queries involving JSON and RegEx, and even fine-tune execution strategies using machine learning. For developers and DBAs, this means faster queries, better concurrency, and improved performance for real-time analytics and semi-structured data—all without manual tuning.

The query processor optimizes execution plans based on workload patterns and system resources. Key improvements include:

| Feature | Description | Benefit |
|---------|-------------|----------|
| Optimized locking | Enhanced concurrency control mechanisms | Improved multi-user access |
| Halloween protection | Streamlined update/delete operations | Reduced overhead for modifications |
| Plan reuse | Better sp_executesql implementation | More consistent dynamic SQL performance |
| Adaptive execution | Runtime plan adjustments | Optimal performance for varying data |
| [Optional Parameter Plan Optimization (OPPO)](/sql/relational-databases/performance/optional-parameter-optimization) | Chooses optimal plan at runtime based on NULL vs. NOT NULL parameters | Improves performance for queries with optional parameters |
| [Cardinality Estimation (CE) feedback for expressions](/sql/relational-databases/performance/intelligent-query-processing-ce-feedback-for-expressions) | Learns from previous executions to refine cardinality estimates for repeated expressions | More accurate estimates, better plan selection |
| [`OPTIMIZED_SP_EXECUTESQL`](/sql/relational-databases/system-stored-procedures/sp-executesql-transact-sql) | Reduces compilation storms by treating sp_executesql like stored procedures for compilation | Improves stability and performance under heavy query loads| 

## Monitor performance with Query Store

[Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) helps track query performance over time and detect regression issues.

Query Store capabilities in SQL Server 2025 include: 

- **Performance monitoring on secondary replicas**
   - Track query performance on readable secondaries
   - Support for Always On availability groups
   - Consistent monitoring in distributed environments

- **Automatic query optimization**
   - Detection and correction of query regressions
   - Index recommendations based on query patterns
   - Plan improvement suggestions

- **Distributed workload insights**
   - Cross-database query monitoring
   - Performance tracking across replicas
   - Resource usage analysis

> [!TIP]
> Enable Query Store on your most active databases to build a performance baseline and identify optimization opportunities.

## Implement advanced query features

SQL Server 2025 makes advanced query features simple and powerful. These enhancements include parameter-sensitive plan optimization, cardinality estimation feedback, adaptive parallelism, and batch mode improvements for analytics. Developers also gain finer control with optional parameter plans and new query hints, reducing manual intervention while ensuring queries run efficiently across diverse workloads.

Use these features to address specific performance scenarios in your database applications.

SQL Server 2025 includes these query processing improvements:

- **Parameter Sensitive Plan (PSP) optimization:** Automatically creates and maintains multiple execution plans based on parameter value patterns, improving performance for queries with varying parameter values
- **Degree of Parallelism (DOP) feedback on by default:** Automatically adjusts parallel execution settings based on historical query performance, optimizing resource utilization
- **Batch mode optimizations for analytics:** Enhances analytical query performance through improved vectorized operations and memory efficiency
- **Optional parameter plans optimization:** Generates efficient execution plans for queries with optional parameters, reducing the need for dynamic SQL
- **ABORT_QUERY_EXECUTION query hint:** Provides fine-grained control over query execution, allowing deliberate termination of specific operations

## Manage resources and maintenance

New capabilities that aim to boost reliability, speed, and ease of maintenance, while giving DBAs more control and reducing manual work. These capabilities give DBAs greater control over system resources, automate routine tasks, and minimize downtime during unexpected events.

Together, these features deliver greater efficiency and resilience for modern data environments.

- **Tempdb space resource governance:** Control and limit tempdb space usage per workload group, preventing runaway queries from consuming excessive temporary storage
- **Accelerated Database Recovery (ADR) in tempdb:** Fast recovery of tempdb after unexpected shutdowns, reducing database downtime and improving system availability
- **Support for tempdb in Linux:** Use memory-backed temporary file systems in Linux for improved tempdb performance and reduced I/O latency
- **Columnstore index maintenance improvements:** Enhanced maintenance operations for columnstore indexes, including better compression and more efficient segment elimination
- **Automated change tracking cleanup:** Automatic maintenance of change tracking tables, reducing manual overhead and ensuring optimal performance
- **Remove In-Memory OLTP from a database:** Simplified process to remove memory-optimized tables and natively compiled modules from databases when no longer needed
