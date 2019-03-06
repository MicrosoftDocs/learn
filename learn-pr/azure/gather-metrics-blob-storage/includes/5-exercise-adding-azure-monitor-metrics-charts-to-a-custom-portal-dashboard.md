## Motivation

To get ready for moving client proofs into Azure Blob storage, you want to see how easy it will be to create the dashboards for ongoing monitoring. You also want to see how easy it will be to share dashboards for the management team. 

In this exercise, you will create an Azure dashboard, add storage metric charts to the dashboard and share the dashboard with a group in Azure.

## Create a custom dashboard
First, you will create a custom dashboard to display the metrics charts.

1. In the Azure portal, on the left-side, click **Dashboard**.
2. In the dashboard area, click **New dashboard** (the **+** symbol).
3. At the top of the new dashboard area, delete **My Dashboard** and type **Storage Dashboard**.
4. On the left side, under **Tile Gallery**, next to **Markdown**, click **Add**.
5. In the **Edit Markdown** panel, in the **Title** box, clear the contents of the box and type **Blob storage**. In the **Subtitle** box, clear the contents of the box and type **Blob storage metric information**. In the **Content** box, delete the sample text, type **This dashboard displays charts for the Blob storage account**, and then click **Done**.
6. Click and drag the corner marker in the lower right corner of the markdown tile to resize the tile to five squares across by two squares down on the background grid.
7. Click **Done customizing** at the top of the dashboard.

## Add a metric chart to the new dashboard

1. On the left side, click **Monitor**.
2. On the **Monitor - Overview** blade, click **Metrics**.
3. Under the chart toolbar, click **Select a resource**.
4. In the **Select a resource** panel, in the **Subscription** drop-down, ensure that only the subscription you are using for the exercises is selected. In the **Resource group** drop-down, ensure that only the **MonitorResourceGroup** is selected. Under **RESOURCE**, click the name of the storage account you created in Unit 3, and then click **Apply**.
5. Under the chart toolbar, in the **METRIC NAMESPACE** drop-down, select **Blob**. In the **METRIC** drop-down, select **Egress**.
6. On the chart toolbar, click the **Pin to dashboard** menu, and then click **Pin to current dashboard**.

## Add a customized metric chart to the new dashboard

1. Below the chart toolbar, next to **Egress, Sum**, click the close button to remove the previous metric from the chart.
2. On the chart toolbar, click **Add metric**.
3. Under the chart toolbar, click **Select a resource**.
4. In the **Select a resource** panel, in the **Subscription** drop-down, ensure that only the subscription you are using for the exercises is selected. In the **Resource group** drop-down, ensure that only **MonitorResourceGroup** is selected. Under **RESOURCE**, click the name of the storage account you created in Unit 3, and then click **Apply**.
5. Under the chart toolbar, in the **METRIC NAMESPACE** drop-down, select **Blob**. In the **METRIC** drop-down, select **Transactions**.
6. On the chart toolbar, click **Apply splitting**. in the **Select value(s)** drop-down, click **API name**.
7. On the chart toolbar, click the ellipsis (**...**), then click **Chart settings**.
8. Under **Chart title**, click **Custom**. Under **Custom**, clear the text box and type **Blob transactions split by API**, then close the Chart settings panel.
9. On the chart toolbar, click the **Pin to dashboard** menu, and then click **Pin to current dashboard**.
10. On the left-side navigation, click **Dashboard**.
11. Under the dashboard title, click **UTC Time: Past 24 hours**, in the drop-down, click **Past 48 hours**, then click **Apply**.

## Create an Azure AD Group and share the Storage dashboard

1. On the left-side navigation, click **Dashboard**.
2. In the Azure toolbar at the top of the page, click the **Cloud Shell** button.
3. In the **Welcome to Azure Cloud Shell** dialog, click **PowerShell**.
4. If the message **You have no storage mounted** appears, click **Create storage**.
5. At the cloud shell prompt, type the following and press ENTER. New-AzureADGroup -DisplayName "Dashboard Readers" -SecurityEnabled $true -MailEnabled $false -MailNickName "DashboardReaders"
6. Close the Azure Cloud Shell.
7. On the dashboard toolbar, next to the dashboard title, click the **Share** button.
8. In the **Sharing + access control** panel, click **Publish**.
9. In the **Sharing + access control** panel, click **Manage users**.
10. On the **Access Control** page, click **Add role assignment**.
11. In the **Add role assignment** panel, in the **Role** drop-down, select **Reader**, under the **Select** drop-down, click **Dashboard Readers**, then click **Save**.
12. On the left-side navigation, click **Dashboard**.

## Generate some metrics data to display on the dashboard (optional)

1. On the left-side navigation, click **Storage Accounts**.
2. On the **Storage accounts** page, click the name of the storage account you created in Unit 3. Click **Blobs**. On the **Blobs** page, click **monitor-blobs-container**.
3. On the **monitor-blobs-container** page, click the name of a file that you previously uploaded.
4. On the **Overview** tab, next to the **URL** click the **Copy** button.
5. Start **Microsoft Edge** browser in **InPrivate** mode.
6. On the **InPrivate** tab, in the **Search or enter web address** box, right-click and select **Paste and go**. The browser will retrieve your file from Azure.
7. Wait for the file to finish downloading, then close the **InPrivate** window. Wait 1 minute.
8. Repeat steps 5 - 7 three more times to generate some egress and transaction data.
9. On the left-side navigation, click **Dashboard**. After a delay of up to 15 mins, you should see some lines appear on the chart representing the downloads you performed.

## Summary
In this exercise, you applied the knowledge you gained in the previous module in a practical environment. You created an Azure dashboard, added storage metrics charts to the dashboard, and shared the dashboard with a group in your organization.