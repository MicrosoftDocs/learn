Databricks Delta is a transactional storage layer designed specifically to harness the power of Apache Spark and Databricks DBFS. The core abstraction of Databricks Delta is an optimized Spark table that stores your data as Parquet files in DBFS and maintains a transaction log that efficiently tracks changes to the table.

## The challenge with Data Lakes

A Data Lake is a storage repository that inexpensively stores a vast amount of current and historical raw data in its native format such as XML, JSON, CSV, and Parquet. Tt may contain operational relational databases with live transactional data.

Extracting meaningful information from a Data Lake involves solving several problems such as:

- Schema enforcement when new tables are introduced
- Table repairs when any new data is inserted into the data lake
- Frequent refreshes of metadata
- Bottlenecks of small file sizes for distributed computations
- Difficulty re-sorting data by an index if data is spread across many files and partitioned

## The solution: Databricks Delta

Databricks Delta is a Spark table with built-in reliability and performance optimizations.

You can read and write data stored in Databricks Delta using the same familiar Apache Spark SQL batch and streaming APIs you use to work with Hive tables or DBFS directories. Databricks Delta provides the following functionality:

- **ACID transactions** - Multiple writers can simultaneously modify a data set and see consistent views.
- **DELETES/UPDATES/UPSERTS** - Writers can modify a data set without interfering with jobs reading the data set.
- **Automatic file management** - Data access speeds up by organizing data into large files that can be read efficiently.
- **Statistics and data skipping** - Reads are 10-100x faster when statistics are tracked about the data in each file, allowing Delta to avoid reading irrelevant information.

## Databricks Delta architecture vs Lambda architecture

### Lambda architecture

The Lambda architecture is a big data processing architecture that combines both batch- and real-time processing methods. It features an append-only immutable data source that serves as system of record. Timestamped events are appended to existing events (nothing is overwritten). Data is implicitly ordered by time of arrival.

Notice how there are really two pipelines here, one batch and one streaming, hence the name lambda architecture.

It is very difficult to combine processing of batch and real-time data as is evidenced by the diagram below.

![An image showing the Lambda architecture](../media/lambda.png)

### Databricks Delta architecture

The Databricks Delta Architecture is a vast improvement upon the traditional Lambda architecture.

Text files, RDBMS data and streaming data is all collected into a raw table (also known as "bronze" tables at Databricks).

A Raw table is then parsed into query tables (also known as "silver" tables at Databricks). They may be joined with dimension tables.

Summary tables (also known as "gold" tables at Databricks) are business level aggregates often used for reporting and dashboarding. This would include aggregations such as daily active website users.

The end outputs are actionable insights, dashboards and reports of business metrics.

![An image showing the Databricks Delta architecture](../media/delta.png)