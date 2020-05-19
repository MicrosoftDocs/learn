There are two common types of solution workloads that can be supported by Azure Synapse Analytics.

## Modern Data Warehouse workloads: 

A Modern Data Warehouse is a centralized data store that provides analytics and decision support services across the whole enterprise using structured, unstructured, or streaming data sources. Data flows into the warehouse from multiple transactional systems, relational databases, and other data sources on a periodic basis. The stored data is used for historical and trend analysis reporting. The data warehouse acts as a central repository for many subject areas and contains the "single source of truth."

SQL Analytics stores data in relational tables with columnar storage. This format significantly reduces the data storage costs, and improves query performance. Once data is stored, you can run analytics at massive scale. Compared to traditional database systems, analysis queries finish in seconds instead of minutes, or hours instead of days.

> [!TIP]
> A data warehouse is useful to reduce stress on production systems and to reorganize, index, or filter multiple data sources into a single storage area. To accomplish this goal, deliberate thought and design needs to be put into how you organize and structure the data. It's not a dumping ground for tables from various sources without any design put into it.

## Advanced Analytical Workloads

You can perform advanced analytics in the form of predictive or preemptive analytics using Azure Synapse Analytics. Using the tight integration with Spark, and the hybrid data integration engine with Data Integration. In a cloud data solution, data is ingested into big data stores from a variety of sources. Once in a big data store, Hadoop, Spark, and machine learning algorithms prepare and train the data. When the data is ready for complex analysis, SQL Analytics uses PolyBase to query the big data stores.

PolyBase uses standard T-SQL queries to bring the data into SQL Analytics tables. As a result, the worlds of the Modern Data Warehouse and the Advanced Analytical Workloads are brought together
