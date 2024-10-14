Before you can explore the end-to-end capabilities of Microsoft Fabric, it must be enabled for your organization. You might need to work with your IT department to enable Fabric for your organization. The permissions required to enable Fabric are either:

- *Fabric admin (formerly Power BI admin)*
- *Power Platform admin*
- *Microsoft 365 admin*

## Enable Microsoft Fabric

If you have admin privileges, you can access the **Admin center** from the **Settings** menu in the upper right corner of the Power BI service. From here, you enable Fabric in the **Tenant settings.**

Admins can make Fabric available to either the entire organization or specific groups of users, who can be organized based on their Microsoft 365 or Microsoft Entra security groups. Admins can also *delegate* the ability to enable Fabric to other users, at the capacity level.

![Screenshot of the Enable Fabric settings in the Fabric admin portal..](../media/enable-fabric.png)

> [!NOTE]
> If your organization isn't using Fabric or Power BI today, you can sign up for a [free Fabric trial](/fabric/get-started/fabric-trial) to explore the different workloads.

## Create workspaces

Workspaces are collaborative environments where you create and manage items like lakehouses, warehouses, and reports. All data is stored in OneLake, and is accessed through workspaces. Items are displayed in a list or lineage view, which is a visual representation of the dependency between items.

In the *Workspace settings*, you can configure the license type to use Fabric features. There are several other settings you can configure in this area, some of which include:

- OneDrive access for the workspace
- Azure Data Lake Gen2 Storage connection
- Integration with Git for version control
- Spark workload settings

![Screenshot of the workspace license mode options including Trial and Fabric Capacity.](../media/workspace-settings-license.png)

To grant access to a workspace, choose one of the four available roles. These roles have access to all items in a workspace. Workspace access is typically granted to collaborators, and it's recommended to grant access to specific items depending on the business need.

> [!NOTE]
> Learn more about workspaces in the [Fabric documentation](/fabric/get-started/workspaces).

## Discover data with OneLake data hub

The OneLake data Hub in Microsoft Fabric helps users easily find and access various data sources within their organization. Users explore and connect to data sources, ensuring they have the right data for their needs. Users only see items shared with them. Here are some considerations when using OneLake Hub:

- Narrow results by domains (if implemented).
- Filter by workspaces in Explorer.
- Explore default groups: *All data*, *My data*, *Endorsed in your org*, and *Favorites*.
- Filter further by keyword or item type.

:::image type="content" source="../media/onelake-data-hub.png" alt-text="Screenshot of the OneLake data hub." lightbox="../media/onelake-data-hub.png":::

## Create items in Fabric

After you create your Fabric enabled workspace, you can start creating items in Fabric. You can create items in Fabric using the **Create** menu in the upper left corner of the Power BI service.

![Screenshot of the Power BI service with the Create menu highlighted in the upper left corner of the user interface.](../media/fabric-create.png)

## Explore Fabric workloads

Fabric workloads refer to the different capabilities included in Fabric. You can switch between workloads using the workload switcher in the bottom left corner of the navigation pane.

![Screenshot of the Fabric workload switcher, featuring Data engineering, Data factory, Data science, Data warehousing, real-time intelligence, and Power BI workloads.](../media/workspace-switcher.png)

You might notice that Fabric workloads look similar to other Microsoft data offerings. Fabric is built on Power BI and Azure Data Lake Storage, and includes capabilities from Azure Synapse Analytics, Azure Data Factory, Azure Databricks, and Azure Machine Learning. What makes Fabric unique is that it brings these capabilities together in a single, SaaS integrated experience without the need for access to Azure resources.
