A SQL Server running in an Azure virtual machine (IaaS) is equivalent to an on-premises SQL Server. You will notice that several features described for SQL Server on Azure virtual machine are applicable to all your on-premises SQL Servers.

Many applications will require SQL Server running on a virtual machine. The reasons include:

- **General application support and incompatibility** - For applications requiring an older version of SQL Server for vendor support. In addition, some application services may have a requirement to be installed with the database instance in a manner that is not compatible with a PaaS offering.

- **Use of other SQL Server Services** - In order to maximize licensing, many users choose to run SQL Server Analysis Services (SSAS), SQL Server Integration Services (SSIS), and/or SQL Server Reporting Services (SSRS) on the same machine as the database engine.

## Versions of SQL Server available

Microsoft keeps images of all supported versions of SQL Server available in Azure Marketplace. If you have a need for an older version, that is covered by an extended support contract, you must install your own SQL Server binaries.

## Backup solutions

In recent releases of SQL Server, Microsoft has introduced several features to support running SQL Server in an Azure virtual machine. We are going to focus on two key backup features:

- Back up to URL
- Azure Backup

Back up to URL allows you to use standard backup syntax to back up your databases to Azure Blob Storage service, while Azure Backup for SQL Server Virtual Machines offers a complete enterprise backup solution that automatically handles your backups across your infrastructure.

## Deployment options

All resources in Azure share a common provider known as Azure Resource Manager that acts as a management, and deployment service for cloud services. While there are numerous ways to deploy Azure resources, ultimately, they all end up going into JSON documents known as Azure Resource Manager template, which is one of the deployment options for Azure resources.

The main difference between these processes is that Azure Resource Manager templates are a declarative deployment approach that describes the desired structure and state of the resources to be deployed, whereas the other methods can all be described as imperative, which uses procedural models to explicitly specify a process to be executed. In large-scale deployments, the declarative approach is better and should be followed.

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
