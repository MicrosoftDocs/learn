Relecloud wants to ensure that resources and data for customers like Lamna Healthcare are secure. With the help of Azure Sentinel and Azure Lighthouse, you can help Relecloud secure customers’ tenants. You’ll explore how you can take advantage of Azure Sentinel with Azure Lighthouse to detect and investigate security incidents across multiple customer tenants.

## Coupling Azure Sentinel with Azure Lighthouse

With Azure Lighthouse, you are able to build a sophisticated Security-as-a-service offering using Azure Sentinel. Azure Sentinel provides features such as threat intelligence, alert detection, security analytics, and more. You couple Azure Lighthouse with Azure Sentinel to enable you to manage multiple Azure Sentinel customer workspaces simultaneously.

You’re able then to run queries through multiple customer workspaces, or provide insights by creating workbooks that you can use to monitor and visualize data across customer data sources. Your playbooks, queries, and other intellectual property stay in your Azure tenant, but can perform actions on your customers’ tenants. 

### Centralized deployment model

Because you operate Azure Sentinel from a central location to manage all your customer’s Azure Sentinel workspaces, you’re able to take advantage of the following benefits:
-	Keep customer data isolated from other customers
-	Ensure that customers data is stored within their tenant and it stays within their geographical boundaries
-	Improved network latency when performing actions on customer workspaces
-	Related costs are never charged to your tenant, but go directly to the customer you’re providing services to
-	Integration with many customer data sources including Microsoft Threat Protection alerts, Azure Active Directory Activity logs, Microsoft 365 logs, and more
-	Flexibility to accommodate the addition or removal of new customers or their subsidiaries

### Manage Azure Sentinel using role-based access control (RBAC)

Because Azure Lighthouse enables you to onboard your customers through Azure delegated resource management, your managing users are able to access and perform actions directly on your customers Azure Sentinel workspaces. To enable your managing users and your service principals to do their jobs, you assign them the Azure Sentinel built-in RBAC roles:

|Role| Description|
| ------------------------------ | ------------------------------------------------------------ |
| **Azure Sentinel Reader**| Can view data, dashboards, incidents, and other   Azure Sentinel resources |
| **Azure Sentinel Responder**| Can perform all the actions that Azure Sentinel Reader can, but can   also manage incidents. |
| **Azure Sentinel Contributor** | Can perform all the actions that Azure Sentinel   Responder can but can also create and edit dashboards, and analytic rules |

After customers have been onboarded, your users sign in to your tenant to directly access customers’ workspaces based on the roles that have been assigned to them.

### Manage multiple workspaces

As a managing user, you open Azure Sentinel in the Azure portal to view a list of all the customer workspaces which you’ve been given access to.  You can decide to look at a single workspace, or expand your focus to multiple workspaces. Alternatively, you can choose to investigate any incidents that have been detected across all your customers’ workspaces:

:::image type="content" source="../media/5-incidents-multiple-customers.png" alt-text="Incidents across multiple workspaces":::

You can create a single Log Analytics query to run across all customer workspaces. This way, you can investigate and correlate information from your customers in a single query. You use it to gain a detailed understanding into your customers' tenants.

### Use Playbooks to respond to alerts

You create playbooks to mitigate alerts that have been detected by Azure Sentinel. Playbooks help you to respond automatically or manually to alerts based on your needs. You’re able to use a playbook that automatically responds to threats in a customer’s tenant. But for those customers that want to be more involved, you can deploy your playbooks into their tenants and configure them in such a way as to allow users in their tenants to be notified to act in response to threats.

### Use workbooks across tenants

You use Azure Sentinel with Azure Monitor Workbooks to enable you to monitor and analyze data in customer Azure Sentinel workspaces. With Azure Monitor Workbooks you’re able to create your own custom workbooks, but also take advantage of prebuilt workbook templates:

:::image type="content" source="../media/5-prebuilt-workbooks.png" alt-text="Prebuilt workspaces":::

You deploy your workbooks in your tenant to enable you to query and monitor data in customer tenants, but you can also deploy a workbook directly in a tenant that you manage for a customer.