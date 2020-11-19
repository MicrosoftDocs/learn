Since Synapse Analytics comes with the capabilities of two strong engines, that is, SQL and Spark, it is imperative to understand what the differences are. 

When it comes to Synapse SQL, it is imperative to know that it is a complete T-SQL based analytics platform as well as T-SQL based compute and storage capabilities. 
It enables you to load, model, and process data with a SQL engine. 
Synapse SQL consists of two types of SQL Pools:
* Dedicated SQL pool (pay per DWU provisioned) – Generally Available
* Serverless SQL pool (pay per TB processed) – (Preview)

The difference with the Apache Spark pool is that it proved open-source Apache Spark based big data compute capabilities, running on a Spark engine version 2.4. It is integrated deeply with Apache Spark, which is based on Spark Core concepts in which Spark SQL is built on. 

The dedicated SQL Pool in Synapse SQL is referred to as the enterprise data warehousing engine with all its features and is generally available in Azure Synapse Analytics. It is based on a collection of analytical resources that are provisioned when using Synapse SQL. The size of the pool is determined by Data Warehousing units (DWU).

The sizing of a SPark Pool is done through node sizing as well as configuring the nr of nodes, in which if configured, you can autoscale between. 

With Synapse SQL, which enabled you to decouple storage and compute, using Synapse SQL pool you can:

* Independently size compute power irrespective of your storage needs.
* Grow or shrink compute power, within a SQL pool (data warehouse), without moving data.
* Pause compute capacity while leaving data intact, so you only pay for storage.
* Resume compute capacity during operational hours.

The use case for using apache spark, is related to big data, where maybe in a calculation that sometimes could take much time with SQL, you'd prefer to run that calculation on a Spark Pool. 

Synapse Spark is a capability of Spark embedded in Azure Synapse Analytics in which organizations that don’t have existing spark implementations yet, give the functionality to spin up a spark cluster to meet data engineering needs without the overhead of the other Spark Platforms listed. Data Engineers, Data scientist, Data Platform Experts, and Data Analyst can come together within Synapse Analytics where the Spark cluster is spun up quickly to meet the needs. It provides scale in an efficient way for Spark Clusters and integrates with the one stop shop Data warehousing platform of Synapse. 


