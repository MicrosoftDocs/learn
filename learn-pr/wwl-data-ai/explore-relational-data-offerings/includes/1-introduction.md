A database is a collection of data. A database can be as simple as a desktop spreadsheet, or as complex as a global system holding petabytes of highly structured information. The data can be structured in many different ways. A common approach is to store data in a tabular format, with rows and columns. You can define relationships between tables. These databases are called *relational* databases.

Databases can also be semi-structured or unstructured, comprising of semi-processed or unprocessed data. These databases are typically referred to as *non-relational*. Databases are managed using a database management system (DBMS). The DBMS handles the physical aspects of a database, such as where and how it's stored, who can access it, and how to ensure that it's available when required.

Many organizations depend on the information stored in their databases to help make critical business decisions. In the past, these organizations ran their DBMSs on-premises. However, this approach requires the organization to maintain its own hardware infrastructure. Therefore, an increasing number of businesses are migrating their databases to the cloud, where the costs of configuring and maintaining the infrastructure are highly reduced. 

Suppose you're a database administrator at Wide World Importers. You're responsible for database design and maintenance, as well as providing information for leadership and creating customer lists for the marketing department. You have an existing SQL Server database that relies heavily on stored procedures and other advanced database features such as linked servers. The database is situated on your internal network. You've been asked to make it globally available to your partners worldwide.

> [!NOTE]
> A *stored procedure* is a block of code that runs inside your database. Applications often use stored procedures because they are optimized to run in the database environment, and can access data very quickly. 
> A *linked server* is a connection from one database server to another. SQL Server can use linked servers to run queries on one server that can include data retrieved from other servers; these are known as *distributed queries*. 

In this module, you'll explore the options available when choosing a relational data platform for hosting a database in Azure.

## Learning objectives

In this module, you will:

* Identify relational Azure data services
* Explore considerations in choosing a relational data service
