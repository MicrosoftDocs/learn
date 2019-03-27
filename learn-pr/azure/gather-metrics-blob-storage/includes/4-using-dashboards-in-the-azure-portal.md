You have now identified certain metrics in Azure Blob storage that you'll want to monitor on an ongoing basis when client proof files are moved onto the platform. Rather than keep creating a chart every time you want to see the metric data, you want to see how to use dashboards to check on specific metrics regularly.

Management has also asked for regular reports about the use and performance of the platform to ensure clients will be satisfied as more files are moved into Azure. You want to see if management can be given dashboards for this purpose.

## Azure Dashboards

You'll often want to create the same reports using up-to-date information, such as platform usage or the resultant performance when working with files on a storage platform. However, it is inconvenient to create a fresh chart and configure the settings each time you want to see such a report. 

In the Azure portal, you can create a dashboard and add persistent charts to closely monitor key metrics, such as latency or the number of transactions being processed. You could also present other information from your Azure subscription, such as virtual machine information, and other web-based content, such as notices or video content. You are even able to share these dashboards with other users in your Azure AD organization.

![An Azure portal dashboard](../media/4-azure-portal-dashboard.PNG)

## Creating Azure Dashboards

Your Azure portal will normally start with a dashboard created automatically for you. This dashboard already has a number of *tiles* by default, which contain information about your Azure tenant or links to help you get started using Azure.
You can create additional dashboards by using the toolbar on the Dashboard page, which is found on the left-side navigation. The toolbar enables you to create, edit, clone, and delete dashboards. You could also download and upload dashboards, and share dashboards with other Azure user accounts.

![Dashboard toolbar](../media/4-dashboard-toolbar.PNG)

When you create a new dashboard, you specify a name or title for the dashboard, and Azure will create an empty dashboard with no tiles. The dashboard is divided into a grid to help tile placement and sizing when you add content. After the dashboard is initially created, the dashboard is put into edit mode, allowing you to add, remove, and resize tiles. A number of tile content suggestions will be displayed down the left-side of the dashboard in the *Tile Gallery*. This will help you to get started adding tiles and content to the dashboard. 

![Dashboard tile gallery](../media/4-dashboard-tile-gallery.PNG)

Tiles can display several different types of content. Some tiles will display links to resources, and other tiles can display data about those resources in your Azure subscription, such as virtual machine load, storage account usage, or subscription billing information. Tiles are also kept up-to-date, so that you can use dashboards to display near real-time monitoring information. There are pre-defined tiles for a wide variety of Azure resource types, including device management, databases, resource groups, storage accounts, security, and diagnostics. In addition to the tile gallery, you can also add Azure Monitor charts to a dashboard from the associated resources in the Azure Portal. When viewing resource information and clicking to view metrics, the chart toolbar has the option to add the chart to a dashboard directly.

![Metric chart toolbar](../media/4-metrics-chart-toolbar.PNG)

After adding tiles to a dashboard, you can use your mouse to drag tiles to reorganize the dashboard layout, or resize the tiles within the dashboard grid structure.

### Markdown Tiles

In addition to resource and data tiles, you can also add *markdown* tiles to your dashboards. Markdown tiles allow you to add certain web content to your dashboard. Web content can include titles or descriptions, links to FAQs or reference pages, and media content such as video embedded in the tile.

![Dashboard markdown tile options](../media/4-markdown-tile-options.PNG)

Markdown tiles support plain text, some HTML formatting, and markdown (which is a form of markup language designed to use a simple formatting syntax).

## Sharing Azure Dashboards

Shared dashboards are an Azure resource, which means you can share them by using Azure Role Based Access Control (RBAC). RBAC in Azure enables you to apply roles to different Azure user accounts or groups so those users or groups can access a resource or resource group. You can apply different roles to different users or groups so that some users might only be able to view a resource, but other users could manage a resource.

When sharing a dashboard in Azure, the shared dashboard will be added to a *resource group* - the portal will prompt you to create a dashboard resource group by default, although you can specify a custom resource group as well.

> [!NOTE]
> Note: Individual tiles still enforce security on the individual resource or resource group the tile represents.
> This means that if a user has a dashboard shared with them, but some of the tile resources are not shared with them, those tiles do not display the secure resource information.

Azure RBAC assigns a *role* to a *principal* at a *scope*.

A role is a collection of permissions; the most common roles are:

|---|---|
| Reader | This role enables a principal to view a resource, but not to make any changes. |
| Contributor | This role enables a principal to view and make changes to a resource. |
| Owner | This role enables a principal all permissions over the resource (or resource group). |

A principal is an Azure AD user account or security group. You can create a security group, such as *Dashboard Viewers* or *Dashboard Editors*, in order to easily provide access to multiple resources for several users at once.

The scope determines the level within Azure that the permissions are applied; you can assign permissions at the following scopes in Azure:

|---|---|
| Resource | This scope applies the associated role permissions to the specified resource only. |
| Resource Group | This scope applies the role permissions to all resources within the resource group. |
| Organization | This scope applies the role permissions to the entire Azure subscription. |

For dashboards, this means that you could apply permissions for a security group to a single dashboard, or you could apply permissions for a security group to several dashboards individually, or you could put several dashboards in a dedicated resource group and apply permissions for that security group to the resource group. You might also have different security groups for different levels of dashboard use, such as *Dashboard Viewers* for several support teams, and *Dashboard Editors* for the team that maintains the dashboard and adds or removes tiles from the dashboards.

> [!NOTE] While you can assign roles to individual user accounts in Azure AD, it is recommended that you assign roles to security groups for easier management as your organization grows.