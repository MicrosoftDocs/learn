Azure Arc-enabled SQL Managed Instance is an Azure SQL service powered by the SQL Server engine that can be deployed on the infrastructure of your choice.

## Comparison with Azure SQL

Azure SQL is a family of database services deployed in the Azure infrastructure:

### SQL Server in Azure Virtual Machine

This Azure SQL deployment option allows a fully licensed SQL Server product to run on the version of your choice on Windows or Linux. The user manages everything inside the guest virtual machine. The infrastructure is managed by Microsoft. This option is known as Infrastructure as a Service (IaaS).

### Azure SQL Managed Instance

This Azure SQL deployment option provides a pre-installed, versionless SQL Server instance as a fully managed service. The user has access to almost 100% capabilities of a SQL Server engine instance. Microsoft manages all aspects of the platform and infrastructure required to host the instance. This option is an example of a Platform as a Service (PaaS).

### Azure SQL Database

This Azure SQL deployment option provides a contained SQL Server database powered by a pre-installed, versionless SQL Server as a fully managed service. The user manages the database while Microsoft manages the underlying SQL instance, platform, and infrastructure. This option is also an example of a Platform as a Service (PaaS).

### Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance is similar to Azure SQL Managed Instance. It has similar features and management capabilities. The intention of Azure Arc-enabled SQL Managed Instance is to provide the same Platform as a Service (PaaS) capabilities and experience of Azure, while the customer chooses and manages the infrastructure using the Kubernetes platform.

## Comparison of features

To understand the capabilities of Azure Arc-enabled SQL Managed Instance, it's important to look at its core features, deployment options, and integration with Azure.

### Core features

Since Azure Arc-enabled SQL Managed Instance is based on the SQL Server engine, it provides core instance features almost 100% compatible with SQL Server and Azure SQL Managed Instance. The instance includes a compatible T-SQL language interface and all the features of security, performance, and availability. You can learn more about [features](/azure/azure-arc/data/managed-instance-features) for Azure Arc-enabled SQL Managed instance in the Microsoft documentation.

Like Azure SQL Managed instance, when you deploy Azure Arc-enabled SQL Managed instance you get a pre-installed, versionless SQL Server. Azure Arc-enabled SQL Managed instance uses container images from the Microsoft Container Registry (MCR).

Azure SQL Managed Instance uses gateway servers to abstract the application from underlying connectivity details. Azure Arc-enabled SQL Managed Instance also provides connection abstraction using Kubernetes LoadBalancer or NodePort services.

### Service tiers

Like Azure SQL Managed Instance, you can deploy Azure Arc-enabled SQL Managed instance with two deployment options called service tiers:

- **General Purpose** - As its name implies, this service tier is for most workloads. This service tier has a limit for resources such as core and memory but comes with built-in basic high availability through Kubernetes and shared storage. Instances in the general purpose tier map to features supported in SQL Server Standard Edition.

- **Business Critical** - This service tier is designed for workloads that require the best performance and highest level of availability. This service tier has no limits for memory or cores and uses availability groups to provide high availability with read scale-out. Instances in the Business Critical tier map to features supported in SQL Server Enterprise Edition.

Both service tiers are billed on a per core basis but also include the ability to use Azure Hybrid Benefit licensing and a developer option for no cost. Business Critical service tier is currently under preview so won't incur any charges for use. You can learn more about [service tiers](/azure/azure-arc/data/service-tiers) in the Microsoft documentation.

### Azure integration

When you deploy an Azure SQL Managed instance, billing, usage, metrics, and logs can be integrated with Azure. Furthermore, you can use Azure interfaces such as the portal to deploy and configure an Azure SQL Managed Instance.

Integration with Azure for Azure Arc-enabled SQL Managed instance depends on which connected mode you use.

Integration with Azure is handled automatically with direct connected mode through Azure Arc agents and the Azure Arc data controller. Azure interfaces such as the Azure portal can be used for deployment and configuration.

If you use indirect-connected mode, a minimal amount of data must be sent to Azure for billing purposes. Optionally, you can export data such as metrics and logs. Deployment and configuration through the Azure portal isn't supported with indirect-connected mode. However, interfaces such as the az CLI and kubectl can be used for deployment and configuration.

## Comparison of management capabilities

Since Azure Arc-enabled SQL Managed instance is a managed service, it's useful to compare management capabilities with Azure SQL Managed instance such as a versionless engine, deployment and configuration, monitoring, high availability, and disaster recovery.

### Versionless

One of the benefits of using Azure SQL Managed Instance is the elimination of the need to patch and update SQL Server, the operating system, and any platform software. The engine for Azure SQL Managed instance is often referred to as *versionless*, because there isn't the concept of a major version as with SQL Server. The instance is constantly updated as needed for software patches or new functionality.

Azure Arc-enabled SQL Managed instance also uses a versionless engine so updates can be applied automatically as needed through updated container images. Availability is maintained by using the power of Kubernetes to stop and start new containers.

### Deployment and configuration

Deployment of Azure Arc-enabled SQL Managed Instance is an easy, declarative process much like Azure SQL Managed Instance. When you deploy an Azure Arc-enabled SQL Managed Instance, you can specify a service tier, core and memory limits, storage class specifications, and SQL configuration options such as SQL Server Agent, collation, and trace flags.

In direct connected mode, Azure Arc-enabled SQL Managed Instance can be deployed with the Azure portal. In indirect connected mode, Azure Arc-enabled SQL Managed Instance can be deployed using az CLI (using the arcdata extension), kubectl, or Azure Data Studio.

Outside of the SQL instance, Azure Arc-enabled Managed Instance can also be configured in direct connected mode using the Azure portal. In either connected mode, options can be configured outside of the SQL instance with az CLI or kubectl.

Inside the SQL instance, standard SQL Server interfaces such as sp_configure, ALTER SERVER CONFIGURATION, and ALTER DATABASE can be used to configure the instance and database options.

### Monitoring

Like Azure SQL Managed Instance, you can monitor Azure Arc-enabled SQL Managed instance using Azure monitor for key metrics. Locally within the cluster, you can also use built in monitoring with Grafana dashboards for nodes or the SQL instance.

Logs for Azure Arc-enabled SQL Managed Instance are available to view in the Azure portal through log analytics. Locally within the cluster, you can also use built in logs with Kibana.

Since Azure Arc-enabled SQL Managed Instance is based on SQL Server, the standard ERRORLOG files are available to view SQL errors and instance details. Azure Arc-enabled SQL Managed Instance also supports all available Dynamic Management Views (DMV) and Extended Events.

### High availability

One of the benefits of using a managed service like Azure Arc-enabled SQL Managed Instance is built in high availability. Like Azure SQL Managed Instance, the method used to achieve high availability depends on the service tier.

For the General Purpose service tier, the built-in high availability of Kubernetes StatefulSets is used with shared storage.

For the Business Critical service tier, built in high availability is provided using a combination of Kubernetes StatefulSets and SQL Server Always On Availability Group replicas. Availability Group replicas are automatically deployed and configured for the user. Like Azure SQL Managed Instance, a read-only replica is available to offload read workloads. System databases such as master and model are part of the availability group. System level objects such as SQL Agent jobs will automatically be available after a failover event.

Kubernetes LoadBalancers and NodePorts provide connection abstraction for the application should the instance move within the cluster. In addition, a read-only connection abstraction point is provided for Business Critical service tiers.

Since Microsoft manages the complete platform and infrastructure of Azure SQL Managed Instance, users get the benefit of a Service Level Agreement (SLA). Since customers must manage the infrastructure for Azure Arc-enabled SQL Managed Instance, any SLA is managed and owned by the customer.

### Disaster recovery

Like Azure SQL Managed Instance, Azure Arc-enabled SQL Managed Instance provides an automatic backup system for databases including point-in-time restore. Users can manually execute COPY_ONLY backups and restore them at any time.

Users configure a desired Recovery Point Objective (RPO) and retention period. These settings determine how often transaction log backups are taken and how long backups are kept.

Azure SQL Managed Instance provides built in redundancy for backups using Azure storage. Users for Azure Arc-enabled SQL Managed Instance can configure a specific Kubernetes storage class to be used for SQL backups but are responsible for any redundancy needs.

## Migration

Because Azure Arc-enabled SQL Managed Instances uses a SQL Server engine, existing SQL Server versions can be migrated using database backup and restore. Databases can be restored directly from Azure Storage or by copying a local backup into the container for the SQL Managed Instance.

## Interfaces for Azure Arc-enabled SQL Managed Instance

The following interfaces can be used with Azure Arc-enabled SQL Managed Instance to manage the instance and build applications:

### SQL Server Management Studio (SSMS)

[SQL Server Management Studio](/sql/ssms/download-sql-server-management-studio-ssms) (SSMS) is fully compatible to query and manage an Azure Arc-enabled SQL Managed Instance.

### Azure Data Studio (ADS)

[Azure Data Studio](https://azure.microsoft.com/services/developer-tools/data-studio/) (ADS) is a multi-platform tool that can query and manage an Azure Arc-enabled SQL Managed Instance. ADS supports queries using T-SQL along with T-SQL notebooks. Also, you can use the ADS Azure Arc extension to create and manage Azure Arc-enabled data services resources such as the data controller, SQL Managed Instance, and PostgreSQL server (preview).

### SQL command-line tools

SQL command-line tools like sqlcmd and bcp are supported with Azure Arc-enabled SQL Managed Instance.

### Azure portal

If you are using direct connected mode, you can create, view, and manage Azure Arc-enabled data services from the [Azure portal](https://azure.microsoft.com/features/azure-portal/). Also, if you upload data using indirect connected mode, you can view Azure Arc-enabled SQL Managed Instance details in the Azure portal.

### az CLI

You can use the arcdata extension with the multi-platform [az](/cli/azure/) command-line interface (CLI) to create, view, and manage Azure Arc-enabled data services such as SQL Managed Instance. Az CLI can only be used in indirect connected mode to deploy an Azure Arc-enabled SQL Managed Instance. The az CLI is the primary interface to upload billing, metrics, and logs when using indirect connected mode.

### kubectl

You can use the multi-platform [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command-line interface (CLI) to create, view, and manage Azure Arc-enabled data services including SQL Managed Instance. The az CLI tool is the preferred command-line interface to use with Azure Arc-enabled SQL Managed Instance, but you can use yaml files with kubectl to create and manage resources. Kubectl can only be used in indirect connected mode to deploy an Azure Arc-enabled SQL Managed Instance. There are some scenarios, such as editing the default point-in-time restore configuration, which requires the use of kubectl.

### SQL drivers

You can use any supported [SQL Server driver](/sql/connect/sql-connection-libraries) for your application to connect and execute queries against an Azure Arc-enabled SQL Managed Instance. Driver support is included for popular programming languages such as C#, Java, Node.js, PHP, Python, and Ruby.
