

Having selected a strategy, Contoso is now ready to start their migration project. To help with this migration, Microsoft has provided a number of tools that they could use to perform their workload migration. The foremost of these is Azure Migrate.

## What is Azure Migrate?

*Azure Migrate* is a set of features located in a centralized hub that you can use to assess and migrate different workloads to Azure. Workloads that can be migrated to Microsoft Azure include on-premises servers, infrastructure, applications, and data.

Azure Migrate components include:

- Unified migration platform. A single portal where you can perform migration to Azure and track the migration status.
- Assessment and migration tools. Azure migration tools consist of multiple assessment and migration tools, including Azure Migrate: Server Assessment and Azure Migrate: Server Migration and other independent software vendor (ISV) tools.
- Assessment and migration of different workloads. There are a number of different workloads that you can migrate with Azure Migrate hub, including:
  - Servers. On-premises servers are assessed and migrated to Azure VMs.
  - Databases. On-premises databases are assessed and migrated to Azure SQL Database or to an Azure SQL Database–managed instance.
  - Web applications. On-premises web applications are assessed and migrated Azure App Service by using the Azure App Service Migration Assistant.
  - Virtual desktops. On-premises virtual desktop infrastructure (VDI) is assessed and migrated to Windows Virtual Desktop in Azure.
  - Data. Large volumes of data are migrated to Azure by using Azure Data Box products.

## How can you use Azure Migrate?

Azure Migrate can help with a number of migration scenarios. The one that Contoso selects depends on what they are trying to achieve. The six major migration scenarios are described in the following table.

|Scenario|Description|
|---|---|
|Windows Server workloads|These include moving on-premises roles such as file servers, containers, Active Directory roles, and DNS roles. It also includes migrating on-premises app VMs to Azure VMs using the Azure Migrate service.|
|SQL Server workloads|This involves app databases, Business Intelligence (BI) and other functionality running on SQL Server VMs.|
|Linux workloads| This migration scenario covers migrating RedHat or SUSE VMs, and Hadoop and Linux containers.|
|ASP.NET-PHP-Java apps|This includes customer-facing and internal-facing apps at the software as a service (SaaS) level.|
|SAP HANA|This covers a very specific vendor Enterprise Resource Planning system that uses a centralized database for various business processes. SAP HANA uses in-memory database technology that allows for processing massive amounts of real-time data in a short time. The in-memory computing engine enables HANA to process data stored in random access memory (RAM), as opposed to reading it from a disk system that uses in-memory database technology to process massive amounts of real-time data in a short time. The in-memory computing engine allows HANA to process data stored in RAM as opposed to reading it from a disk.|
|Specialized compute|This involves high-performance computing (HPC).|
