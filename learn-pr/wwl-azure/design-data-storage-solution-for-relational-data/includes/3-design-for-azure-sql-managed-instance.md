Azure SQL Managed Instance is a PaaS deployment option of Azure SQL. As with Azure SQL Database, Azure SQL Managed Instance is a fully managed service. It provides an instance of SQL Server, but removes much of the overhead of managing a virtual machine. 
 
### Things to know about Azure SQL Managed Instance

Review the following characteristics of the SQL Managed Instance deployment option.

- You can use SQL Managed Instance to do lift-and-shift migrations to Azure without having to redesign your applications.

- Azure SQL Managed Instance is ideal for customers interested in instance-scoped features, such as SQL Server Agent, Common language runtime (CLR), Database Mail, Distributed transactions, and Machine Learning Services.

- SQL Managed Instance uses vCores mode. You can define the maximum CPU cores and maximum storage allocated to your managed instance. All databases within the managed instance share the resources allocated to the instance.

- Most of the features available in SQL Server are available in SQL Managed Instance. Review this [comparison of SQL Database and SQL Managed Instance](/azure/azure-sql/database/features-comparison).

#### Business scenario

Let's explore a business scenario for Azure SQL Managed Instance. Komatsu is a manufacturing company that produces and sells heavy equipment for construction. The company had multiple mainframe applications for different types of data. Komatsu wants to consolidate these applications to get an overall view. Additionally, Komatsu wants a way to reduce overhead. Because the company uses a large surface area of SQL Server features, the IT department wants to move to Azure SQL Managed Instance. They were able to move about 1.5 TB of data smoothly and gained many benefits. With the deployment to Azure SQL Managed Instance, the company gains automatic patching and version updates, automated backups, high availability, and reduced management overhead.

:::image type="content" source="../media/sql-managed-instance.png" alt-text="Illustration that shows a business scenario for Azure SQL Managed Instance." border="false":::

### Things to consider when using Azure SQL Managed Instance

Consider how Azure SQL Managed Instance can be included in your relational data storage plan for Tailwind Traders:

- **Consider instance-scoped features**. Use instance-scoped features of Azure SQL Managed Instance like Service Broker, CLR, SQL Server Agent, and Linked servers. Migrate your relational and structured data to Azure without rearchitecting your applications. 

- **Consider instance scalability**. Add scalability for your instance by enabling vCores mode. You can define the maximum CPU cores and storage for your instances, so all databases in the instance share the same resources.