To get ready for moving client proofs into Azure Blob storage, you want to see how easy it will be to create the dashboards for ongoing monitoring.

In this exercise, you will create an Azure dashboard, and add storage metric charts to the dashboard.

## Create a custom dashboard

First, you will create a custom dashboard to display the metrics charts.

1. In the Azure portal, on the left-side, click **Dashboard**.

1. In the dashboard area, click **+ New dashboard**.

1. At the top of the new dashboard area, delete the default **My Dashboard** title, and type **Storage Dashboard** as a new title.

1. On the left side, under **Tile Gallery**, next to **Markdown**, click **Add**.

1. In the **Edit Markdown** panel, in the **Title** box, clear the contents of the box and type **Blob storage**.

1. In the **Subtitle** box, clear the contents of the box and type **Blob storage metric information**.

1. In the **Content** box, delete the sample text, type **This dashboard displays charts for the Blob storage account**, and then click **Done**.

1. Click and drag the corner marker in the lower right corner of the markdown tile to resize the tile to five squares across by two squares down on the background grid.

1. Click **Done customizing** at the top of the dashboard.

## Add a metric chart to the new dashboard

1. On the left side, click **Monitor**.

1. On the **Monitor - Overview** blade, click **Metrics**.

1. Under the chart toolbar, click **Select a resource**.

1. In the **Select a resource** panel:

   1. In the **Subscription** drop-down, ensure that only the concierge subscription you are using for the exercises is selected.
   
   1. In the **Resource group** drop-down, ensure that **<rgn>** is selected.
   
   1. Under **RESOURCE**, click the name of the storage account you created in Unit 3; for example: **monitorstorageaccount**.
   
   1. Click **Apply**.

1. Under the chart toolbar, in the **METRIC NAMESPACE** drop-down, select **Blob**.

1. In the **METRIC** drop-down, select **Egress**.

1. On the chart toolbar, click the **Pin to dashboard** menu, and then click **Pin to current dashboard**.

## Add a customized metric chart to the new dashboard

1. Below the chart toolbar, next to **Egress (Sum)** oval, click the close button to remove the previous metric from the chart.

1. On the chart toolbar, click **Add metric**.

1. Under the chart toolbar, click **Select a resource**.

1. In the **Select a resource** panel:

   1. In the **Subscription** drop-down, ensure that only the subscription you are using for the exercises is selected.
   
   1. In the **Resource group** drop-down, ensure that only **<rgn>** is selected.
   
   1. Under **RESOURCE**, click the name of the storage account you created in Unit 3; for example: **monitorstorageaccount**.
   
   1. Click **Apply**.

1. Under the chart toolbar, in the **METRIC NAMESPACE** drop-down, select **Blob**.

1. In the **METRIC** drop-down, select **Transactions**.

1. On the chart toolbar, click **Apply splitting**.

1. in the **Select value(s)** drop-down, click **API name**.

1. On the chart toolbar, click the ellipsis (**...**), then click **Chart settings**.

1. In the **Chart settings** panel:

   1. Under **Chart title**, click **Custom**.

   1. Under **Custom**, clear the text box, and then type **Blob transactions split by API**.

   1. Close the **Chart settings** panel.

1. On the chart toolbar, click the **Pin to dashboard** menu, and then click **Pin to current dashboard**.

1. On the left-side navigation, click **Dashboard**.

1. Under the dashboard title, click **UTC Time: Past 24 hours**.

1. In the drop-down, click **Past 48 hours**, then click **Apply**.

## Generate some metrics data to display on the dashboard (optional)

1. On the left-side navigation, click **Storage accounts**.

1. On the **Storage accounts** page, click the name of the storage account you created in Unit 3.

1. In the **Blob service** section, click **Blobs**.

1. On the **Blobs** page, click **monitor-blobs-container**.

1. On the **monitor-blobs-container** page:

   1. Click the name of a file that you previously uploaded.

   1. On the overview page for the file, click **Download** on the toolbar.

   1. Download the file when prompted to do so.
  
   1. Repeat the previous three steps with several other files.

1. On the left-side navigation, click **Dashboard**.

After a delay of up to 15 mins, you should see some lines appear on the chart representing the downloads you performed.
