
Microsoft offers the most popular open-source database platforms MySQL, MariaDB, and PostgreSQL on the Azure platform. The architecture and features are similar to that of the Azure SQL Database, but running different database engines. An additional benefit of these solutions is that they tightly integrate with other services like Azure Web Apps. 
 
## MySQL and Postgres network connectivity

Similar to Azure SQL Database there is a firewall that can be set for specific IP address or range of IP addresses, or you can configure a virtual network endpoint to allow connections from an Azure Virtual Network.

## Query Store on Postgres

One of the value-added features of PostgreSQL on the Azure platform is the query store, which is very similar to the query store feature in Azure SQL Database and Azure SQL Managed Instance. The query store keeps track of both query execution runtime statistics and wait stats, although implementation is slightly different compared to SQL Database. The query store data is stored in the azure_sys database on your Postgres server, in the query_store schema. 

![Query Performance Insight in Azure Portal for PostgreSQL](../../Linked_Image_Files/module-11-azure-dba-final-03.png)

*Figure 4 Query Performance Insight in Azure Portal for PostgreSQL*

As seen in figure 4, the query store data drives the Query Performance Insight dashboard in the Azure Portal, offering a quick way to identify expensive queries in your service.