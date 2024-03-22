Within the umbrella of the Azure SQL platform, there are many deployment options and choices that you can make. These options give you the flexibility to get and pay for exactly what you need.

This unit covers some of the considerations you need to make when you choose various Azure SQL deployment options. You'll also learn about technical specifications for each of these deployment options. The deployment options discussed here include SQL Server on virtual machines, Azure SQL Managed Instance, Azure SQL Database, Azure SQL Managed Instance pools, and Azure SQL Database elastic database pools.  

:::image type="content" source="../media/3-azure-sql.svg" alt-text="Diagram of the Azure SQL umbrella of offerings." border="false":::  

## SQL Server on Azure Virtual Machines

SQL Server on a virtual machine (VM) is a version of SQL Server that runs in an Azure VM. It's just SQL Server, so all your SQL Server skills should directly transfer, though Azure can help automate backups and security patches. SQL Server on an Azure VM is referred to as *infrastructure as a service (IaaS)*. You're responsible for updating and patching the OS and SQL Server, apart from critical SQL Server security patches, but you have access to the full capabilities of SQL Server.

Here are some considerations for optimally deploying and managing SQL Server on VMs:  

- Deploy specific SQL Server and operating-system versions from preinstalled Azure gallery images. If you self-install SQL Server on an Azure VM, you can take advantage of the SQL Server IaaS Agent Extension for licensing flexibility and to enable automatic backups and updates.

- Consider memory-optimized or storage-optimized VM sizes for maximum performance.

- Use the right storage configuration and take advantage of Azure Blob storage read caching.

- Integrate your VMs into on-premises networks by using Azure virtual networks.

- Take advantage of automated backups, backups to Azure Blob storage, and integration with Azure Backup.

- Always On Failover Cluster Instances is supported with Azure premium file share.

- Always On availability groups are supported, including Cloud Witness.

Companies around the world use SQL Server on VMs. One example is Allscripts. Allscripts is a leading manufacturer of healthcare software, serving physician practices, hospitals, health plans, and the pharmaceutical industry. To transform its applications frequently and to host them securely and reliably, Allscripts wanted to move to Azure quickly. In just three weeks, the company used Azure Site Recovery to migrate dozens of acquired applications running on approximately 1,000 VMs to Azure.

:::image type="content" source="../media/3-sql-vm.svg" alt-text="Diagram that describes when to choose SQL Server on an Azure virtual machine." border="false":::

## IaaS vs. PaaS

SQL Server on a VM is considered IaaS. The other deployment options in the Azure SQL platform, Azure SQL Managed Instance and Azure SQL Database, are platform as a service (PaaS) deployments. These PaaS Azure SQL deployment options contain a fully managed database engine that automates most of the database management functions, like upgrading, patching, backups, and monitoring. Here are some key features of SQL Managed Instance and SQL Database:  

- **Business continuity** allows your business to continue operating in the face of disruption.

- **High availability** guarantees your databases are up and running 99.99% of the time. There's no need to worry about maintenance or downtimes.

- **Automated backups** are created and use Azure read-access geo-redundant storage (RA-GRS) to provide geo-redundancy.

- **Long-term backup retention** lets you store specific full databases for up to 10 years.

- **Geo-replication** creates readable replicas of your database in the same datacenter (region) or a different one.

- **Scalability** lets you easily add more resources (CPU, memory, storage) without long provisioning.

- **Network security** features protect your data over the network. These features include firewalls to restrict connectivity, Azure Private Link to ensure your data isn't exposed to the internet, and integration with virtual networks for connectivity to on-premises environments.

- **Advanced security** detects threats and vulnerabilities in your databases and allows you to secure your data.

- **Automatic tuning** analyzes your workload. It provides recommendations that can optimize performance of your applications by adding indexes, removing unused indexes, and automatically fixing query plan problems.

- **Built-in monitoring** capabilities provide insights into the performance of your databases and workload, and help you troubleshoot performance problems.

- **Built-in intelligence** automatically identifies potential problems in your workload, and provides recommendations that can help you to fix those problems.  

### Versionless database services

Another significant difference between IaaS and PaaS is *versionless SQL*. Unlike IaaS, which is tied to a specific SQL Server version, SQL Database and SQL Managed Instance are versionless. The main "branch" of the SQL Server engine codebase powers SQL Server 2019, SQL Database, and SQL Managed Instance.

Although SQL Server versions come out every few years, PaaS services allow Microsoft to continually update SQL databases and instances. Microsoft rolls out fixes and features as appropriate. As a consumer of the service, you don't have control over these updates, and the result of `@@VERSION` doesn't line up to a specific SQL Server version. But versionless SQL allows for worry-free patching for both the underlying OS and SQL Server and for Microsoft to give you the latest bits.  

As new features are developed, some customers are granted access to specific features before they're publicly available. These new features then become available in public previews. Public previews allow everyone to access new features, but there's typically limited support and often discount pricing.

## SQL Managed Instance

SQL Managed Instance is a PaaS deployment option of Azure SQL. It gives you an instance of SQL Server, but removes much of the overhead of managing a VM. Most of the features available in SQL Server are available in SQL Managed Instance. This option is ideal for customers who want to use instance-scoped features and want to move to Azure without rearchitecting their applications. *Instance-scoped* features are tied to an instance of SQL Server, as opposed to features that are tied to a database in an instance of SQL Server.

Instance-scoped features of SQL Managed Instance include SQL Server Agent, Service Broker, common language runtime (CLR), Database Mail, linked servers, distributed transactions (preview), and Machine Learning Services. SQL Managed Instance allows you to access instance-scoped features, but you don't have to worry about, nor do you have access to, the OS or the infrastructure underneath.  

:::image type="content" source="../media/3-sql-managed-instance.svg" alt-text="Diagram that describes when to choose Azure SQL Managed Instance." border="false":::

Let's look at another industry scenario, this one from Komatsu. Komatsu is a manufacturing company that produces and sells heavy equipment for construction. The company had multiple mainframe applications for different types of data. Komatsu wanted to consolidate these applications to get an overall view. Additionally, Komatsu wanted a way to reduce overhead. Because the company uses a large surface area of SQL Server features, the IT decision makers chose to move to Azure SQL Managed Instance. They were able to move about 1.5 terabytes of data smoothly and get benefits like automatic patching and version updates, automated backups, high availability, and reduced management overhead. After migrating, Komatsu reported about 49 percent cost reduction and performance gains of about 25 to 30 percent.  

## SQL Database

SQL Database is a PaaS deployment option of Azure SQL that abstracts both the OS and the SQL Server instance away from users. This deployment option allows you to just get a database and start developing applications. SQL Database is also the only deployment option that supports scenarios that require unlimited database storage (hyperscale) and autoscaling for unpredictable workloads (serverless). SQL Database has the industry's highest availability SLA. It provides other intelligent capabilities related to monitoring and performance, partly because Microsoft manages instances.

:::image type="content" source="../media/3-sql-database.svg" alt-text="Diagram that describes when to choose Azure SQL Database." border="false":::

AccuWeather provides a great example of using SQL Database. AccuWeather has been analyzing and predicting the weather for more than 55 years. The company wanted to access Azure for its big data, machine learning, and AI capabilities. AccuWeather wants to focus on building new models and applications, not on managing databases. The company chose SQL Database to use with other services, like Azure Data Factory and Azure Machine Learning, to quickly and easily deploy new internal applications to make sales and customer predictions.  

## Elastic database pool

You've now learned about the three main deployment options within Azure SQL: virtual machines, managed instances, and SQL Database. For SQL Database and SQL Managed Instance, there are other options if you have multiple instances or databases. These options are referred to as *elastic database pools*. Elastic database pools allow you to share resources among multiple instances and databases and optimize your costs.  

**SQL Database elastic pools** allow you to host many databases within a single set of provisioned SQL Database resources. This option is ideal for software as a service (SaaS) application or provider because you can manage and monitor performance in a simplified way for many databases.

**SQL Managed Instance pools** allow you to host multiple managed instances and share resources. You can pre-provision compute resources. Doing so can reduce overall deployment time to make migrations easier. You can also host smaller managed instances in an instance pool than in a single managed instance. This offer is currently in public preview.

Paychex is a good example of a company that uses SQL Database elastic database pools. Paychex is a Human Capital Management firm that serves more than 650,000 businesses across the US and Europe. Paychex needed a way to separately manage the time and pay management for each of its customers and cut costs. The company chose SQL Database elastic database pools, which allowed it to simplify management and enable resource sharing between separate databases to lower costs.  

## Azure SQL deployment options

The following image summarizes the deployment options for Azure SQL. Next, you'll learn about deploying and configuring Azure SQL and how it compares to deploying and configuring SQL Server.  

:::image type="content" source="../media/3-azure-sql-options.svg" alt-text="Diagram that shows Azure SQL deployment options." border="false":::
