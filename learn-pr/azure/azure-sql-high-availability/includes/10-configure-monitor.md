Now that you know about all the possibilities, you'll need to create a strategy for the specific workload which your Azure SQL Database or Azure SQL Managed Instance is a part of.

## Making the right choices

A large part of this process is stepping back and thinking about the requirements of your workload. Some questions to consider include:

- Do you need long-term backups? Or is 1-35 days long enough?
- What are your RTO and RPO needs?
- After reviewing the SLA, what service tier makes the most sense?
- Do you need Availability Zones?
- Do you need geo-replicated HADR or failover groups?
- Is your application ready?

The answers to these questions will help you in narrowing down what configuration you should deploy to meet your availability requirements.

The last question, *Is your application ready?*, if often overlooked by the data professional. However, this consideration is crucial to actually achieving the SLA you desire. You need to make sure that not only your database is meeting your availability requirements, but also that your application is meeting those requirements. Additionally, you'll want to make sure that the connectivity between the data and the application(s) meets your requirements. As an example, if your application and database are in different regions, this will increase the network latency. You should, as a best practice, place your application and data as close together as possible. Throughout the module, you've also seen how important implementing retry logic in your applications is to maintaining availability.

## Monitoring availability

Azure SQL provides several tools and capabilities to monitor certain aspects of availability. This includes using the Azure portal, T-SQL, and interfaces such as PowerShell, az CLI, and REST APIs.

Some of the examples of using these tools to monitor availability include:

### Region and data center availability

The availability of regions and data centers is critical for the availability of a Managed Instance or Database deployment. **Azure status** and **Azure Service Health** are key to understanding any outages for a data center or region including specific services such as Azure SQL.

Azure status is a dashboard showing any service impacting issues across Azure global regions. An RSS feed is available to get notification of any change to Azure status.

You can view Azure Service Health through the Azure portal, which includes service issues, planned maintenance events, health advisories, and health history. You also have the ability to set up alerts to notify you through email or SMS for any event that might affect availability.

### Instance, server, and database availability

Aside from Azure service impacting events, you can view the availability of your Azure SQL Managed Instance or Azure Database Server and databases through the Azure portal.

One of the primary methods to view a possible reason for a Managed Instance or Database to not be available is by examining **Resource Health** through the Azure portal or REST APIs.

You can always use standard SQL Server tools such as SQL Server Management Studio to connect to a Managed Instance or Database server and check the status of these resources through the tool or T-SQL queries.

In addition, interfaces such as **az CLI** can show the status of Azure SQL such as:

- **az sql mi list** - List the status of managed instances
- **az sql db list** - List the status of Azure SQL Databases

PowerShell commands can also be used to find out the availability of an Azure SQL Database such as:

- **Get-AzSQLDatabase** - Get all the databases on a server and their details including status
- **REST APIs**, although not as simple to use, can also be used to get the status of Managed Instances and Databases.

### Backup and restore history

Azure SQL automatically backs up databases and transaction logs. Although standard backup history is not available, **Long-term backup retention history** can be viewed through the Azure portal or CLI interfaces. Additionally, Azure SQL Managed Instance supports using XEvents to track the backup history.

Any restore of a database using Point in time restore results in the creation of a new database so the history of restore can be viewed as looking at the creation of a new database. All operations to create a new database can be viewed through Azure Activity Logs.

### Replica status

Replicas are used for Business Critical service tiers. You can view the status of a replica through the DMV **sys.dm_database_replica_states**.

### Failover reasons

To check the reasons for a failover event for Azure SQL Managed Instance or database deployment, check the Resource Health through the Azure portal or REST APIs.

### System Center Management Pack for Azure SQL

System Center provides management packs to monitor Azure SQL Managed Instance and Azure SQL Database. Consult the management pack documentation for requirements and usage.
