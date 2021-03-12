To get ready for moving client proofs into Azure Blob Storage, you want to see how easy it will be to create the dashboards for ongoing monitoring.

In this exercise, you'll create an Azure dashboard and then add storage metric charts to it.

## Create a custom dashboard

1. On the Azure portal menu, select **Dashboard**.

1. In the dashboard area, select **+ New dashboard**.

1. At the top of the new dashboard area, delete the default **My Dashboard** title, and enter **Storage Dashboard** as a new title.

1. On the left side, under **Tile Gallery**, next to **Markdown**, select **Add**.

1. In the **Edit Markdown** panel, in the **Title** box, clear the contents of the box and enter **Blob storage**.

1. In the **Subtitle** box, clear the contents of the box and enter **Blob storage metric information**.

1. In the **Content** box, delete the sample text, enter **This dashboard displays charts for the Blob storage account**, and then select **Done**.

1. Select the corner marker in the lower-right corner of the Markdown tile. Drag the marker to resize the tile to five squares across by two squares down on the background grid.

1. Select **Done customizing** at the top of the dashboard.

## Add a metric chart to the new dashboard

1. On the left side, select **Monitor**.

1. On the **Monitor - Overview** pane, select **Metrics**.

1. Under the chart toolbar, choose **Select a resource**.

1. In the **Select a resource** panel:

   1. In the **Subscription** drop-down list, ensure that only the concierge subscription you're using for the exercises is selected.
   
   1. In the **Resource group** drop-down list, ensure that **\<rgn\>** is selected.
   
   1. Under **RESOURCE**, select the name of the storage account that you created in unit 3. For example, select **monitorstorageaccount**.
   
   1. Select **Apply**.

1. Under the chart toolbar, in the **METRIC NAMESPACE** drop-down list, select **Blob**.

1. In the **METRIC** drop-down list, select **Egress**.

1. On the chart toolbar, select the **Pin to dashboard** menu, and then select **Pin to current dashboard**.

## Add a customized metric chart to the new dashboard

1. Below the chart toolbar, next to **Egress (Sum)** oval, select the close button to remove the previous metric from the chart.

1. On the chart toolbar, select **Add metric**.

1. Under the chart toolbar, select **Select a resource**.

1. On the **Select a resource** panel:

   1. In the **Subscription** drop-down list, ensure that only the subscription you're using for the exercises is selected.
   
   1. In the **Resource group** drop-down list, ensure that only **\<rgn\>** is selected.
   
   1. Under **RESOURCE**, select the name of the storage account that you created in unit 3. For example, select **monitorstorageaccount**.
   
   1. Select **Apply**.

1. Under the chart toolbar, in the **METRIC NAMESPACE** drop-down list, select **Blob**.

1. In the **METRIC** drop-down list, select **Transactions**.

1. On the chart toolbar, select **Apply splitting**.

1. In the **Select value(s)** drop-down list, select **API name**.

1. On the chart toolbar, select the ellipsis (**...**), and then select **Chart settings**.

1. On the **Chart settings** panel:

   1. Under **Chart title**, select **Custom**.

   1. Under **Custom**, clear the text box, and then enter **Blob transactions split by API**.

   1. Close the **Chart settings** panel.

1. On the chart toolbar, select the **Pin to dashboard** menu, and then select **Pin to current dashboard**.

1. On the left pane, select **Dashboard**.

1. Under the dashboard title, select **UTC Time: Past 24 hours**.

1. In the drop-down list, select **Past 48 hours**, and then select **Apply**.

## Generate some metrics data to display on the dashboard (optional)

1. On the left pane, select **Storage accounts**.

1. On the **Storage accounts** page, select the name of the storage account that you created in unit 3.

1. In the **Blob service** section, select **Blobs**.

1. On the **Blobs** page, select **monitor-blobs-container**.

1. On the **monitor-blobs-container** page:

   1. Select the name of a file that you previously uploaded.

   1. On the overview page for the file, select **Download** on the toolbar.

   1. Download the file when you're prompted.
  
   1. Repeat the previous three steps with several other files.

1. On the left pane, select **Dashboard**.

After a delay of up to 15 minutes, you should see some lines appear on the chart. The lines represent the downloads that you performed.
