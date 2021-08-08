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

In direct connected mode, authentication to Azure Arc-enabled SQL Managed instance can be done using SQL or Azure Active Directory authentication. SQL authentication can be used if you use indirect connected mode.

Azure SQL Managed Instance uses gateway servers to abstract the application from underlying connectivity details. Azure Arc-enabled SQL Managed Instance also provides connection abstraction using Kubernetes LoadBalancers or NodePorts.

### Service tiers

Like Azure SQL Managed Instance, you can deploy Azure Arc-enabled SQL Managed instance with two deployment options called [service tiers](https://docs.microsoft.com/azure/azure-arc/data/service-tiers):

- **General purpose** - As its name implies, this service tier is for most workloads.This service tier has a limit for resources such as core and memory but comes with built-in basic high availability through Kubernetes and shared storage.

- **Business critical (preview)** - This service tier is designed for workloads that require the best performance and highest level of availability. This service tier has no limits for memory or cores and uses availability groups to provide high availability with read scale-out.

Both service tiers are billed on a per core basis but also include the ability to use Azure Hybrid Benefit licensing and a developer option for no cost. Business critical service tier is currently under preview so don't incur any charges for use.

### Azure integration

When you deploy an Azure SQL Managed instance, billing, usage, metrics, and logs are all integrated with Azure automatically. Furthermore, by default you can use Azure interfaces such as the portal and CLI to deploy and configure an Azure SQL Managed Instance.

Integration with Azure for Azure Arc-enabled SQL Managed instance depends on which [connectivity mode](https://docs.microsoft.com/azure/azure-arc/data/connectivity) you use.

Integration with Azure is handled automatically with direct connected mode through Azure Arc agents and the Azure Arc data controller. All Azure interfaces such as the Azure portal can be used for deployment and configuration.

If you use indirect-connected mode, a minimal amount of data must be sent to Azure for billing purposes. Optionally, you can export data such as metrics and logs. Deployment and configuration through the Azure portal isn't supported indirect-connected mode. However, interfaces such as the az CLI and kubectl can still be used for deployment and configuration.

## Comparison of management capabilities

Since Azure Arc-enabled SQL Managed instance is a managed service, it is useful to compare management capabilities with Azure SQL Managed instance such as a versionless engine, deploy and configure, monitoring, high availability, and disaster recovery.

### Versionless

One of the benefits of using Azure SQL Managed Instance is the elimination of the need to patch and update SQL Server, the operating system, and any platform software. The engine for Azure SQL Managed instance is often referred to as *versionless*, because there isn't the concept of a major version as with SQL Server. The instance is constantly updated as needed with any necessary updates or new functionality.

Azure Arc-enabled SQL Managed instance also uses a versionless engine so updates can be applied automatically as needed through updated container images. Availability is maintained by using the power of Kubernetes to stop and start new containers.

### Deploy and configure

Azure SQL Managed Instance can be deployed using Azure interfaces such as the Azure portal and az CLI. In direct connected mode, Azure Arc-enabled SQL Managed Instance can be deployed with the Azure portal an az CLI. In any connected mode, Azure Arc-enabled SQL Managed Instance can be deployed using az CLI, kubectl, or Azure Data Studio.

Outside of the SQL instance, Azure Arc-enabled Managed Instance can also be configured in direct connected mode using Azure interfaces. In either connected mode, certain options can be configured outside of the SQL instance with az CLI.

Inside the SQL instance, standard SQL Server interfaces such as sp_configure, ALTER SERVER CONFIGURATION, and ALTER DATABASE can be used to configure the instance and database options.

### Monitoring

Like Azure SQL Managed Instance, you can monitor Azure Arc-enabled SQL Managed instance using Azure monitor for key metrics. Locally within the cluster, you can also use built in monitoring with Grafana dashboards for nodes or the SQL instance.

Like Azure SQL Managed Instance, logs for Azure Arc-enabled SQL Managed Instance are available to view in the Azure portal through log analytics. Locally within the cluster, you can also use built in logging with Kibana.

Since Azure Arc-enabled SQL Managed Instance is based on SQL Server, the standard ERRORLOG files are available to view SQL errors and instance details. Azure Arc-enabled SQL Managed Instance also supports all available Dynamic Management Views (DMV) and Extended Events.

### High availability

One of the best benefits of using a managed service like Azure Arc-enabled SQL Managed Instance is built in high availability. Like Azure SQL Managed Instance, the method used to achieve high availability depends on the service tier.

For the General Purpose service tier, the built in high availability of Kubernetes StatefulSets is used with shared storage.

For the Business Critical service tier (Preview), built in high availability is provided using a combination of Kubernetes StatefulSets and SQL Server Always On Availability Group replicas. Like Azure SQL Managed Instance, a read-only replica is available to offload read workloads. System databases such as master and model are part of the availability group. System level objects such as SQL Agent jobs will automatically be available after a failover event.

Kubernetes LoadBalancers and NodePorts provide connection abstraction for the application should the instance move nodes within the cluster. In addition, a read-only connection abstraction point is provided for Business Critical service tiers.

Since Microsoft manages the complete platform and infrastructure of Azure SQL Managed Instance, users get the benefit of a Service Level Agreement (SLA) for availability. Since customers must manage the infrastructure for Azure Arc-enabled SQL Managed Instance, a SLA isn't provided.

### Disaster Recovery

Like Azure SQL Managed Instance, Azure Arc-enabled SQL Managed Instance provides an automatic backup system for databases including point-in-time restore.

Users configure a desired Recovery Point Objective (RPO) and Recovery Time Objective (RTO). These settings determined how often transaction log backups are taken and how long backups are kept.

Azure SQL Managed Instance provides built-in redundancy for backups using Azure storage. Users for Azure Arc-enabled SQL Managed Instance can configure a specific Kubernetes storage class to be used for SQL backups but are responsible for any redundancy needs.

## Migration

## Interfaces for Azure Arc-enabled SQL Managed Instance

The following interfaces can be used with Azure Arc-enabled SQL Managed Instance to manage the instance and build applications:

### SQL Server Management Studio (SSMS)

### Azure Data Studio (ADS)

### Azure portal

### az CLI

### kubectl

### SQL providers