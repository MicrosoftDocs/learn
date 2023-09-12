A Log Analytics workspace is a unique environment for log data from Azure Monitor and other Azure services, such as Microsoft Sentinel and Microsoft Defender for Cloud. Each workspace has its own data repository and configuration but might combine data from multiple services.

You might see the term Microsoft Sentinel workspace used in Microsoft Sentinel documentation. This workspace is the same Log Analytics workspace described in this article, but it's enabled for Microsoft Sentinel. All data in the workspace is subject to Microsoft Sentinel pricing as described in the Cost section.

You can use a single workspace for all your data collection. You can also create multiple workspaces based on requirements such as:

 -  The geographic location of the data.<br>
 -  Access rights that define which users can access data.
 -  Configuration settings like pricing tiers and data retention.<br>

## Data structure

Each workspace contains multiple tables that are organized into separate columns with multiple rows of data. Each table is defined by a unique set of columns. Rows of data provided by the data source share those columns. Log queries define columns of data to retrieve and provide output to different features of Azure Monitor and other services that use workspaces.

:::image type="content" source="../media/logs-structure-ca436b70.png" alt-text="Screenshot showing an example of a log structure.":::


Table names are used for billing purposes so they should not contain sensitive information.

## Cost

There's no direct cost for creating or maintaining a workspace. You're charged for the data sent to it, which is also known as data ingestion. You're charged for how long that data is stored, which is otherwise known as data retention. These costs might vary based on the log data plan of each table, as described in Log data plan.

## Workspace transformation DCR

Data collection rules (DCRs) that define data coming into Azure Monitor can include transformations that allow you to filter and transform data before it's ingested into the workspace. Since all data sources don't yet support DCRs, each workspace can have a workspace transformation DCR.

Transformations in the workspace transformation DCR are defined for each table in a workspace and apply to all data sent to that table, even if sent from multiple sources. These transformations only apply to workflows that don't already use a DCR. For example, Azure Monitor agent uses a DCR to define data collected from virtual machines. This data won't be subject to any ingestion-time transformations defined in the workspace.<br>

For example, you might have diagnostic settings that send resource logs for different Azure resources to your workspace. You can create a transformation for the table that collects the resource logs that filters this data for only records that you want. This method saves you the ingestion cost for records you don't need. You might also want to extract important data from certain columns and store it in other columns in the workspace to support simpler queries.

## Data retention and archive

Data in each table in a Log Analytics workspace is retained for a specified period of time after which it's either removed or archived with a reduced retention fee. Set the retention time to balance your requirement for having data available with reducing your cost for data retention.

To access archived data, you must first retrieve data from it in an Analytics Logs table by using one of the following methods:

| **Method**  | **Description**                             |
| ----------- | ------------------------------------------- |
| Search jobs | Retrieve data matching particular criteria. |
| Restore     | Retrieve data from a particular time range. |

:::image type="content" source="../media/workspace-plan-overview-4961b068.png" alt-text="Screenshot showing an example of a workspace plan.":::
<br>

## Permissions

Permission to access data in a Log Analytics workspace is defined by the access control mode, which is a setting on each workspace. You can give users explicit access to the workspace by using a built-in or custom role. Or, you can allow access to data collected for Azure resources to users with access to those resources.
