Best practices for Sentinel workspace design fall into a few main categories:

- Tenancy considerations
- Compliance considerations
- Region considerations
- Access considerations
- Creating your workspace
- Simplify working with multiple workspaces

## Tenancy considerations

While fewer workspaces are simpler to manage, you may have specific needs for multiple tenants and workspaces. For example, many organizations have a cloud environment that contains multiple Microsoft Entra tenants, resulting from mergers and acquisitions or due to identity separation requirements.

When determining how many tenants and workspaces to use, consider that most Microsoft Sentinel features operate by using a single workspace or Microsoft Sentinel instance, and Microsoft Sentinel ingests all logs housed within the workspace.

Costs are one of the main considerations when determining Microsoft Sentinel architecture.

### Working with multiple tenants

If you have multiple tenants, such as if you're a managed security service provider (MSSP), we recommend that you create at least one workspace for each Microsoft Entra tenant to support built-in, service to service data connectors that work only within their own Microsoft Entra tenant.

All connectors based on diagnostics settings cannot be connected to a workspace that is not located in the same tenant where the resource resides. This applies to connectors such as Azure Firewall, Azure Storage, Azure Activity or Microsoft Entra ID.

Use Azure Lighthouse to help manage multiple Microsoft Sentinel instances in different tenants.

## Compliance considerations

After your data is collected, stored, and processed, compliance can become an important design requirement, with a significant impact on your Microsoft Sentinel architecture. Having the ability to validate and prove who has access to what data under all conditions is a critical data sovereignty requirement in many countries and regions, and assessing risks and getting insights in Microsoft Sentinel workflows is a priority for many customers.

In Microsoft Sentinel, data is mostly stored and processed in the same geography or region, with some exceptions, such as when using detection rules that leverage Microsoft's Machine learning. In such cases, data may be copied outside your workspace geography for processing.

To start validating your compliance, assess your data sources, and how and where they send data.

## Region considerations

Use separate Microsoft Sentinel instances for each region. While Microsoft Sentinel can be used in multiple regions, you may have requirements to separate data by team, region, or site, or regulations and controls that make multi-region models impossible or more complex than needed. Using separate instances and workspaces for each region helps to avoid bandwidth / egress costs for moving data across regions.

Consider the following when working with multiple regions:

- Egress costs generally apply when the Log Analytics or Azure Monitor agent is required to collect logs, such as on virtual machines.

- Internet egress is also charged, which may not affect you unless you export data outside your Log Analytics workspace. For example, you may incur internet egress charges if you export your Log Analytics data to an on-premises server.

- Bandwidth costs vary depending on the source and destination region and collection method. For more information, see:

  - [Bandwidth pricing](https://azure.microsoft.com/pricing/details/bandwidth/)
  - [Data transfers charges using Log Analytics ](/azure/azure-monitor/usage-estimated-costs).

- Use templates for your analytics rules, custom queries, workbooks, and other resources to make your deployments more efficient. Deploy the templates instead of manually deploying each resource in each region.

- Connectors that are based on diagnostics settings do not incur in-bandwidth costs. For more information, see [Data transfers charges using Log Analytics](/azure/azure-monitor/usage-estimated-costs).

For example, if you decide to collect logs from Virtual Machines in East US and send them to a Microsoft Sentinel workspace in West US, you'll be charged ingress costs for the data transfer. Since the Log Analytics agent compresses the data in transit, the size charged for the bandwidth may be lower than the size of the logs in Microsoft Sentinel.

If you're collecting Syslog and CEF logs from multiple sources around the world, you may want to set up a Syslog collector in the same region as your Microsoft Sentinel workspace to avoid bandwidth costs, provided that compliance is not a concern.

Understanding whether bandwidth costs justify separate Microsoft Sentinel workspaces depend on the volume of data you need to transfer between regions. Use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/details/bandwidth/) to estimate your costs.

For more information, see [Data residency in Azure](https://azure.microsoft.com/global-infrastructure/data-residency/).

## Access considerations

You may have situations planned where different teams will need access to the same data. For example, your SOC team must have access to all Microsoft Sentinel data, while operations and applications teams will need access to only specific parts. Independent security teams may also need to access Microsoft Sentinel features, but with varying sets of data.

Combine resource-context RBAC and table-level RBAC to provide your teams with a wide range of access options that should support most use cases.

### Resource-context RBAC

The following image shows a simplified version of a workspace architecture where security and operations teams need access to different sets of data, and resource-context RBAC is used to provide the required permissions.

[![Diagram of a sample architecture for resource-context RBAC.](../media/resource-context-rbac-sample.png)](../media/resource-context-rbac-sample.png#lightbox)

In this image, the Microsoft Sentinel workspace is placed in a separate subscription to better isolate permissions.

In addition to the security subscription, a separate subscription is used for the applications teams to host their workloads. The applications teams are granted access to their respective resource groups, where they can manage their resources. This separate subscription and resource-context RBAC allows these teams to view logs generated by any resources they have access to, even when the logs are stored in a workspace where they *don't* have direct access. The applications teams can access their logs via the **Logs** area of the Azure portal, to show logs for a specific resource, or via Azure Monitor, to show all of the logs they can access at the same time.

Azure resources have built-in support for resource-context RBAC, but may require additional fine-tuning when working with non-Azure resources.

### Table-level RBAC

Table-level RBAC enables you to define specific data types (tables) to be accessible only to a specified set of users.

For example, consider if the organization whose architecture is described in the image above must also grant access to Office 365 logs to an internal audit team. In this case, they might use table-level RBAC to grant the audit team with access to the entire **OfficeActivity** table, without granting permissions to any other table.

### Access considerations with multiple workspaces

If you have different entities, subsidiaries, or geographies within your organization, each with their own security teams that need access to Microsoft Sentinel, use separate workspaces for each entity or subsidiary. Implement the separate workspaces within a single Microsoft Entra tenant, or across multiple tenants using Azure Lighthouse.

Your central SOC team may also use an additional, optional Microsoft Sentinel workspace to manage centralized artifacts such as analytics rules or workbooks.

## Technical best practices for creating your workspace

Use the following best practice guidance when creating the Log Analytics workspace you'll use for Microsoft Sentinel:

- **When naming your workspace**, include *Microsoft Sentinel* or some other indicator in the name, so that it's easily identified among your other workspaces.

- **Use the same workspace for both Microsoft Sentinel and Microsoft Defender for Cloud**, so that all logs collected by Microsoft Defender for Cloud can also be ingested and used by Microsoft Sentinel. The default workspace created by Microsoft Defender for Cloud will not appear as an available workspace for Microsoft Sentinel.

- **Use a dedicated workspace cluster if your projected data ingestion is around or more than 1 TB per day**. A dedicated cluster enables you to secure resources for your Microsoft Sentinel data, which enables better query performance for large data sets. Dedicated clusters also provide the option for more encryption and control of your organization's keys.

Don't apply a resource lock to a Log Analytics workspace you'll use for Microsoft Sentinel. A resource lock on a workspace can cause many Microsoft Sentinel operations to fail.

## Simplify working with multiple workspaces

If you do need to work with multiple workspaces, simplify your incident management and investigation by condensing and listing all incidents from each Microsoft Sentinel instance in a single location.

To reference data that's held in other Microsoft Sentinel workspaces, such as in cross-workspace workbooks, use cross-workspace queries.
