To get ready for moving client proofs into Azure Blob Storage, you want to see how to create the dashboards for ongoing monitoring.

In this exercise, you create an Azure dashboard and then add storage metric charts to it.

## Create a custom dashboard

1. On the Azure portal menu, select **Dashboard**.

2. In the dashboard area, select **+ Create**, and then select **Custom**.

3. At the top of the new dashboard area, delete the default **My Dashboard** title, and enter **Storage Dashboard** as a new title, and then select **Save**.

4. Select **Edit**. On the right side, under **Tile Gallery**, select **Markdown**, and then select **Add**.

5. In the **Edit Markdown** panel, in the **Title** box, clear the contents of the box and enter **Blob Storage**.

6. In the **Subtitle** box, clear the contents of the box and enter **Blob Storage metric information**.

7. In the **Content** box, delete the sample text, enter **This dashboard displays charts for the Blob Storage account**, and then select **Done**.

8. Select the corner marker in the lower-right corner of the Markdown tile. Drag the marker to resize the tile to five squares across by two squares down on the background grid.

9. Select **Save** at the top of the dashboard.

## Add a metric chart to the new dashboard

1. On the Azure portal menu, select **Monitor**.

2. On the **Monitor - Overview** pane, select **Metrics**.

3. Under the chart toolbar, choose **Select a scope**.

4. In the **Select a scope** panel:

   1. In the **Subscription** drop-down list, ensure that only the concierge subscription you're using for the exercises is selected.

   2. In the **Resource type** drop-down list, select **Storage accounts**.

   3. In the search box type the name of the storage account that you created in unit (For example: select **monitorstorageaccount**). In the results list, select that storage account and then select **Apply**.

5. Under the chart toolbar, in the **Metric namespace** drop-down list, select **Blob**.

6. In the **Metric** drop-down list, select **Egress**.

7. On the chart toolbar, select the **Save to dashboard** menu, and then select **Pin to current dashboard**, and then select **Pin**.

## Add a customized metric chart to the new dashboard

1. Below the chart toolbar, next to **Egress (Sum)** oval, select the close button to remove the previous metric from the chart.

2. On the chart toolbar, select **Add metric**.

3. Under the chart toolbar, select the scope field.

4. On the **Select a resource** panel:

   1. In the **Subscription** drop-down list, ensure that only the subscription you're using for the exercises is selected.

   2. In the **Resource type** drop-down list, select **Storage accounts**.

   3. In the search box type the name of the storage account that you created in unit (For example: select **monitorstorageaccount**). In the results list, select that storage account and then select **Apply**.

5. Under the chart toolbar, in the **Metric namespace** drop-down list, select **Blob**.

6. In the **Metric** drop-down list, select **Transactions**.

7. On the chart toolbar, select **Apply splitting**.

8. In the **Select value(s)** drop-down list, select **API name**.

9. On the chart toolbar, select the ellipsis (**...**), and then select **Chart settings**.

10. On the **Chart settings** panel:

   1. Under **Chart title**, select **Custom**.

   2. Under **Custom**, clear the text box, and then enter **Blob transactions split by API**.

   3. Close the **Chart settings** panel.

11. On the chart toolbar, select the **Save to dashboard** menu, and then select **Save to Dashboard**.

12. On the left pane, select **Dashboard**.

13. Under the dashboard title, select **UTC Time: Past 24 hours**.

14. In the drop-down list, select **Past 48 hours**, and then select **Apply**.

## Generate some metrics data to display on the dashboard (optional)

1. On the Azure portal menu, select **Storage accounts**.

2. On the **Storage accounts** page, select the name of the storage account that you created in unit 3.

3. In the **Data storage** section, select **Containers**.

4. On the **Blobs** page, select **monitor-blobs-container**.

5. On the **monitor-blobs-container** page:

   1. Select the name of a file that you previously uploaded.

   2. On the overview page for the file, select **Download** on the toolbar.

   3. Download the file when you're prompted.
  
   4. Repeat the previous three steps with several other files.

5. On the Azure portal menu, select **Dashboard**.

After a delay of up to 15 minutes, you should see some lines appear on the chart. The lines represent the downloads that you performed.
