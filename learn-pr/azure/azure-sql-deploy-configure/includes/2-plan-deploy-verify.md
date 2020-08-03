Once you've selected a workload to either migrate to or create in Azure SQL, you need to plan your deployment, deploy accordingly, and verify that the deployment was successful. In this unit, you'll learn various methods for each step in the process.  

### Pre-deployment planning

Before you start deploying things in Azure, it's important to understand what your requirements are and how they map to offerings in Azure SQL. Using what you learned in the Azure SQL introduction module, it's time to make a plan. You need to answer the following questions:

* Deployment method: Azure portal or command-line interfaces?
* Deployment option: VM, DB, Elastic Pool, MI, or Instance Pool?
* Purchasing model (Azure SQL Database only): DTU or vCore?
* Service tier (SLO): General purpose, business critical, or hyperscale?
* Hardware: Gen5, or something new?
* Sizing: number of vCores and data max size?  

In addition, and perhaps prior to answering the question above, you need to pick a workload that is either going to be migrated to Azure SQL or be "born in the cloud". If you are migrating, there are many tools and resources available to help you plan, assess, migrate, and optimize your database(s) and application. Resources are provided at the end of this module.  

#### Resource limit considerations

Aside from limits, rates, and capabilities discussed in the Azure SQL introduction module (like IOPS or In-Memory OLTP), there are other resource limits, which are affected by your choice of Azure SQL Managed Instance, Azure SQL Database, or options within these choices:  

* Memory
* Max log size
* Size of tempdb
* Max concurrent workers
* Backup retention

The limits for Azure SQL Managed Instance and Azure SQL Database are dependent on your choice of purchasing model, service tier, and number of vCores (or DTU in Azure SQL Database only). Within a General Purpose Azure SQL Database, your choice of Provisioned or Serverless compute will also affect these limits. You should review what's included in what you plan to deploy, before deploying, to ensure you are starting out with what you may need.  

It is also important to know that Azure SQL resources have overall resource limits *per subscription* and *per region*. If you need to increase your limits, it is possible to request a quota increase in the Azure portal.

## Deploy

Once you've completed your pre-deployment planning, it's time to put your plan into action. In this stage, you'll deploy Azure SQL (using the Azure portal or command-line), determine network configuration, and make an initial connection.  

For Azure SQL Database and Azure SQL Managed Instance, there are essentially five panes in the Azure portal to fill in during a deployment.  

:::image type="content" source="../media/2-deploy-panes.png" alt-text="Diagram of the deployment panes for Azure SQL." border="false":::

Let's dive into a few of these options.

### Server

When you create an Azure SQL Managed Instance, supplying the server name is the same as in SQL Server. However, for databases and elastic pools, an Azure SQL Database server is required. This is a *logical* server that acts as a central administrative point for single or pooled database and includes logins, firewall rules, auditing rules, threat detection policies, and failover groups (more on these topics later). This logical server does not expose any instance-level access or features as with Azure SQL Managed Instance. For Azure SQL Database servers, the server name must be unique across all of Azure.  

### Compute and storage

In the previous module of this learning path, you learned about the various options available and recommendations when it comes to compute and storage, including service tiers, purchasing models, and hardware generations. You'll have to select the desired configuration during deployment. Additionally, you must determine how many vCores and the Data max size.

Generally, if you're migrating, you should use a similar size as to what you use on-premises. You can also leverage tools, like the Data Migration Assistant SKU Recommender to estimate the vCore and Data max size based on your current workload.  

The Data max size is not necessarily the database size of your data today. It is the maximum amount of data space that can be allocated for your database. This will also help you understand the log space allocated, which scales with your data max size.  

### Networking configuration

Choices for networking for Azure SQL Database and Azure SQL Managed Instance are different. When you deploy an Azure SQL Database, currently the default is **No access**.  

You can then choose to select Public endpoint or Private endpoint. In the exercise that follows this unit, you'll use the public endpoint and set the **Allow Azure services and resources to access this server** option to yes, meaning that other Azure services (e.g. Azure Data Factory or an Azure Virtual Machine) can access the database if you configure it. You can also select **Add current client IP address** if you want to be able to connect from the IP address from the client computer you used to deploy Azure SQL Database.

With Azure SQL Managed Instance, you deploy it inside an Azure virtual network and a subnet that is dedicated to managed instances. This enables you to have a secure, private IP address. Azure SQL Managed Instance provides the ability to connect an on-prem network to a managed instance, connect a managed instance to a linked server or other on-prem data store, and connect a managed instance to other resources. You can additionally enable a public endpoint so you can connect to managed instance from the Internet without a Virtual Private Network (VPN). This access is disabled by default.  

### Data source

In Azure SQL Database, upon deployment you have the option to select the AdventureWorksLT database as the sample in the Azure portal. In Azure SQL Managed Instance, however, you deploy the instance first, and then databases inside of it, so there is not an option to have the sample database upon deployment (similar to SQL Server). You can learn more about the AdventureWorks sample databases on GitHub.

You can also deploy a blank database or create a database based the restore of a backup from a geo-replicated backup.

### Database collations

Collations in SQL Server and Azure SQL tell the Database Engine how to treat certain characters and languages. A collation provides the sorting rules, case, and accent sensitivity properties for your data. When you're creating a new Azure SQL Database or Managed Instance, it's important to first take into account the locale requirements of the data you're working with, because the collation set will affect the characteristics of many operations in the database. In the SQL Server box product, the default collation is typically determined by the OS locale. In Azure SQL Managed Instance, you can set the server collation upon creation of the instance, and it cannot be changed later. The server collation sets the default for all of the databases in that instance of Azure SQL Managed Instance, but you can modify the collations on a database and column level. In Azure SQL Database, you cannot set the server collation, it is set at the default (and most common) collation of `SQL_Latin1_General_CP1_CI_AS`, but you can set the database collation. If we break that into chunks:  

* `SQL` means it is a SQL Server collation (as opposed to a Windows or Binary collation)  
* `Latin1_General` specifies the alphabet/language to use when sorting
* `CP1` references the code page used by the collation
* `CI` means it will be case insensitive, where `CS` is case-sensitive
* `AS` means it will be accent sensitive, where `AI` is accent-insensitive

There are other options available related to character widths, UTF-8, etc., and more details about what you can and can't do with Azure SQL in the documentation (search for "collation and unicode support").

### Opt-in for Advanced Data Security

When you deploy Azure SQL Database in the portal, you are prompted if you'd like to enable Advanced Data Security (ADS) on a free trial. Select **Start free trial**. After the free trial, it is billed according to the Azure Security Center Standard Tier pricing. If you choose to enable it, you get functionality related to data discovery and classification, identifying/mitigating potential database vulnerabilities, and threat detection. You'll learn more about these capabilities in the next security module of this learning path. In Azure SQL Managed Instance, you can enable it on the instance after deployment.  

### Review and create

In the review and create blade, you can review your deployment selections and the Azure Marketplace terms.  

> [!TIP]
> You also have the option to **Download a template for automation**. This unit will not cover that method, but if you're interested, there are other modules available on Microsoft Learn related to Azure Resource Manager (ARM) templates.

## Key deployment implementation details

While Azure is taking care of the deployment for you, there are some deployment implementation details that you should be aware of. All of the services are built on the Azure backbone known as *Azure Service Fabric*.  Understanding the backend of how some of these services are deployed and scaled on Azure Service Fabric will help you understand various behaviors that you may see.

### Azure SQL Managed Instance

Behind the scenes, for Azure SQL Managed Instance, Azure deploys a dedicated ring (sometimes referred to as a *virtual cluster*) for your service. This architecture helps in providing security and native virtual network support. However, because of this architecture, deployment and scaling operations can take longer. For example, when you scale up or down, Azure deploys a new virtual cluster for you and then seeds it with your data. You can think of every instance as running on a single virtual machine. Azure SQL Instance pools were introduced to help with the long deployment time, because you can pre-deploy a "pool" of dedicated resources, making deploying into a pool and scaling within a pool much faster (and with a higher packing density since we can deploy multiple instances within a single VM).  

### Azure SQL Database

Azure SQL database is contained by a logical database server. In most cases an Azure SQL Database is hosted by a dedicated SQL Server Instance, however you do not have to worry about managing the instance. The logical database server is used so you have something to connect to, as well as for grouping and managing certain permissions and configurations together. Within each logical database server, there is a logical master database, which can provide instance-level diagnostics.

### Azure SQL Database - Hyperscale

The Hyperscale tier within Azure SQL Database (not yet in Azure SQL Managed Instance) has a unique architecture for Azure SQL. The Azure SQL team rearchitected Hyperscale for the cloud, and this architecture includes a multi-layer caching system, which can help with both speed and scale. Scaling and other operations no longer become size of data related and can be completed in constant time (a matter of minutes). The use of remote storage also allows for snapshot backups. In a later module of the Azure SQL fundamentals learning path, you will learn more details related to the architecture and how it affects performance and availability. One callout to consider during the deployment phase is that once you move a database to the Hyperscale tier, it is not possible to "go back" to the General purpose or Business critical tiers.

### Resource Governance

As you increase or decrease the resources in a service tier, the limits for dimensions such as CPU, storage, memory, and more may change up to a certain threshold. While there's a multi-faceted approach to governance in Azure SQL, primarily the following three technologies are leveraged to govern your usage of resources in Azure SQL:  

* Windows Job Objects allow a group of processes to be managed and governed as a unit. Job objects are used to govern the file virtual memory commit, working set caps, CPU affinity, and rate caps. You can leverage the DMV `sys.dm_os_job_object` to see the limits in place.
* Resource Governor is a SQL Server feature that helps users (and in this case Azure) govern resources including CPU, physical IO, memory, and more. Azure SQL Managed Instance also allows user-defined Resource Governor workload groups and pools.
* File Server Resource Manager (FSRM) is available in Windows Server and is used to govern file directory quotas which are used to manage max data sizes.

Finally, there have been additional implementations to govern transaction log rate built into the database engine for Azure, through *transaction log rate governance*. This process limits high ingestion rates for workloads such as `BULK INSERT`, `SELECT INTO`, and index builds, and they are tracked and enforced as the subsecond level. They currently scale within a service tier linearly.

## Verify

Once you've completed your deployment, it's time to verify that deployment. In this stage, typically you'll check the results in the Azure portal or Azure CLI, run some queries that verify your deployment configuration, and tweak as necessary.  

For Azure SQL Managed Instance and Azure SQL Database, the first thing you might do is check the status of the database or instance with the Azure portal or the Azure CLI. Next, you can review the deployment details and activity log to ensure there were no failures or active issues.

For Azure SQL Managed Instance, you then might check the ERRORLOG, which is a common thing to do in SQL Server on-premises or in an Azure VM. This capability is not available in Azure SQL Database.  

Finally, you would likely confirm your network is configured properly, obtain the server name, and connect in a tool like SQL Server Management Studio (SSMS) or Azure Data Studio (ADS). There are several queries you can run to better understand what you've deployed and verify it was deployed correctly:  

```sql
SELECT @@VERSION
SELECT * FROM sys.databases
SELECT * FROM sys.objects
SELECT * FROM sys.dm_os_schedulers
SELECT * FROM sys.dm_os_sys_info --Not supported in Azure SQL Database
SELECT * FROM sys.dm_os_process_memory --Not supported in Azure SQL Database
SELECT * FROM sys.dm_exec_requests
SELECT SERVERPROPERTY('EngineEdition')
SELECT * FROM sys.dm_user_db_resource_governance -- Only available in Azure SQL DB and MI
SELECT * FROM sys.dm_os_job_object -- Only available in Azure SQL DB and MI
```

There are two queries that are not supported in Azure SQL Database related to OS system information and OS process memory. These queries are not supported because with Azure SQL Database, some things related to the OS are abstracted away from you, since you're just getting a database.  

Additionally, the last two queries are only available in Azure SQL Database and Azure SQL Managed Instance. The first, `sys.dm_user_db_resource_governance`, will return the actual configuration and capacity settings used by resource governance mechanisms in the current database or elastic pool. The second, `sys.dm_os_job_object` will return a single row describing the configuration of the job object that managers the SQL Server process, as well as resource consumption statistics.

The next two exercises will go through all the details involved in deploying an Azure SQL Database or an Azure SQL Managed Instance, and you will leverage the sandbox environment to deploy Azure SQL Database. After deployment, you'll leverage various verification queries and pre-run SQL Notebooks in Azure Data Studio to compare SQL Database, SQL Managed Instance, and SQL Server 2019.  
