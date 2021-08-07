Azure Arc-enabled SQL Managed Instance is an Azure SQL service powered by the SQL Server engine that can be deployed on the infrastructure of your choice.

## Comparison with Azure SQL

Azure SQL is a family of database services deployed in the Azure infrastructure:

### SQL Server in Azure Virtual Machine

This Azure SQL deployment option allows a fully licensed SQL Server product to run on the version of your choice on Windows or Linux. The user manages everything inside guest virtual machine. The infrastructure is managed by Microsoft. This option is known as Infrastructure as a Service (IaaS)

### Azure SQL Managed Instance

This Azure SQL deployment option provides a pre-installed, versionless SQL Server instance as a fully managed service. The user has access to almost 100% capabilities of a SQL Server engine instance. Microsoft manages all aspects of the platform and infrastructure required to host the instance. This option is an example of a Platform as a Service (PaaS).

### Azure SQL Database

This Azure SQL deployment option provides a contained SQL Server database powered by a pre-installed, versionless SQL Server as a fully managed service. The user manages the database while Microsoft manages the underlying SQL instance, platform, and infrastructure. This option is also an example of a Platform as a Service (PaaS).

**Azure Arc-enabled SQL Managed Instance** is similar to Azure SQL Managed Instance. It has similar features and management capabilities. The intention of Azure Arc-enabled SQL Managed Instance is to provide the same Platform as a Service (PaaS) capabilities and experience of Azure, while the customer chooses and manages the infrastructure using the Kubernetes platform.

## Comparison of features

To understand the capabilities of Azure Arc-enabled SQL Managed Instance, it is important to look at its core features, deployment options, and integration with Azure.

### Core features

Since Azure Arc-enabled SQL Managed Instance is based on the SQL Server engine, it provides core instance [features](https://docs.microsoft.com/azure/azure-arc/data/managed-instance-features) almost 100% compatible with SQL Server and Azure SQL Managed Instance. The instance includes a compatible T-SQL language interface and all the features of security, performance, and availability.

Like Azure SQL Managed instance, when you deploy Azure Arc-enabled SQL Managed instance you get a pre-installed, versionless SQL Server. Azure Arc-enabled SQL Managed instance uses container images from the Microsoft container registry.

### Service tiers

Like Azure SQL Managed Instance, you can deploy Azure Arc-enabled SQL Managed instance with two deployment options called [service tiers](https://docs.microsoft.com/azure/azure-arc/data/service-tiers):

- **General purpose** - As its name implies, this service tier is for most workloads.This service tier has a limit for resources such as core and memory but comes with built-in basic high availability through Kubernetes and shared storage.

- **Business critical (preview)** - This service tier is designed for workloads that require the best performance and highest level of availability. This service tier has no limits for memory or cores and uses availability groups to provide high availability with read scale-out.

Both service tiers are billed on a per core basis but also include the ability to use Azure Hybrid Benefit licensing and a developer option for no cost. Business critical service tier is currently under preview so does not incur any charges for use.

### Azure integration

When you deploy an Azure SQL Managed instance, billing, usage, metrics, and logs are all integrated into the Azure ecosystem. Furthermore, by default you can use Azure interfaces such as the portal and CLI to deploy and configure an Azure SQL Managed Instance.

Integration with Azure for Azure Arc-enabled SQL Managed instance depends on which [connectivity mode](https://docs.microsoft.com/azure/azure-arc/data/connectivity) you use.

With direct-connected mode, integration with Azure is handled automatically through Azure Arc agents and the Azure Arc data controller. All Azure interfaces such as the Azure portal can be used for deployment and configuration.

With indirect-connected mode, a minimal amount of data must be sent to Azure for billing purposes. Optionally, you can export data such as metrics and logs. Deployment and configuration through the Azure portal is not supported indirect-connected mode. However, interfaces such as the az CLI and kubectl can still be used for deployment and configuration.

## Comparison of management capabilities

### Versionless

### Deploy and configure

### Monitoring

### High-availability

### Disaster Recovery

## Interfaces for Azure Arc-enabled SQL Managed Instance

The following interfaces can be used with Azure Arc-enabled SQL Managed Instance to manage the instance and build applications:

### SQL Server Management Studio (SSMS)

### Azure Data Studio (ADS)

### Azure portal

### az CLI

### kubectl

### SQL providers