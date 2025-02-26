The data residency and security requirements that your company must adhere to are relatively common. Industries that are subject to compliance rules and regulatory oversight often have these requirements. While these requirements tend to limit the scope of workloads suitable for migration to the cloud, Microsoft offers a range of solutions that you can use to apply the power of Azure while operating in your own datacenters. These solutions include the suite of Azure Arc products that extend the Azure platform to help you modernize applications and services hosted on-premises and in non-Microsoft cloud environments.

## Features of Azure Arc-enabled SQL Managed Instance

In the data services category, an Azure Arc-enabled SQL Managed Instance offers nearly the same functionality and user experience as Microsoft SQL Server. It also includes several manageability, elasticity, and resiliency capabilities of Azure SQL Managed Instance. Most of the standard SQL language, query processing, database management, and security features are identical across both managed instance offerings and the latest version of SQL Server. For comparison, see the table in the following diagram.

:::image type="content" source="../media/dbengine-featureset-comparison-by-deployment-model.png" alt-text="Diagram of database engine feature comparison by deployment model." border="false":::

> [!NOTE]
> For a comprehensive list of features of an Azure Arc-enabled SQL Managed Instance, see [Azure Arc-enabled SQL Managed Instance](/azure/azure-arc/data/managed-instance-features).

Considering your investment in containerization, the choice of Kubernetes as the container orchestration platform, and the existing Azure SQL deployments, migrating your remaining on-premises SQL Server workloads to an Azure Arc-enabled SQL Managed Instance promises to yield the benefits that your company's technology leadership is seeking. These benefits include minimized administrative overhead, streamlined operational model, and increased resiliency. After you decide to follow this migration path, your next decision point is to choose the service tier.

## Service Tiers

Azure Arc-enabled SQL Managed Instance is available in two service tiers:

- **General Purpose** is a budget-friendly tier designed for most workloads with common performance and availability features that are part of SQL Server Standard Edition.
- **Business Critical** is designed for performance-sensitive workloads with a wider range of features that are part of SQL Server Enterprise Edition.

From the perspective of the feature sets and their intended use case, both tiers map closely to the ones available in Azure SQL Managed Instance, as illustrated in the following table. However, keep in mind that scalability, performance, and resiliency considerations are different because with Azure Arc-enabled SQL Managed Instance, you, as a customer of Azure Arc data services, control the underlying hardware resources.

:::image type="content" source="../media/service-tier-comparison-1.png" alt-text="Diagram comparing the Azure Arc-enabled service tiers." border="false":::

In general, you should consider using the **General Purpose** service tier if any of the following conditions are satisfied:

- Expected CPU and memory requirements are within the limits of the General Purpose service tier.
- The resiliency options provided by Kubernetes, such as pod redeployment, is sufficient to satisfy availability Service Level Agreements (SLAs).
- Scaling out and readable secondaries aren't required.
- The workload doesn't rely on any of the SQL Server Enterprise Edition-specific features.

Consider using the **Business Critical** service tiers if:

- The expected CPU and memory requirements exceed the limits of the General Purpose service tier.
- Availability SLAs are more stringent and require a faster failover, such as the one offered by Always On availability groups.
- Read-only workloads would benefit from the use of secondary replicas.
- The workload requires SQL Server Enterprise Edition-specific features.
