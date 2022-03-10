## Azure SQL Managed Instance

Azure SQL Managed Instance is a PaaS deployment option of Azure SQL. It provides an instance of SQL Server, but removes much of the overhead of managing a virtual machine. Most of the features available in SQL Server are available in SQL Managed Instance.

SQL Managed Instance is ideal for customers who want to use instance-scoped features and want to move to Azure without re-architecting their applications.

 

SQL Managed Instance instance-scoped features include:

- SQL Server Agent

- Service Broker

- Common language runtime (CLR)

- Database Mail

- Linked servers

- Distributed transactions (preview)

- Machine Learning Services

Let us explore at another industry scenario. Komatsu is a manufacturing company that produces and sells heavy equipment for construction. The company had multiple mainframe applications for different types of data.

Komatsu wanted to consolidate these applications to get an overall view. Additionally, Komatsu wanted a way to reduce overhead.

Because the company uses a large surface area of SQL Server features, the IT department chose to move to Azure SQL Managed Instance. They were able to move about 1.5 terabytes of data smoothly and get the following benefits:

- Automatic patching and version updates

- Automated backups

- High availability

- Reduced management overhead

The following image shows Komatsu's challenge and their Azure solution consideration.

 

:::image type="content" source="../media/sql-managed-instance.png" alt-text="How Komatsu used SQL Managed Instance to solve business problems.":::



## Scalability for Azure SQL Managed Instance

- SQL Managed Instance uses vCores mode and enables you to define maximum CPU cores and maximum of storage allocated to your instance. All databases within the managed instance will share the resources allocated to the instance.

 
Review this [comparison of SQL Database and SQL Managed Instance](/azure/azure-sql/database/features-comparison) 