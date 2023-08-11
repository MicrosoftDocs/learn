Relecloud wants to ensure that resources and data for customers like Lamna Healthcare are secure. By using Microsoft Sentinel and Azure Lighthouse, you can help Relecloud secure customers' tenants. You'll explore how to use Microsoft Sentinel with Azure Lighthouse to detect and investigate security incidents across multiple customer tenants.

## Couple Microsoft Sentinel with Azure Lighthouse

With Azure Lighthouse, you can use Microsoft Sentinel to build a sophisticated Security as a service offering. Microsoft Sentinel provides features such as threat intelligence, alert detection, security analytics, and more. You couple Azure Lighthouse with Microsoft Sentinel to manage multiple Microsoft Sentinel customer workspaces simultaneously.

You can then run queries through multiple customer workspaces, or provide insights by creating workbooks that you use to monitor and visualize data across customer data sources. Playbooks, queries, and other intellectual property stay in your Azure tenant, but can make actions on customers’ tenants.

Here’s an overview of how to use Azure Lighthouse with Microsoft Sentinel.

:::image type="content" source="../media/5-azure-sentinel-lighthouse.png" alt-text="Diagram of Microsoft Sentinel with Azure Lighthouse.":::

### Centralized deployment model

Because you operate Microsoft Sentinel from a central location to manage all your customer’s Microsoft Sentinel workspaces, you can take advantage of the following benefits:

- Keep customer data isolated from other customers
- Ensure that customer data is stored within their tenant and that it stays within geographical boundaries
- Improved network latency when performing actions on customer workspaces
- Related costs are never charged to your tenant, but go directly to the customer for whom you’re providing services
- Integration with many customer data sources including Microsoft Threat Protection alerts, Azure Active Directory Activity logs, Microsoft 365 logs, and more
- Flexibility to accommodate the addition or removal of new customers, or their subsidiaries

### Manage Microsoft Sentinel using role-based access control (RBAC)

Because you use Azure Lighthouse to onboard customers through Azure delegated resource management, your managing users can access and perform actions directly on your customers' Microsoft Sentinel workspaces. To enable your managing users and service principals to do their jobs, you can assign them the Microsoft Sentinel built-in RBAC roles:

|Role| Description|
| ------------------------------ | ------------------------------------------------------------ |
| **Microsoft Sentinel Reader**| Can view data, dashboards, incidents, and other Microsoft Sentinel resources |
| **Microsoft Sentinel Responder**| Can perform all the actions of Microsoft Sentinel Reader, and manage incidents |
| **Microsoft Sentinel Contributor** | Can perform all the actions of Microsoft Sentinel Responder, but also create and edit dashboards, and analytic rules |

After you've onboarded your customers, users sign in to your tenant to directly access customers' workspaces based on the roles you've assigned them.

### Manage multiple workspaces

As a managing user, you can open Microsoft Sentinel in the Azure portal to view a list of all the customer workspaces you can access. You can choose to look at a single workspace, or expand your focus to multiple workspaces. Alternatively, you could investigate any incidents that have been detected across all your customers’ workspaces:

:::image type="content" source="../media/5-incidents-multiple-customers-inline.png" alt-text="Screenshot of managing incidents across multiple workspaces."  lightbox="../media/../media/5-incidents-multiple-customers-expanded.png":::

You can create a single Log Analytics query to run across all customer workspaces. This way, you'll investigate and correlate information from your customers in a single query. Use this query to gain a detailed understanding of your customers' tenants.

You can use a single Union operator and the `workspace()` expression to write your query like this:

```sql
Workspace(‘contoso/contosoretail/contosoretail-it’).SecurityEvent| union workspace(‘contosoretail-nl’).SecurityEvent,workspace(…)… | where …
```

KQL view functions make it easier to reuse complex queries like this, so you can save this whole expression into a single function called `cswSecurityEvent`:

```sql
cswSecurityEvent| where …
```

You can then use it run your query across all the workspaces.

### Use playbooks to respond to alerts

You can create playbooks to mitigate alerts Microsoft Sentinel detects. Playbooks help you to respond automatically or manually to alerts based on your needs. You can use a playbook that automatically responds to threats in a customer’s tenant. For customers who want to be more involved, you can deploy playbooks into their tenants and configure them to allow users to be notified and act in response to threats.

### Use workbooks across tenants

You use Microsoft Sentinel with Azure Monitor workbooks to monitor and analyze data in customer Microsoft Sentinel workspaces. With Azure Monitor workbooks, you can create your own custom workbooks, but also use prebuilt templates:

:::image type="content" source="../media/5-prebuilt-workbooks-inline.png" alt-text="Screenshot of prebuilt workspaces in Sentinel." lightbox="../media/5-prebuilt-workbooks-expanded.png":::

You deploy workbooks in your tenant to query and monitor data in customer tenants through [cross-workspace monitoring](/azure/sentinel/extend-sentinel-across-workspaces-tenants#using-cross-workspace-workbooks). You can also deploy a workbook directly in a tenant that you manage for a customer.

### View incidents using Microsoft Sentinel workspaces

In this video, you’ll see how to use Microsoft Sentinel with Azure Lighthouse to get a cross-tenant view of all incidents in your customers’ subscriptions.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4B4w3]
