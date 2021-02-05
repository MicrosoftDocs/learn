Now that you know about all the possibilities, you need to create a strategy for the specific workload that your Azure SQL database or Azure SQL managed instance is a part of.

## Make the right choices

A large part of creating a strategy is stepping back and thinking about the requirements of your workload. Here are some questions to consider:

- Do you need long-term backups? Or is 1-35 days long enough?
- What are your RTO and RPO needs?
- Based on the SLA, what service tier makes the most sense?
- Do you need Availability Zones?
- Do you need geo-replicated HADR or failover groups?
- Is your application ready?

The answers to these questions will help you narrow down the configuration you should deploy to meet your availability requirements.

The last question is often overlooked by the data professional: *Is your application ready?* This consideration is crucial to achieving the SLA that you want. 

You need to make sure your database is meeting your availability requirements. But you also need to be sure your application is meeting those requirements. And you need to make sure the connectivity between the data and the applications meets your requirements. For example, if your application and database are in different regions, that placement will increase network latency. Place your application and data as close together as possible. Throughout this module, you've also seen how important implementing retry logic in your applications is for maintaining availability.

## Monitor availability

Azure SQL provides several tools and capabilities to monitor certain aspects of availability. These tools include the Azure portal, T-SQL, and interfaces like PowerShell, az CLI, and REST APIs.

The following sections describe some examples of using these tools to monitor availability.

### Region and datacenter availability

The availability of regions and datacenters is critical for the availability of a managed instance or a database deployment. *Azure status* and *Azure Service Health* are key to understanding any outages for a datacenter or region, including specific services like Azure SQL.

Azure status is a dashboard that shows any service that's causing problems in any Azure global region. You can use an RSS feed to get notifications of changes to Azure status.

You can view Azure Service Health in the Azure portal. Azure Service Health provides information about service problems, planned maintenance events, health advisories, and health history. You can also set up alerts that notify you through email or SMS of any event that might affect availability.

### Instance, server, and database availability

In addition to Azure service events, you can also view the availability of your Azure SQL Managed Instance or Azure SQL Database databases in the Azure portal.

One way to view a possible reason for a managed instance or database to be unavailable is to examine resource health by using the Azure portal or REST APIs.

You can always use standard SQL Server tools like SQL Server Management Studio to connect to a managed instance or database server and check the status of these resources. You can use the tool or T-SQL queries.

And interfaces like az CLI can show the status of Azure SQL. For example:

- `az sql mi list` lists the status of managed instances.
- `az sql db list` lists the status of Azure SQL databases.

You can also use PowerShell commands to determine the availability of an Azure SQL database. For example:

- `Get-AzSQLDatabase` gets all the databases on a server and their details, including status.
- REST APIs aren't as easy to use, but you can use them to get the status of managed instances and databases.

### Backup and restore history

Azure SQL automatically backs up databases and transaction logs. Standard backup history isn't available, but you can view long-term backup retention history by using the Azure portal or CLI interfaces. Also, in Azure SQL Managed Instance, you can use XEvents to track backup history.

Any database restore that uses point in time restore creates a new database. You can use the Azure Activity Log to view operations that create databases.

### Replica status

Replicas are used for Business critical service tiers. You can view the status of a replica by using the DMV **sys.dm_database_replica_states**.

### Failover causes

To determine the cause of a failover event for an Azure SQL Managed Instance or database deployment, check the resource health by using the Azure portal or REST APIs.

### System Center Management Pack for Azure SQL

System Center provides management packs to monitor Azure SQL Managed Instance and Azure SQL Database. See the management pack documentation for requirements and details.
