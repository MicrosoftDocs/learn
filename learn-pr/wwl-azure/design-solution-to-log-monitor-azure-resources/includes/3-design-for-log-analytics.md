Azure Monitor stores [log](/azure/azure-monitor/logs/data-platform-logs) data in an Azure Monitor Logs (Log Analytics) workspace. A workspace is an Azure resource that serves as an administrative boundary or geographic location for data storage. The workspace is also a container where you collect and aggregate data.

While you can deploy one or more workspaces in your Azure subscription, there are several considerations you should understand to ensure your initial deployment follows Microsoft guidelines. The workspace should provide a cost effective, manageable, and scalable deployment that meets your organization's needs.

### Things to know about Azure Monitor Logs workspaces

Review these characteristics of Azure Monitor Logs workspaces and consider how they can contribute to your monitoring solution for Tailwind Traders.

- In a workspace, you can isolate data by granting different users access rights following Microsoft recommended design strategies.

- Data in an Azure Monitor Logs workspace is organized into tables. Each table stores different kinds of data and has its own unique set of properties based on the resource that's generating the data. Most data sources write to their own tables in an Azure Monitor Logs workspace.

- A workspace enables you to configure settings like [pricing tier](/azure/azure-monitor/logs/manage-cost-storage), [retention](/azure/azure-monitor/logs/manage-cost-storage#log-data-retention-and-archive), and [data capping](/azure/azure-monitor/logs/daily-cap) based on administrative boundaries or geographic locations.

- With Azure role-based access control (Azure RBAC), you can grant users and groups only the amount of access they need to work with monitoring data in a workspace. You can align the user access control with your IT organization operating model by using a single workspace to store collected data enabled on all resources.

- Workspaces are hosted on physical clusters. By default, the system creates and manages these clusters. If your system ingests more than 500 GB of data per day, you create your own dedicated clusters for your workspaces to support greater control and higher ingestion rate.

### Things to consider when using Azure Monitor Logs workspaces

Now you're ready to review considerations for designing with Azure Monitor Logs workspaces in the Tailwind Traders architecture.

- **Consider your access control strategy**. As you plan for how many workspaces to use in the Tailwind Traders organization, consider these potential requirements:
   - Is your organization a global company? Do you need log data stored in specific regions for data sovereignty or compliance reasons?
   - Does your architecture use Azure? Do you want to avoid outbound data transfer charges by having a workspace in the same region as the Azure resources it manages?
   - Does the system support multiple departments or business groups? Each group should access their data and not the data of others. Also, there's no business requirement for a consolidated cross department or business group view.

- **Consider deployment model options**. Most IT organizations use a centralized, decentralized, or hybrid model for their architecture. Consider these common workspace deployment models, and how they might work for the Tailwind Traders organization:

   | Deployment | Description |
   | --- | --- |
   | **Centralized** | All logs are stored in a central workspace and administered by a single team. Azure Monitor provides differentiated access per-team. In this scenario, it's easy to manage, search across resources, and cross-correlate logs. The workspace can grow significantly depending on the amount of data collected from multiple resources in your subscription. Extra administrative overhead is needed to maintain access control to different users. This model is known as _hub and spoke_. |
   | **Decentralized** | Each team has their own workspace created in a resource group they own and manage. Log data is segregated per resource. In this scenario, the workspace can be kept secure and access control is consistent with resource access. A disadvantage of this module is that it can be difficult to cross-correlate logs. Users who need a broad view of many resources can't analyze the data in a meaningful way. |
   | **Hybrid** | A hybrid approach can be complicated by security audit compliance requirements. Many organizations implement both deployment models in parallel. The hybrid design commonly results in a complex, expensive, and hard-to-maintain configuration with gaps in logs coverage. |

- **Consider access mode**. Plan for how your users can access Azure Monitor Logs workspaces and define the scope of data they can access. Tailwind Traders users have two options for accessing their data: 

   | Access&nbsp;mode | Description |
   | --- | --- |
   | _Workspace-context_ | A user can review all logs in the workspace for which they have permission. Queries are scoped to all data in all tables in the workspace. Logs are accessed with the workspace as the scope by selecting **Logs** from the **Azure Monitor** menu in the Azure portal. |
   | _Resource-context_ | A user accesses the workspace for a particular resource, resource group, or subscription. By selecting **Logs** from a resource menu in the Azure portal, they can view logs for only resources in all tables for which they have access. Queries are scoped to only data associated with that resource. This mode also enables granular Azure RBAC. |

- **Consider Azure RBAC and workspaces**. Control which users have access to which resources according to their workspace associations. You might grant access to the team responsible for Tailwind Traders infrastructure services hosted on Azure Virtual Machines. You can give the team access to only the logs generated by the Virtual Machines. This approach follows the new resource-context log model. The basis for this model is for every log record emitted by an Azure resource, it's automatically associated with this resource. Logs are forwarded to a central workspace that respects scoping and Azure RBAC based on the resources.

- **Consider scale and ingestion volume rate limit**. Azure Monitor is a high scale data service that serves thousands of customers sending petabytes of data each month at a growing pace. Workspaces aren't limited in their storage space and can grow to petabytes of data. There's no need to split workspaces due to scale.

### Recommendations

As you consider your options for implementing Azure Monitor Logs workspaces and access control in your monitoring and logging solution, review these recommendations. This scenario shows a recommended design for a single workspace in your IT organization's subscription. 

:::image type="content" source="../media/workspace-design-expanded.png" alt-text="Diagram that shows how to design an Azure Monitor Logs deployment." lightbox="../media/workspace-design-expanded.png" border="false":::

The workspace isn't constrained by data sovereignty or regulatory compliance. It doesn't need to map to the regions where your resources are deployed. Your organization's security and IT admin teams can take advantage of the improved integration with Azure access management and more secure access control.

All resources, monitoring solutions, and insights like Application Insights and virtual machine insights are configured to forward their collected log data to the IT organization's centralized shared workspace. Log data from the supporting infrastructure and apps maintained by different teams is also sent to the centralized shared workspace. 

Users on each team are granted access to logs for resources for which they have been given access.

After you deploy your workspace architecture, you can enforce this same model on Azure resources with [Azure Policy](/azure/governance/policy/overview). You can define policies and ensure compliance with your Azure resources, so they send all their resource logs to a particular workspace. By using Azure Virtual Machines or Virtual Machine Scale Sets, you can use existing policies that evaluate workspace compliance and report results, or customize to remediate if non-compliant.