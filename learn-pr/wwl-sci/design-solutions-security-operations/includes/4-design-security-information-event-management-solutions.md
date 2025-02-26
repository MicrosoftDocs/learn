Microsoft Sentinel is a cloud-native Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR) solution. It helps enterprises collect large volumes of security data, detect and investigate potential threats, and automate response actions. By integrating with a wide array of data sources and using advanced analytics, Microsoft Sentinel streamlines security operations and reduces the time needed to address threats.

A Log Analytics workspace is a data store into which you can collect any type of log data from all of your Azure and non-Azure resources and applications. Microsoft Sentinel, and other Azure services, including Azure Monitor and Microsoft Defender for Cloud use a Log Analytics workspace as the underlying storage and analytics engine for all ingested data. Microsoft Sentinel uses the data in the workspace to power its core features, including analytics rules, threat hunting, incident investigation, and workbooks.

Because the Log Analytics workspace is where all ingested data is stored, organizations need to consider factors including the number of workspaces needed for their environment and the configuration and placement of those workspaces to meet their requirements while optimizing costs. This unit presents criteria to consider when designing your workspace architecture. For information on Microsoft Sentinel capabilities, see [What is Microsoft Sentinel?](/azure/sentinel/overview) For information on concepts related to Log Analytics workspaces, see [Log Analytics workspace overview](/azure/azure-monitor/logs/log-analytics-workspace-overview).

## Design strategy
Your design should always start with a single workspace to reduce the complexity of managing multiple workspaces and in querying data from them. There are no performance limitations from the amount of data in your workspace. Multiple services and data sources can send data to the same workspace. As you identify criteria to create more workspaces, your design should use the fewest number of workspaces to meet your requirements.

Designing a workspace configuration includes evaluation of multiple criteria. But some of the criteria might be in conflict. For example, you might be able to reduce egress charges by creating a separate workspace in each Azure region. Consolidating into a single workspace might allow you to reduce charges even more with a commitment tier. Evaluate each of the criteria independently. Consider your requirements and priorities to determine which design is most effective for your environment.

## Design criteria
The following table presents criteria to consider when you design your workspace architecture. 

| Criteria | Description |
|:---|:---|
| [Operational and security data](/azure/azure-monitor/logs/workspace-design#operational-and-security-data) | You may choose to combine operational data from Azure Monitor in the same workspace as security data from Microsoft Sentinel or separate each into their own workspace. Combining them gives you better visibility across all your data, while your security standards might require separating them so that your security team has a dedicated workspace. You may also have cost implications to each strategy. |
| [Azure tenants](/azure/azure-monitor/logs/workspace-design#azure-tenants) | If you have multiple Azure tenants, you'll usually create a workspace in each one. Several data sources can only send monitoring data to a workspace in the same Azure tenant. |
| [Azure regions](/azure/azure-monitor/logs/workspace-design#azure-regions) | Each workspace resides in a particular Azure region. You might have regulatory or compliance requirements to store data in specific locations. |
| [Data ownership](/azure/azure-monitor/logs/workspace-design#data-ownership) | You might choose to create separate workspaces to define data ownership. For example, you might create workspaces by subsidiaries or affiliated companies. |
| [Split billing](/azure/azure-monitor/logs/workspace-design#split-billing) | By placing workspaces in separate subscriptions, they can be billed to different parties. |
| [Data retention](/azure/azure-monitor/logs/workspace-design#data-retention) | You can set different retention settings for each workspace and each table in a workspace. You need a separate workspace if you require different retention settings for different resources that send data to the same tables. |
| [Commitment tiers](/azure/azure-monitor/logs/workspace-design#commitment-tiers) | Commitment tiers allow you to reduce your ingestion cost by committing to a minimum amount of daily data in a single workspace. |
| [Legacy agent limitations](/azure/azure-monitor/logs/workspace-design#legacy-agent-limitations) | Legacy virtual machine agents have limitations on the number of workspaces they can connect to. |
| [Data access control](/azure/azure-monitor/logs/workspace-design#data-access-control) | Configure access to the workspace and to different tables and data from different resources. |
| [Resilience](/azure/azure-monitor/logs/workspace-design#resilience)| To ensure that data in your workspace is available in the event of a region failure, you can ingest data into multiple workspaces in different regions.|

## Work with multiple workspaces
Many designs include multiple workspaces. For example, a central security operations team might use its own Microsoft Sentinel workspaces to manage centralized artifacts like analytics rules or workbooks.

Microsoft Sentinel includes features to assist you in analyzing this data across workspaces. For more information, see [Extend Microsoft Sentinel across workspaces and tenants](/azure/sentinel/extend-sentinel-across-workspaces-tenants)

When naming each workspace, we recommend including a meaningful indicator in the name so that you can easily identity the purpose of each workspace.

## Multiple tenant strategies
Environments with multiple Azure tenants, including Microsoft service providers (MSPs), independent software vendors (ISVs), and large enterprises, often require a strategy where a central administration team has access to administer workspaces located in other tenants. Each of the tenants might represent separate customers or different business units.

> [!NOTE]
> For partners and service providers who are part of the [Cloud Solution Provider (CSP) program](https://partner.microsoft.com/membership/cloud-solution-provider), Log Analytics in Azure Monitor is one of the Azure services available in Azure CSP subscriptions.

Two basic strategies for this functionality are described in the following sections.

### Distributed architecture
In a distributed architecture, a Log Analytics workspace is created in each Azure tenant. This option is the only one you can use if you're monitoring Azure services other than virtual machines.

There are two options to allow service provider administrators to access the workspaces in the customer tenants:

- Use [Azure Lighthouse](/azure/lighthouse/overview) to access each customer tenant. The service provider administrators are included in a Microsoft Entra user group in the service provider's tenant. This group is granted access during the onboarding process for each customer. The administrators can then access each customer's workspaces from within their own service provider tenant instead of having to sign in to each customer's tenant individually. For more information, see [Monitor customer resources at scale](/azure/lighthouse/how-to/monitor-at-scale).
- Add individual users from the service provider as [Microsoft Entra guest users (B2B)](/azure/active-directory/external-identities/what-is-b2b). The customer tenant administrators manage individual access for each service provider administrator. The service provider administrators must sign in to the directory for each tenant in the Azure portal to access these workspaces.

Advantages to this strategy:

- Logs can be collected from all types of resources.
- The customer can confirm specific levels of permissions with [Azure delegated resource management](/azure/lighthouse/concepts/architecture). Or the customer can manage access to the logs by using their own [Azure RBAC](/azure/role-based-access-control/overview).
- Each customer can have different settings for their workspace, such as retention and data cap.
- Isolation between customers for regulatory and compliance.
- The charge for each workspace is included in the bill for the customer's subscription.

Disadvantages to this strategy:

- Running a query over a large number of workspaces is slow and can't scale above 100 workspaces. This means that you can create a central visualization and data analytics but it is slow if there are more than a few dozen workspaces. This situation is less acute if all workspaces are colocated on the same [dedicated cluster](/azure/azure-monitor/logs/logs-dedicated-clusters). See [here](/azure/azure-monitor/logs/cross-workspace-query) for more details on running queries across workspaces.
- If customers aren't onboarded for Azure delegated resource management, service provider administrators must be provisioned in the customer directory. This requirement makes it more difficult for the service provider to manage many customer tenants at once.
- When running a query on a workspace, the workspace admins might have visibility to the full text of the query via [query audit](/azure/azure-monitor/logs/query-audit).

### Centralized
A single workspace is created in the service provider's subscription. This option can collect data from customer virtual machines and Azure PaaS services based on diagnostics settings. Agents installed on the virtual machines and PaaS services can be configured to send their logs to this central workspace.

Advantages to this strategy:

- It's easy to manage many customers.
- The service provider has full ownership over the logs and the various artifacts, such as functions and saved queries.
- A service provider can perform analytics across all of its customers.

Disadvantages to this strategy:

- Logs can only be collected from virtual machines with an agent or Azure PaaS services (via Azure Lighthouse delegation). It won't work with SaaS connectors, or Azure Service Fabric data sources.
- It might be difficult to separate data between customers because their data shares a single workspace. Queries need to use the computer's fully qualified domain name or the Azure subscription ID.
- All data from all customers will be stored in the same region with a single bill and the same retention and configuration settings.

### Hybrid
In a hybrid model, each tenant has its own workspace. A mechanism is used to pull data into a central location for reporting and analytics. This data could include a small number of data types or a summary of the activity, such as daily statistics.

There are several options to implement logs in a central location:

- **Central workspace**: The service provider creates a workspace in its tenant and pulls data from the various workspaces using:
    - A script that uses the [Query API](/azure/azure-monitor/logs/api/overview) with the [logs ingestion API](/azure/azure-monitor/logs/logs-ingestion-api-overview) to send the data from the tenant workspaces to the central workspace.
    - [Azure Logic Apps](/azure/logic-apps/logic-apps-overview) to copy data to the central workspace.
    - [Data export](/azure/azure-monitor/logs/logs-data-export) from the source workspace and re-ingestion to the central workspace. You can also create [summary rules](/azure/azure-monitor/logs/summary-rules) to export an aggregation of key data from the original workspaces into the central workspace.
- **Power BI**: The tenant workspaces export data to Power BI by using the integration between the [Log Analytics workspace and Power BI](/azure/azure-monitor/logs/log-powerbi).
