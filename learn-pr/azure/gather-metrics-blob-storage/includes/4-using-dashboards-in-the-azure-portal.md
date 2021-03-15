You have now identified certain metrics in Azure Blob storage that you'll want to monitor on an ongoing basis when client files are moved onto the platform. Rather than keep creating a chart every time you want to see the metric data, you want to see how to use dashboards to check on specific metrics regularly.

Management has also asked for regular reports about the use and performance of the platform to ensure clients will be satisfied as more files are moved into Azure. You want to see if management can be given dashboards for this purpose.

## Azure Dashboards

You'll often want to create the same reports using up-to-date information, such as platform usage or the resultant performance when working with files on a storage platform. However, it is inconvenient to create a fresh chart and configure the settings each time you want to see such a report. 

In the Azure portal, you can create a dashboard and add persistent charts to closely monitor key metrics, such as latency or the number of transactions being processed. You could also present other information from your Azure subscription, such as virtual machine information, and other web-based content, such as notices or video content. You are even able to share these dashboards with other users in your Azure AD organization.

![Screenshot showing an Azure portal dashboard.](../media/4-azure-portal-dashboard.png)

## Creating Azure Dashboards

Your Azure portal will normally start with a dashboard created automatically for you. This dashboard already has a number of *tiles* by default, which contain information about your Azure tenant or links to help you get started using Azure.

You can create additional dashboards by using the toolbar on the Dashboard page, which is found on the left-side navigation. The toolbar enables you to create, edit, clone, and delete dashboards. You could also download and upload dashboards, and share dashboards with other Azure user accounts.

![Screenshot showing the dashboard toolbar.](../media/4-dashboard-toolbar.png)

When you create a new dashboard, you specify a name or title for the dashboard, and Azure will create an empty dashboard with no tiles. The dashboard is divided into a grid to help tile placement and sizing when you add content. After the dashboard is initially created, the dashboard is put into edit mode, allowing you to add, remove, and resize tiles. A number of tile content suggestions will be displayed down the left-side of the dashboard in the *Tile Gallery*. This will help you to get started adding tiles and content to the dashboard. 

![Screenshot showing the tile gallery for dashboards.](../media/4-dashboard-tile-gallery.png)

Tiles can display several different types of content. Some tiles will display links to resources, and other tiles can display data about the resources in your Azure subscription, such as virtual machine load, storage account usage, or subscription billing information. Tiles are also kept up-to-date, so you can use dashboards to display near real-time monitoring information. There are pre-defined tiles for a wide variety of Azure resource types, including device management, databases, resource groups, storage accounts, security, and diagnostics. In addition to the tile gallery, you can also add Azure Monitor charts to a dashboard from the associated resources in the Azure Portal. When viewing resource information and clicking to view metrics, the chart toolbar has the option to add the chart to a dashboard directly.

![Screenshot showing the toolbar for metric charts.](../media/4-metric-chart-toolbar.png)

After adding tiles to a dashboard, you can use your mouse to drag tiles to reorganize the dashboard layout, or resize the tiles within the dashboard grid structure.

### Markdown Tiles

In addition to resource and data tiles, you can also add *markdown* tiles to your dashboards. Markdown tiles allow you to add certain web content to your dashboard. Web content can include titles or descriptions, links to FAQs or reference pages, and media content such as video embedded in the tile.

![Screenshot showing the options for dashboard markdown tiles.](../media/4-markdown-tile-options.png)

Markdown tiles support plain text, some HTML formatting, and markdown (which is a form of markup language designed to use a simple formatting syntax).
