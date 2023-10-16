After you select a workload to either migrate to or create in Azure SQL, you need to plan your deployment, deploy accordingly, and verify that the deployment succeeded. In this unit, you learn various methods for each step in the process.

## Predeployment planning

Before you start deploying things in Azure, it's important to understand your requirements and how they map to offerings in Azure SQL. Using what you learned in the Azure SQL introduction module, make a plan. You need to answer the following questions:

* **Deployment method**: Azure portal or command-line interface?
* **Deployment option**: virtual machine, database, elastic pool, managed instance, or instance pool?
* **Purchasing model (Azure SQL Database only)**: DTU or vCore?
* **Service tier**: General Purpose, Business Critical, or Hyperscale?
* **Hardware**: Gen5, or something new?
* **Sizing**: number of vCores and **Data max size**?  

Perhaps before answering the preceding questions, you also need to pick a workload that's going to either be migrated to Azure SQL or be *born in the cloud*. If you're migrating, many tools and resources are available to help you plan, assess, migrate, and optimize your databases and application. Resources are provided at the end of this module.

### Resource limits

The Azure SQL introduction module described limits, rates, and capabilities, such as IOPS or in-memory OLTP. There are other resource limits affected by your choice of Azure SQL Managed Instance, Azure SQL Database, or options within these choices:  

* Memory
* Max log size
* Transaction log rate
* Data IOPS
* Size of tempdb
* Max concurrent workers
* Backup retention

The limits for Azure SQL Managed Instance and Azure SQL Database depend on your choice of purchasing model, service tier, and number of vCores, or DTU in Azure SQL Database only.

Azure SQL Managed Instance and SQL Database are platform as a service (PaaS) offerings. Restricting these choices shouldn't inhibit your ability to fully use a SQL Server managed service.

Within a General Purpose Azure SQL Database instance, your choice of provisioned or serverless compute also affects these limits. Before you deploy, review what's included in what you plan to deploy to ensure that you're starting out with what you need.

Azure SQL resources have overall resource limits *per subscription* and *per region*. If you need to increase your limits, you can request a quota increase in the Azure portal.

## Deployment

After you've completed your predeployment planning, it's time to put your plan into action. In this stage, deploy Azure SQL by using the Azure portal or the command line, determine network configuration, and make an initial connection.  

For Azure SQL Database and Azure SQL Managed Instance, there are essentially six panes in the Azure portal to fill in during a deployment.  

:::image type="content" source="../media/2-deploy-panes.png" alt-text="Diagram of the deployment panes for Azure SQL." border="false":::

### Server

When you create an Azure SQL managed instance, supplying the server name is the same as in SQL Server. For databases and elastic pools, an Azure SQL Database server is required. An Azure SQL Database server is a *logical* server that acts as a central administrative point for a single or pooled database. It includes logins, firewall rules, auditing rules, threat detection policies, and failover groups. You learn more about these elements later.

This logical server doesn't expose any instance-level access or features as with Azure SQL Managed Instance. For Azure SQL Database servers, the server name must be unique across all of Azure.  

### Compute and storage

In the previous module of this learning path, you learned about options and recommendations for compute and storage, including service tiers, purchasing models, and hardware generations. You need to select the desired configuration during deployment. You also must determine the number of vCores and **Data max size**.

Generally, if you're migrating, use size that's similar to what you use on-premises. You can also use tools like the Data Migration Assistant SKU recommender to estimate the number of vCores and **Data max size** based on your current workload.  

**Data max size** isn't necessarily the size of your data today. It's the maximum amount of data space that can be allocated for your database. It also helps you understand the allocation of log space, which scales with **Data max size**.

### Networking configuration

Choices for networking for Azure SQL Database and Azure SQL Managed Instance are different. When you deploy an Azure SQL Database, the current default is **No access**.  

You can select a public endpoint or private endpoint. In the exercise that follows this unit, use the public endpoint and set the **Allow Azure services and resources to access this server** option to *yes*. Other Azure services, for example, Azure Data Factory or Azure Virtual Machines, can access the database if you configure it. You can also select **Add current client IP address** if you want to be able to connect from the client computer's IP address that you used to deploy Azure SQL Database.

With Azure SQL Managed Instance, you deploy inside an Azure virtual network and a subnet that's dedicated to managed instances, which lets you have a secure, private IP address. Azure SQL Managed Instance can connect an on-premises network to a managed instance, connect a managed instance to a linked server or other on-premises data store, and connect a managed instance to other resources.

You can also enable a public endpoint so you can connect to a managed instance from the internet without a virtual private network (VPN). This access is disabled by default.

### Data source

In Azure SQL Database, you can select the `AdventureWorksLT` database as the sample upon deployment in the Azure portal. In Azure SQL Managed Instance, you deploy the instance first and then databases inside it. You can't have the sample database upon deployment, similar to SQL Server. You can learn more about the `AdventureWorks` sample databases on GitHub.

You can also deploy a blank database or create a database that's based on the restore from a geo-replicated backup.

### Database collations

Collations in SQL Server and Azure SQL tell the database engine how to treat certain characters and languages. A collation provides the sorting rules, case, and accent sensitivity properties for your data.

When you create a new SQL database or managed instance, take into account the locale requirements of the data you're working with. The collation set affects the characteristics of many operations in the database. In the SQL Server box product, the operating system locale typically determines the default collation.

In Azure SQL Managed Instance, set the server collation upon creation of the instance. It can't be changed later. The server collation sets the default for all of the databases in that instance of Azure SQL Managed Instance, but you can modify the collations on a database and column level.

In Azure SQL Database, you can't set the server collation. It's set at the default and most common collation of `SQL_Latin1_General_CP1_CI_AS`, but you can set the database collation. To break that value into chunks:  

* `SQL` means that it's a SQL Server collation, as opposed to a Windows or binary collation.
* `Latin1_General` specifies the alphabet or language to use when sorting.
* `CP1` references the code page that the collation uses.
* `CI` means that it's case-insensitive. `CS` means case-sensitive.
* `AS` means that it's accent-sensitive. `AI` means accent-insensitive.

Other options are available. Examples are character widths and UTF-8 encoding. You can find more details about what you can and can't do with Azure SQL [in the documentation](/azure/azure-sql/).

### Opt-in for Microsoft Defender for Cloud

When you deploy Azure SQL Database in the Azure portal, it prompts about whether you want to enable Microsoft Defender for Cloud in a free trial. Select **Start free trial**. After the free trial, Defender for Cloud is billed according to the Microsoft Defender for Cloud Standard Tier pricing.

After you enable it, you get functionality related to identifying and mitigating potential database vulnerabilities and threat detection. Learn more about these capabilities in the next security module of this learning path.

In Azure SQL Managed Instance, you can enable Microsoft Defender for Cloud on the instance after deployment.  

### Review of selections

On the **Review and create** pane, review your deployment selections and the Azure Marketplace terms.  

> [!TIP]
> You also have the **Download a template for automation** option. This unit doesn't cover that method. If you're interested, there are other modules available on Microsoft Learn related to Azure Resource Manager templates (ARM templates).

## Key deployment implementation details

While Azure takes care of the deployment for you, there are some deployment implementation details that you should be aware of. All of the services are built on the Azure backbone known as *Azure Service Fabric*. Understanding the back end of how some of these services are deployed and scaled on Azure Service Fabric helps you understand various behaviors that you might see.

### Azure SQL Managed Instance

Behind the scenes, for Azure SQL Managed Instance, Azure deploys a dedicated ring, sometimes called a *virtual cluster*, for your service. This architecture helps to provide security and native virtual network support.

Because of this architecture, deployment and scaling operations can take longer. For example, when you scale up or down, Azure deploys a new virtual cluster for you and then seeds it with your data. You can think of every instance as running on a single virtual machine.

Azure SQL Instance pools were introduced to help with the long deployment time. You can predeploy a *pool* of dedicated resources. Deploying into a pool and scaling within a pool are faster than traditional deployments. You also get a higher packing density, because you can deploy multiple instances within a single virtual machine.

### Azure SQL Database

Azure SQL Database is contained by a logical database server. In most cases, a dedicated SQL Server instance hosts the SQL database, but you don't have to worry about managing the instance.

The logical database server gives you something to connect to. It also enables you to group and manage certain permissions and configurations together. Within each logical database server is a logical primary database, which can provide instance-level diagnostics.

### Azure SQL Database - Hyperscale

The Hyperscale tier within Azure SQL Database, which isn't available in Azure SQL Managed Instance, has a unique architecture for Azure SQL. The Azure SQL team rearchitected Hyperscale for the cloud. This architecture includes a multilayer caching system that can help with both speed and scale. Scaling and other operations no longer become related to the size of data and can be completed in constant time, a matter of minutes. The use of remote storage also allows for snapshot backups.

In a subsequent module of the learning path about Azure SQL fundamentals, you learn more about the architecture and how it affects performance and availability. One consideration during the deployment phase is that after you move a database to the Hyperscale tier, you can't *go back* to the General Purpose or Business Critical tier.

### Resource governance

As you increase or decrease the resources in a service tier, the limits for dimensions such as CPU, storage, and memory might change up to a certain threshold. Although there's a multifaceted approach to governance in Azure SQL, the following three technologies are primarily used to govern your usage of resources in Azure SQL:  

* Windows job objects allow a group of processes to be managed and governed as a unit. Job objects are used to govern the file's virtual memory commit, working set caps, CPU affinity, and rate caps. You can use the `sys.dm_os_job_object` dynamic management view to see the limits in place.
* Resource Governor is a SQL Server feature that helps users, and in this case Azure, govern resources like CPU, physical I/O, and memory. Azure SQL Managed Instance also allows user-defined workload groups and pools for Resource Governor.
* File Server Resource Manager is available in Windows Server. It governs file directory quotas, which are used to manage **Data max size**.

Other implementations to govern transaction log rate are built into the database engine for Azure, through *transaction log rate governance*. This process limits high ingestion rates for workloads such as `BULK INSERT`, `SELECT INTO`, and index builds. They're tracked and enforced as the subsecond level. They currently scale within a service tier linearly.

## Verification

After you complete your deployment, it's time to verify that deployment. In this stage, typically you check the results in the Azure portal or the Azure CLI, run some queries that verify your deployment configuration, and tweak as necessary.  

For Azure SQL Managed Instance and Azure SQL Database, the first thing you might do is check the status of the database or instance with the Azure portal or the Azure CLI. Next, you can review the deployment details and activity log to ensure that there are no failures or active issues.

For Azure SQL Managed Instance, you then might check the error log, which is a common thing to do in SQL Server on-premises or in an Azure virtual machine. This capability isn't available in Azure SQL Database.  

Finally, you'd likely confirm that your network is configured properly, obtain the server name, and connect in a tool like SQL Server Management Studio or Azure Data Studio. You can run the following queries to better understand what you've deployed and to verify that it was deployed correctly:  

```sql
SELECT @@VERSION
SELECT * FROM sys.databases
SELECT * FROM sys.objects
SELECT * FROM sys.dm_os_schedulers
SELECT * FROM sys.dm_os_sys_info
SELECT * FROM sys.dm_os_process_memory --Not supported in Azure SQL Database
SELECT * FROM sys.dm_exec_requests
SELECT SERVERPROPERTY('EngineEdition')
SELECT * FROM sys.dm_user_db_resource_governance -- Available only in Azure SQL Database and SQL Managed Instance
SELECT * FROM sys.dm_instance_resource_governance -- Available only in Azure SQL Managed Instance
SELECT * FROM sys.dm_os_job_object -- Available only in Azure SQL Database and SQL Managed Instance
```

One query related to the OS process memory isn't supported in Azure SQL Database, even though it might appear to work. This query isn't supported because with Azure SQL Database, some things related to the operating system are abstracted away from you, allowing you to focus on the database.  

The last three queries are available only in Azure SQL Database and Azure SQL Managed Instance. The first, `sys.dm_user_db_resource_governance`, returns the configuration and capacity settings used by resource governance mechanisms in the current database or elastic pool. You can get similar information for an Azure SQL Managed Instance with the second, `sys.dm_instance_resource_governance`. The third, `sys.dm_os_job_object`, returns a single row that describes the configuration of the job object that manages the SQL Server process and resource consumption statistics.

The next two exercises go through all the details involved in deploying Azure SQL Database or Azure SQL Managed Instance. Use your Azure subscription to deploy Azure SQL Database. After deployment, you use various verification queries and prerun SQL notebooks in Azure Data Studio to compare SQL Database, SQL Managed Instance, and SQL Server 2019.  
