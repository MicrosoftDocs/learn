

Data engineers in Microsoft Azure typically use a variety of programming languages and tools to build and manage data pipelines. Some of the most popular programming languages used in Azure are:

### Common scripting languages

- **SQL:** SQL is a popular language used to extract and transform data from various sources such as databases, data lakes, and cloud services. SQL is used to write queries to extract data and perform data cleaning and transformation tasks.

- **Python:** Python is a popular language for data engineers in Azure due to its large ecosystem of libraries and frameworks for data processing and machine learning. Popular libraries and frameworks used in Azure include Pandas, NumPy, and PySpark.

- **Scala:** Scala is a popular language used in Azure Databricks, which is a powerful big data analytics platform that allows data engineers to process large amounts of data in parallel.

- **.NET:** .Net is a popular language used by data engineers in Azure to build and manage data pipelines using Azure Data Factory, and also to write custom code in the pipelines using the .NET SDK.

- **Java:** Java is a popular language used by data engineers in Azure to build and manage data pipelines using Azure Data Factory, and also to write custom code in the pipelines using the Java SDK.

In addition to programming languages, data engineers in Azure also use a variety of tools and services to build and manage data pipelines, such as:

### Data Pipeline Tools

- **Azure Data Factory:** A fully managed data integration service that allows data engineers to create, schedule, and manage data pipelines.

- **Azure Stream Analytics:** A real-time data stream processing service that allows data engineers to perform complex data processing and analytics tasks on data streams.

### Data Collaboration tools

- **Azure Databricks:** A powerful big data analytics platform that allows data engineers to process large amounts of data in parallel using Spark.

- **Azure Synapse Analytics:** A cloud-based data integration, analytics, and data warehousing service that allows data engineers to create, schedule, and manage data pipelines.

### Data governanace

- **Azure Purview:** A data governance solution that allows data engineers to discover, understand, and govern data across various data sources.

### Storage

- **Azure Data Lake** Still referred to as Gen 2, but has hierarchical support that provides support for analytical data stored in a file based format, can include CSV, Avro, Parquet, and others.
- Azure data lake is a distributed file system built upon the hadoop data file system (HDFS).

### Streaming Data

- **Azure Stream Analytics** gives us perpetual real-time feeds and easily integrates with IoT Event Hubs and Azure Event Hubs.
- **Azure Data Bricks** First party solution that has streaming capabilities within the service which is built upon Apache Spark.

### Data Warehouse
Azure Synapse Analytics (formerly known as SQL Data Warehouse) is a cloud-based data integration, analytics, and data warehousing service provided by Microsoft Azure.

- Provides a relational database to store analytical data with near-linear scalability
- Typically modeled as a star schema to optimize summary analysis; however, is warehouse agnostic and can easily support third normal form (3NF) warehouses.

### Apache Spark
Used in Azure Databricks and in Azure Synapse Analytics for some of the distributed data processing. It is worthy to note that Azure Synapse Analytics is a distributed data warehouse and Spark is an alternative approach that adds flexibility to organization needs.
