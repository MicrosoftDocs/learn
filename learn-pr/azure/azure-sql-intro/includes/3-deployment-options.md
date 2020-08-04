Within the umbrella of the Azure SQL platform, there are many deployment options and choices to be made in order to tailor to your needs. The options exist to give you the flexibility to get and pay for exactly what you need. Here, we'll cover some of the considerations when choosing various Azure SQL deployment options, as well as some of the technical specifications for each of those options. The deployment options discussed here include SQL Server on virtual machines, Azure SQL Managed Instance, Azure SQL Databases, Azure SQL Managed Instance pools, and Azure SQL Database elastic pools.  

:::image type="content" source="../media/3-azure-sql.png" alt-text="Diagram of the Azure SQL umbrella of offerings." border="false":::  

## SQL Server on Azure Virtual Machines

SQL Server on a virtual machine is a version of SQL Server that you specify running in an Azure VM. It is just SQL Server, so all of your SQL Server skills should directly transfer, though Azure can help automate backups and security patches. SQL Server on an Azure virtual machine is referred to as Infrastructure as a Service (IaaS). You are responsible for updating and patching the OS and SQL Server (apart from critical SQL security patches), but you have access to the full capabilities of SQL Server.

There are some considerations for optimally deploying and managing SQL Server on virtual machines, including:  

- Deploy specific SQL Server and operating system versions from preinstalled Azure gallery images. If you self-install SQL Server on an Azure VM, you can take advantage of the Azure SQL Resource Provider for licensing flexibility and to enable automatic backups and updates.

- Consider the memory or storage optimized virtual machine sizes for maximum performance requirements.

- Use the right storage configuration including taking advantage of Azure Blob storage read caching.

- Integrate your virtual machines to on-premises networks using Azure Virtual Networks.

- Take advantage of automated backups, backups to Azure Blob storage, and integration with Azure Backup.

- Always On Failover Cluster Instance is supported with Azure Premium File Share.

- Always On Availability Groups are supported including a Cloud Witness.

Customers around the globe have successfully used SQL Server on virtual machines. One such example is Allscripts. Allscripts is a leading healthcare software manufacturer, serving physician practices, hospitals, health plans, and the pharmaceutical industry. To transform its applications frequently and host them securely and reliably, Allscripts wanted to move to Azure quickly. In just three weeks, the company lifted and shifted dozens of acquired applications running on approximately 1,000 virtual machines to Azure with Azure Site Recovery.

:::image type="content" source="../media/3-sql-vm.png" alt-text="Diagram of when to choose SQL Server on Azure virtual machine." border="false":::

## IaaS vs PaaS

SQL Server on a virtual machine is considered IaaS. The other deployment options in the Azure SQL platform, Azure SQL Managed Instance and Azure SQL Database, are Platform as a Service (PaaS) deployments. These PaaS Azure SQL deployment options contain a fully managed database engine that automates most of the database management functions such as upgrading, patching, backups, and monitoring. Some key features of SQL Manged Instance and SQL Database include:  

- *Business continuity* enables your business to continue operating in the face of disruption.

- *High availability* guarantees your databases are up and running 99.99% of the time, no need to worry about maintenance/downtimes.

- *Automated backups* are created and use Azure read-access geo-redundant storage (RA-GRS) to provide geo-redundancy.

- *Long-term backup retention* enables you to store specific full databases for up to 10 years.

- *Geo-replication* by creating readable replicas of your database in the same or different data center (region).

- *Scale* by easily adding more resources (CPU, memory, storage) without long provisioning.

- *Network security* features to protect your data over the network. This includes firewalls to restrict connectivity, Private Link to ensure your data is not exposed to the internet, and integration with virtual networks for connectivity to on-premises environments.

- *Advanced security* detects threats and vulnerabilities in your databases and enables you to secure your data.

- *Automatic tuning* analyzes your workload and provides you the recommendations that can optimize performance of your applications by adding indexes, removing unused indexes, and automatically fixing the query plan issues.

- *Built-in monitoring* capabilities enable you to get the insights into performance of your databases and workload, and troubleshoot the performance issues.

- *Built-in intelligence* automatically identifies the potential issues in your workload and provides you the recommendations that can help you to fix the problems.  

### Versionless database services

One additional difference that is significant between IaaS and PaaS is the idea of *versionless* SQL. Unlike IaaS, which is tied to a specific SQL Server version, such as SQL Server 2019, SQL Database and SQL Managed Instance are versionless. The main "branch" of the SQL Server engine code base powers SQL Server 2019, SQL Database, and SQL Managed Instance.  

While SQL Server versions come out every few years, PaaS services allow Microsoft to constantly update the SQL databases/instances. Microsoft rolls out fixes and features as appropriate. As a consumer of the service, you don't have control over this, and the result of `@@VERSION` will not line up to a specific SQL Server version. However, this allows for *worry-free patching for both the underlying OS and SQL Server* and for Microsoft to give you the latest bits.  

As new features are developed, some customers can be granted access to specific features before their publicly available, through a private preview. These new features will then become available in public preview where everyone can access them, but there is typically limited support and often discount pricing. 

## SQL Managed Instance

SQL Managed Instance is a PaaS deployment option of Azure SQL that gives you an instance of SQL Server, but removes much of the overhead of managing a virtual machine. Most of the features available in SQL Server are available in SQL Managed Instance. This option is ideal for customers who want to leverage instance-scoped features (features that are tied to an instance of SQL Server as opposed to features that are tied to a database in an instance of SQL Server) and want to move to Azure without rearchitecting their applications. Azure SQL Managed Instance instance-scoped features include SQL Server Agent, Service Broker, Common Language Runtime (CLR), Database Mail, Linked Servers, and Machine Learning Services (preview). While SQL Managed Instance allows customers to access the instance-scoped features, customers do not have to worry about, nor do they have access to, the OS or the infrastructure underneath.  

:::image type="content" source="../media/3-sql-managed-instance.png" alt-text="Diagram of when to choose Azure SQL Managed Instance." border="false":::

Let's look at another customer example from Komatsu. Komatsu is a manufacturing company that produces and sells heavy equipment for construction. They had multiple mainframe applications for different types of data, which they wanted to consolidate to get a holistic view. Additionally, they wanted a way reduce overhead. Because Komatsu uses a large surface area of SQL Server features, they chose to move to **Azure SQL Managed Instance**. They were able to move about 1.5 terabytes of data smoothly, and start enjoying benefits like automatic patching and version updates, automated backups, high availability, and reduced management overhead. After migrating, they reported ~49% cost reduction and ~25-30% performance gains.  

## SQL Database

:::image type="content" source="../media/3-sql-database.png" alt-text="Diagram of when to choose Azure SQL Database." border="false":::  

SQL Database is a PaaS deployment option of Azure SQL that abstracts both the OS and the SQL Server instance away from the users.  This deployment option allows you to just 'get a database' and start developing applications. SQL Database is also the only deployment option that currently supports scenarios related to needing unlimited database storage (hyperscale) and autoscaling for unpredictable workloads (serverless). SQL Database has the industry's highest availability SLA, along with other intelligent capabilities related to monitoring and performance, due in part to the fact that Microsoft is managing the instance.

AccuWeather is a great example of using SQL Database. AccuWeather has been analyzing and predicting the weather for more than 55 years. They wanted access to the rich and rapidly advanced platform of Azure that includes big data, machine learning, and AI capabilities. They want to focus on building new models and applications, not managing databases. They selected SQL Database to use with other services, like Azure Data Factory and Azure Machine Learning, to quickly and easily deploy new internal applications to make sales and customer predictions.  

## Elastic database pool

You've now learned about the three main deployment options within Azure SQL: virtual machines, managed instances, and databases. For SQL Database and SQL Managed Instance, there are additional options if you have multiple instances or databases. These options are referred to as *elastic database pools*. Using elastic database pools allow you to share resources between multiple instances and databases and optimize your costs.  

**SQL Database elastic pools** allow you to host many databases within a single set of provisioned SQL Database resources. This is ideal for a software as a service (SaaS) application or provider, because you can manage and monitor performance in a simplified way for many databases.

**SQL Managed Instance pools** allow you to host multiple managed instances and share resources. You can pre-provision the compute resources, which can reduce the overall deployment time and thus make migrations easier. You can also host smaller managed instance in an instance pool than in just a single managed instance. This offer is currently in public preview.

A good example for where a customer leveraged SQL Database elastic pools is Paychex. Paychex is a human capital management firm that serves more than 650,000 businesses across the US and Europe. They needed a way to separately manage the time and pay management for each of their customers, and cut costs. They opted for SQL Database elastic pools, which allowed them to simplify the management and enable resource sharing between separate databases to lower costs.  

## Azure SQL deployment options

A brief visual that summarizes all the deployment options for Azure SQL is below. Next, you'll go through deploying and configuring Azure SQL and how it compares to deploying and configuring the box SQL Server.  

:::image type="content" source="../media/3-azure-sql-options.png" alt-text="Diagram of Azure SQL deployment options including pools." border="false":::
