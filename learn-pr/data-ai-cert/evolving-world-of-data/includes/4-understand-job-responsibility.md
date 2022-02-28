Your skills need to evolve from managing on-premises database server systems, such as SQL Server, to managing cloud-based data systems. If you're a SQL Server professional, over time you'll focus less on SQL Server and more on data in general. You'll be a *data engineer*. 

SQL Server professionals generally work only with relational database systems. Data engineers also work with unstructured data and a wide variety of new data types, such as streaming data.

To master data engineering, you'll need to learn a new set of tools, architectures, and platforms. As a SQL Server professional, your primary data manipulation tool might be T-SQL. As a data engineer, you might use other technologies, like Azure HDInsight and Azure Cosmos DB. To manipulate the data in big-data systems, you might use languages such as HiveQL or Python.  

## Change data processes

As a data engineer you'll *extract* raw data from a structured or unstructured data pool and migrate it to a staging data repository. Because the data source might have a different structure than the target destination, you'll transform the data from the source schema to the destination schema. This process is called *transformation*. You'll then *load* the transformed data into the data warehouse. Together, these steps form a process called extract, transform, and load (ETL). 

A disadvantage of the ETL approach is that the transformation stage can take a long time. This stage can potentially tie up source system resources. This process is typically used for ingesting data from an on-premises database to an on-premises data warehouse.

An alternative approach is extract, load, and transform (ELT). In ELT, the data is immediately extracted and loaded into a large data repository, such as Azure Cosmos DB or Azure Data Lake Storage. This change in process reduces the resource contention on source systems. Data engineers can begin transforming the data as soon as the load is complete. 

ELT also has more architectural flexibility to support multiple transformations. For example, how the marketing department needs to transform the data can be different than how the operations department needs to transform that same data. This process is typically used for ingesting data from an on-premises database into the cloud.

## Move from implementing to provisioning servers

SQL Server professionals typically work with versions of on-premises SQL Server to meet the data requirements of their organization. They install and configure servers and services to provide the infrastructure to support a solution. This process can take days to complete. In high-availability environments, the process can even take weeks.

Azure reduces the complexity of building and deploying servers. As a data engineer, you'll use a web user interface for simple deployments. For more complex deployments, you can create and automate powerful scripts. In less time than it takes to read this module, you can set up a database that's globally distributed, sophisticated, and highly available. You spend less time setting up services, and you focus more on security and on deriving business value from your data.
