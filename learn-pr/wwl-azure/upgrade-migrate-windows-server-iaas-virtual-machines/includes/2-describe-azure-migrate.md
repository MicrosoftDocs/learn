

For organizations such as Contoso that are considering moving their on-premises resources to Azure, one of the first and most important steps is planning server migration. To help with this migration, Microsoft has provided a number of tools which you can use to plan and perform your workload migration.

## What is Azure Migrate?

*Azure Migrate* is a set of features located in a centralized hub that you can use to assess and migrate different workloads to Azure. Workloads that you can migrate to Azure include on-premises servers, infrastructure, applications, and data.

Azure Migrate components include:

- Unified migration platform. This is a single portal where you can perform migration to Azure and track the migration status.
- Assessment and migration tools. Azure migration tools consist of multiple assessment and migration tools, including: 

  - Azure Migrate
  - Server Assessment and Azure Migrate
  - Server Migration
  - Other independent software vendor (ISV) tools
- Assessment and migration of different workloads. There are a number of different workloads that you can migrate with Azure Migrate hub, including:
  - Servers. On-premises servers are assessed and migrated to Azure VMs.
  - Databases. On-premises databases are assessed and migrated to Azure SQL Database or to an Azure SQL Database–managed instance.
  - Web applications. On-premises web applications are assessed and migrated to Azure App Service by using the Azure App Service Migration Assistant.
  - Virtual desktops. On-premises Virtual Desktop Infrastructure (VDI) is assessed and migrated to Windows Virtual Desktop in Azure.
  - Data. Large volumes of data are migrated to Azure by using Azure Data Box products.

The following table describes the different migration tools you can use, depending on the migration scenario.

|Tool|Migration scenario|
|--------------------------------|------------------------------------------------------------|
|Azure Migrate: Server Assessment|Performs an assessment for physical servers and on-premises VMs running in Hyper-V and VMware environments as preparation for migrating to Azure.|
|Azure Migrate: Server Migration|Performs migration for physical servers and on-premises VMs running in Hyper-V, VMware environments, and other public cloud VMs.|
|Azure Migrate: Database Assessment|Performs an assessment of on-premises Microsoft SQL Server databases as preparation for migration to Azure SQL Database, an Azure SQL Database–managed instance, Database–managed instance, or Azure VMs running SQL Server.|
|Azure Migrate: Database Migration|Performs an assessment as preparation for migration to Azure VMs running SQL Server, Azure SQL Database, or Azure SQL Database–managed instances.|
|Azure Migrate: Web App Assessment|Performs an assessment of on-premises web apps and migrates them to Azure.|
|Azure Migrate: Data Box|Performs a move of large amounts of offline data to Azure by using Azure Data Box.|

## How can I use Azure Migrate?

Strategies for migration to the cloud fall into four broad patterns: rehost, refactor, rearchitect, or rebuild. The strategy you adopt depends on your business drivers and migration goals. You might even adopt multiple patterns.

For example, Contoso might choose to rehost simple apps or apps that aren't critical to their business, but rearchitect apps that are more complex and business-critical.

The following table describes the four patterns.

|Pattern|Definition|When to use|
|---|---|---|
|Rehost|Often referred to as a *lift and shift migration*, this option doesn't require code changes, and allows you to migrate your existing apps to Azure quickly. Each app is migrated as is, without the risk and cost associated with code changes.|When you need to move apps quickly to the cloud, when you want to move an app without modifying it, when your apps are designed so that they can take advantage of Azure IaaS scalability after migration, and when apps are important to your business, but you don't need immediate changes to app capabilities.|
|Refactor|Often referred to as *repackaging*, refactoring requires minimal changes to apps so they can connect to Azure platform as a service (PaaS), and use cloud offerings.  For example, you could migrate existing apps to Azure App Service or Azure Kubernetes Service (AKS).  Alternatively, you could refactor relational and nonrelational databases into options such as Azure SQL Database Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB, but only if your app can easily be repackaged to work in Azure.|If you want to apply innovative DevOps practices provided by Azure, or if you're thinking about DevOps using a container strategy for workloads. For refactoring, you need to think about the portability of your existing code base and available development skills.|
|Rearchitect|Rearchitecting for migration focuses on modifying and extending app functionality and the code base to optimize the app architecture for cloud scalability.  For example, you could break down a monolithic application into a group of microservices that work together and scale easily. Alternatively, you could rearchitect relational and nonrelational databases to a fully managed database solution such as Azure SQL Database Managed Instance, Azure Database for MySQL, Azure Database for PostgreSQL, and Azure Cosmos DB.|When your apps need major revisions to incorporate new capabilities, or to work effectively on a cloud platform.  When you want to use existing application investments, meet scalability requirements, apply innovative DevOps practices, and minimize use of VMs.|
|Rebuild|Rebuild takes things a step further by completely rebuilding an app using Azure cloud technologies. For example, you could build green-field apps with cloud-native technologies such as Azure Functions, Azure AI, Azure SQL Database Managed Instance, and Azure Cosmos DB.|When you want rapid development, and existing apps have limited functionality and lifespan. When you're ready to expedite business innovation (including DevOps practices provided by Azure), build new applications using cloud-native technologies, and utilize advancements in AI, Azure Blockchain, and Internet of Things (IoT).|

Choosing which strategy to use depends on what you are trying to accomplish. The six major scenarios that could apply to you are described in the following table.

|Scenario|Description|
|---|---|
|Windows Server workloads|This includes moving on-premises roles such as file servers, containers, Active Directory roles, and DNS roles. It also relates to migrating on-premises app VMs to Azure VMs using the Azure Migrate service.|
|SQL Server workloads|This involves app databases and other functionality running on SQL Server VMs.|
|Linux workloads|This migration scenario includes migrating RedHat or SUSE VMs, and Hadoop and Linux containers.|
|ASP.NET-PHP-Java apps|This includes customer-facing and internal-facing apps at the software as a service (SaaS) level.|
|SAP HANA|This covers a very specific vendor enterprise resource planning system that uses a centralized database for various business processes. SAP HANA uses in-memory database technology that enables processing of massive amounts of real-time data in a short time. The in-memory computing engine allows HANA to process data stored in random access memory (RAM) as opposed to reading it from a disk system that uses in-memory database technology.|
|Specialized compute|This involves high-performance computing (HPC)|
