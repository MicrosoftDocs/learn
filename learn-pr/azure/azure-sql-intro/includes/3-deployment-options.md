The products in the Azure SQL family offer different capabilities and deployment options to meet your business needs, giving you the flexibility to get and pay for exactly what you need.

This unit covers some of the considerations you need to make when you choose an Azure SQL product. The products discussed here are Azure SQL Database, Azure SQL Managed Instance, and SQL Server on Azure Virtual Machines (VMs). 

## IaaS vs. PaaS

Azure SQL offers both Platform-as-a-service (PaaS) and Infrastructure-as-a-service (IaaS) products. With PaaS, you don't have to worry about the underlying infrastructure as most tasks - such as patching, and backups - are automatically managed by the service. You can focus on your applications and data. 

With IaaS, you have more control over the underlying infrastructure, but you also have the responsibility of managing it.

SQL Server on Azure Virtual Machines is closest to IaaS, while Azure SQL Database is closest to PaaS. Azure SQL Managed Instance is also a PaaS platform but with  similarities closer to an on-premises SQL Server instance.

- Azure SQL Database is a fully managed database, with hardware, network, disaster recovery, and high availability automatically configured. You have access to a logical server for some instance-level objects like SQL logins. The database is contained and independently scalable, and you can failover geo-replicated copies of your data quickly and easily.
- Azure SQL Managed Instance provides a fully managed SQL Server instance, with the operating system, storage, networking, backups, and high availability provided automatically. An ideal target for migrations from existing on-premises SQL Server instances, a SQL managed instance maintains almost all of the features of a SQL Server installation, plus much more cloud-first features like geo-replicated read-scale replicas.
- SQL Server on Azure Virtual Machines provides direct access to the operating system and the most configurable storage, networking, and compatibility with SQL Server on-premises.

### Versionless database services

Another significant difference between IaaS and PaaS is *versionless SQL*. Unlike IaaS, which is tied to the specific SQL Server version you choose, Azure SQL Database and Azure SQL Managed Instance (with the **Always-up-to-date** update policy) are versionless. The main "branch" of the SQL Server engine codebase powers the latest version of SQL Server, SQL Database, and SQL Managed Instance.

Although SQL Server versions come out every few years, PaaS services allow Microsoft to continually update the SQL database engine for Azure SQL. Microsoft rolls out fixes and features as appropriate, and often PaaS platforms get new features first. As a consumer of the service, you don't have control over these updates, though you can schedule regular maintenance windows around your typical business cycle. But versionless SQL allows for worry-free patching for both the underlying OS and SQL Server, and for Microsoft to give you the latest bits.  

As new features are developed, some customers are granted access to specific features before they're publicly available. These new features then become available in public previews. Public previews allow everyone to access new features, but there's typically limited support and often discount pricing.

Note the mention of the **Always-up-to-date** update policy for Azure SQL Managed Instance. The update policy is a configuration option of Azure SQL Managed Instance that allows you to choose the version of the underlying database format. By default, unless otherwise specified, every new instance is created with the SQL Server 2022 update policy, which enables database mobility between SQL Server 2022 and Azure SQL Managed Instance. 

The **SQL Server 2022** update policy unlocks scenarios like restoring databases between the two products, or using the Managed Instance link feature to bidirectionally replicate data between SQL Server and Azure. However, the **SQL Server 2022** update policy also locks your Azure SQL Managed Instance to the features that are available in SQL Server 2022, so you might not have access to some of the latest features available in later versions of the SQL Server database engine. You can choose to enable the **Always-up-to-date** update policy instead, which turns your SQL Managed Instance "versionless". Once enabled, it's no longer possible to go back to the **SQL Server 2022** update policy, so proceed with caution. 

## What to choose

Since the different Azure SQL products offer differences in features and capabilities, it's important to choose the product that best meets your needs. 

:::image type="content" source="../media/3-azure-sql.svg" alt-text="Diagram of the Azure SQL family of offerings." border="false":::  

### Azure SQL Database

The PaaS Azure SQL Database abstracts both the OS and the SQL Server instance away from users. This option allows you to get a database and start developing applications. SQL Database is also the only product that supports scenarios that require unlimited database storage (hyperscale) and autoscaling for unpredictable workloads (serverless). SQL Database has the industry's highest availability SLA (service-level agreement). It also provides other intelligent capabilities related to monitoring and performance.

Since with Azure SQL Database, you're deploying a database, some instance-level features, such as cross-database transactions aren't natively available. 

Azure SQL Database is ideal for: 
- Modern application development of new cloud-born applications that want to use the latest stable SQL Server features and have time constraints in development and marketing
- Applications that use the multitenant SaaS application pattern
- Workloads that need unlimited storage or autoscaling for unpredictable workloads

:::image type="content" source="../media/3-sql-database.svg" alt-text="Diagram that describes when to choose Azure SQL Database." border="false":::

### Azure SQL Managed Instance

The PaaS Azure SQL Managed Instance gives you a fully managed instance of SQL Server, but removes much of the overhead of managing the infrastructure. 

Unlike with SQL Database, most instance-level features available in SQL Server are available in Azure SQL Managed Instance - such as the SQL Server Agent, Service Broker, common language runtime (CLR), Database Mail, linked servers, distributed transactions, and Machine Learning Services.

SQL Managed Instance allows you to access these instance-scoped features. However, you don't have to worry about, nor do you have access to, the OS or the infrastructure underneath.  

SQL Managed Instance is ideal for:
- Customers who want to use instance-scoped features not available in Azure SQL Database,  such as the SQL Server Agent 
- New applications that don't have time constraints and want to use the latest stable SQL Server features
- Moving existing on-premises applications to Azure without rearchitecting the applications
- Workloads migrated to the cloud with minimal changes

:::image type="content" source="../media/3-sql-managed-instance.svg" alt-text="Diagram that describes when to choose Azure SQL Managed Instance." border="false":::

### SQL Server on Azure VMs 

The IaaS SQL Server on Azure VM is just a version of SQL Server that installed to either a Windows or Linux VM in Azure. SQL virtual machines run on standardized hardware owned, hosted, and maintained by Microsoft. In fact, running SQL Server on an Azure VM is very similar to running SQL Server on-premises. It's just SQL Server, so all your SQL Server skills should directly transfer. Updating and patching the OS and SQL Server can be manual or automated, though critical SQL Server security patches remain automated by the operating system. For example, Azure Update Manager can automate patching on your SQL Server instance on Windows or Linux Azure VMs. You have access to the full capabilities of SQL Server and the underlying VM infrastructure. You can use many of the same tools and processes that you use on-premises, plus new cloud-based tools to make management easier. For example, the Windows SQL Server IaaS Agent extension, Azure Monitor, and Azure Backup.

All supported versions and editions of SQL Server are available to install on all supported operating systems. The most significant difference from SQL Database and SQL Managed Instance is that SQL Server on Azure VMs allows full administrative control over the SQL Server instance and underlying operating system. You can choose when to start maintenance activities including system updates, change the recovery model to simple or bulk-logged, pause or start the service when needed, and you can fully customize the SQL Server database engine. With this additional control comes the added responsibility to manage the virtual machine.

SQL Server on Azure VMs are ideal for:
- Lift-and-shift scenarios that require fast migration to the cloud with little to no changes
- Migrating existing applications that require full control over the SQL Server instance and the underlying OS
- Rapid development and test scenarios when you don't want to buy on-premises hardware for SQL Server
- When an organization already has IT resources available to maintain the virtual machines
- Migrating existing high availability and disaster recovery solutions to the cloud, such as Always On failover cluster instances, or Always On availability groups

:::image type="content" source="../media/3-sql-vm.svg" alt-text="Diagram that describes when to choose SQL Server on an Azure virtual machine." border="false":::

## Deployment options

Azure SQL products are designed to meet the needs of different workloads, with different deployment options offering scalability and flexibility. 

For example, with Azure SQL Database, when you deploy a database, you can choose to deploy it as a single database, or you can pool your resources with other databases in an elastic pool. An elastic pool is a collection of databases that share the same set of resources. This option is ideal for SaaS applications, where you can manage and monitor performance in a simplified way for many databases.

Likewise, with Azure SQL Managed Instance, you can choose to deploy a single managed instance, or you can pool your resources with other managed instances in an instance pool. This option is ideal for organizations  looking to consolidate multiple SQL Server workloads to fewer managed instances. Notably, an instance pool is the only way to deploy a 2-vCore SQL managed instance.  You can provision compute resources before deployment, which can reduce overall deployment time to make migrations easier. 

While SQL Server on Azure VMs don't have specific deployment options, you can still choose between a deploying an Azure VM image with SQL Server preinstalled, or you can deploy the Azure VM and install SQL Server at a later time. Choose different VM sizes and storage types to meet the demands of your workloads. To use Azure-specific features such as automated backups and automated patching with your SQL Server on Azure VM, register your SQL Server VM with the SQL IaaS Agent extension. The extension gives you the ability to manage your SQL Server VM in the Azure portal, such as changing billing, or configuring Azure-specific features. 

The following image summarizes the deployment options for Azure SQL:   

:::image type="content" source="../media/3-azure-sql-options.png" alt-text="Diagram that shows Azure SQL deployment options." border="false":::

## Customer stories

For some real-world applications, consider how some of Microsoft's customers have used Azure SQL.

### Azure SQL Database

AccuWeather provides a great example of using SQL Database. AccuWeather has been analyzing and predicting the weather for more than 55 years. The company wanted to access Azure for its big data, machine learning, and AI capabilities. AccuWeather wants to focus on building new models and applications, not on managing databases. The company chose SQL Database to use with other services, like Azure Data Factory and Azure Machine Learning, to quickly and easily deploy new internal applications to make sales and customer predictions.  

Paychex is a good example of a company that uses SQL Database elastic pools. Paychex is a Human Capital Management firm that serves more than 650,000 businesses across the US and Europe. Paychex needed a way to separately manage the time and pay management for each of its customers and cut costs. The company chose SQL Database elastic pools, which allowed it to simplify management and enable resource sharing between separate databases to lower costs.  

### Azure SQL Managed Instance

Komatsu is a manufacturing company that produces and sells heavy equipment for construction. The company had multiple mainframe applications for different types of data. Komatsu wanted to consolidate these applications to get an overall view. Additionally, Komatsu wanted a way to reduce overhead. Because the company uses a large surface area of SQL Server features, the IT decision makers chose to move to Azure SQL Managed Instance. They were able to move about 1.5 terabytes of data smoothly. They also got benefits like automatic patching and version updates, automated backups, high availability, and reduced management overhead. After migrating, Komatsu reported about 49 percent cost reduction and performance gains of about 25 to 30 percent.  

### SQL Server on Azure VMs 

Companies around the world use SQL Server on Azure VMs. One example is Allscripts. Allscripts is a leading manufacturer of healthcare software, serving physician practices, hospitals, health plans, and the pharmaceutical industry. To transform its applications frequently and to host them securely and reliably, Allscripts wanted to move to Azure quickly. In just three weeks, the company used Azure Site Recovery to migrate dozens of acquired applications running on approximately 1,000 VMs to Azure.

