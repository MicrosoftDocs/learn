Many different types of metadata are collected for Arc-enabled servers. This includes the platform, operating system, presence of SQL server, or AWS and GCP details. This data can be queried at scale using Azure Resource Graph.

Azure Resource Graph is an Azure service designed to extend the capabilities of [Azure Resource Manager](/azure/azure-resource-manager/management/overview) by providing efficient resource exploration. Azure Resource Graph gives you the ability to query at scale across a set of subscriptions, allowing you to more effectively govern your environment. You can query resources with complex filtering, grouping, and sorting by resource properties.

## Permissions

To use Resource Graph, you must have appropriate rights in Azure role-based access control (Azure RBAC) with at least `read` access to the resources you want to query. Without at least `read` permissions to the Azure object or object group, results won't be returned.

## Creating a custom query

Azure Resource Graph uses a query language based on the [Kusto Query Language (KQL)](/azure/data-explorer/data-explorer-overview) to create custom queries that call the Azure Resource Manager to report on the resources you're interested in. These queries provide the following abilities:

- Query resources with complex filtering, grouping, and sorting by resource properties
- Explore resources iteratively based on governance requirements.
- Assess the impact of applying policies in a vast cloud environment.

The query language for the Azure Resource Graph supports many operators and functions. Queries can be created and run using any of the following:

- Azure portal and Resource Graph Explorer
- Azure CLI
- Azure PowerShell
- Python

Query results can be easily visualized and exported to other reporting solutions. Moreover, there are dozens of built-in Azure Resource Graph queries capturing salient information across Azure VMs and Arc-enabled servers, such as their VM extensions, regional breakdown, and operating systems.

## Resource Graph Explorer

 Resource Graph Explorer is the graphical user interface component of Azure Resource Graph, available through the Azure portal. Resource Graph Explorer provides browsable information about the Azure Resource Manager resource types and properties that you can query. Resource Graph Explorer also provides a clean interface for working with multiple queries, evaluating the results, and even converting the results of some queries into a chart that can be pinned to an Azure dashboard.

### Run your first query

> [!NOTE]
> If you don't have an Azure subscription, create a [free](https://azure.microsoft.com/free/) account before you begin.
> 

Open the [Azure portal](https://portal.azure.com) to find and use the Resource Graph Explorer
following these steps to run your first Resource Graph query:

1. Select **All services** in the left pane. Search for and select **Resource Graph Explorer**.

1. In the **Query 1** portion of the window, enter the query
   `Resources | project name, type | limit 5` and select **Run query**.

   > [!NOTE]
   > As this query example doesn't provide a sort modifier such as `order by`, running this query
   > multiple times is likely to yield a different set of resources per request.

1. Review the query response in the **Results** tab. Select the **Messages** tab to see details
   about the query, including the count of results and duration of the query. Errors, if any, are
   displayed under this tab.

1. Update the query to `order by` the **Name** property:
   `Resources | project name, type | limit 5 | order by name asc`. Then, select **Run query**.

   > [!NOTE]
   > Just as with the first query, running this query multiple times is likely to yield a different
   > set of resources per request. The order of the query commands is important. In this example,
   > the `order by` comes after the `limit`. This command order first limits the query results and
   > then orders them.

1. Update the query to first `order by` the **Name** property and then `limit` to the top five
   results: `Resources | project name, type | order by name asc | limit 5`. Then, select **Run
   query**.

When the final query is run several times, assuming that nothing in your environment is changing,
the results returned are consistent and ordered by the **Name** property, but still limited to the
top five results.

### Download query results as a CSV file

To download CSV results from the Azure portal, browse to the Azure Resource Graph Explorer and run a
query. On the toolbar, click **Download as CSV**.

:::image type="content" source="../media/azure-resource-graph-export-csv.png" alt-text="Screenshot of Azure Resource Graph Explorer in Azure portal with Download as CSV button highlighted." lightbox="../media/azure-resource-graph-export-csv.png":::

> [!NOTE]
> When using the comma-separated value (CSV) export functionality of Azure Resource Graph Explorer, the result set is limited to 55,000 records. This is a platform limit that cannot be overridden by filing an Azure support ticket.
