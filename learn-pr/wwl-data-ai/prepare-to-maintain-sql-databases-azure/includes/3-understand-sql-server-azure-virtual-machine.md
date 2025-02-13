A SQL Server running in an Azure virtual machine (IaaS) is equivalent to an on-premises SQL Server. You will notice that several features described for SQL Server on Azure virtual machine are applicable to all your on-premises SQL Servers.

Many applications will require SQL Server running on a virtual machine. The reasons include:

- **General application support and incompatibility** - For applications requiring an older version of SQL Server for vendor support. In addition, some application services may have a requirement to be installed with the database instance in a manner that is not compatible with a PaaS offering.

- **Use of other SQL Server Services** - In order to maximize licensing, many users choose to run SQL Server Analysis Services (SSAS), SQL Server Integration Services (SSIS), and/or SQL Server Reporting Services (SSRS) on the same machine as the database engine.

## Versions of SQL Server available

Microsoft keeps images of all supported versions of SQL Server available in the Azure Marketplace. If you require an older version that is covered by an extended support contract, you'll need to install your own SQL Server binaries.

## Backup solutions

In recent releases of SQL Server, Microsoft has introduced several features to support running SQL Server in an Azure virtual machine. We are going to focus on two key backup features:

- Back up to URL
- Azure Backup

The back up to URL option enables you to back up your databases to Azure Blob Storage service. Azure Backup for SQL Server Virtual Machines provides a comprehensive enterprise backup solution that automatically manages your backups across your entire infrastructure.

## Deployment options

All resources in Azure are managed and deployed through a common provider known as Azure Resource Manager. While there are various methods to deploy Azure resources, they ultimately converge into JSON documents called Azure Resource Manager templates, which serve as one of the deployment options for Azure resources.

The key distinction between these methods is that Azure Resource Manager templates use a declarative deployment approach, which defines the desired structure and state of the resources to be deployed. In contrast, other methods are imperative, using procedural models to explicitly specify the steps to be executed. For large-scale deployments, the declarative approach is preferable and should be adopted.

## Overview of Azure storage

Azure offers a fully redundant object-based storage model, and there are a few things to be aware of in designing and deploying Virtual Machines architecture. In terms of virtual machines, there are four types of storage you can use:

- Standard
- Standard SSD
- Premium SSD
- Ultra Disk

For production SQL Server data and transaction log files, you should only use Premium SSD storage and Ultra Disk. With premium storage, you will see latencies in the range of 5-10 ms on a properly configured system. Alternatively, with Ultra Disk you may have sub millisecond latency but will likely see 1-2 ms workloads in the real world. You can use Standard storage for your database backups, as the performance is adequate for most backup and restore workloads.

## High availability in Azure

The Azure platform is designed to be fault tolerant and provides quickly recovery from service disruptions and transient errors. In fact, many organizations see higher levels of availability in single virtual machines deployments than they previously experienced in their on-premises environments. Microsoft guarantees uptime of at least 99.9% for single instance Azure virtual machine, when using Premium SSD or Ultra Disk for all disks.

Azure offers several features to support high availability including availability sets, availability zones, and load-balancing techniques that provide high availability by distributing incoming traffic among Virtual Machines.
