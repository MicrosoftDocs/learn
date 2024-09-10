As a proof-of-concept exercise, you want to move some files into Azure Blob Storage to see how the metrics are displayed in the Azure portal. Let's create a storage account and a blob container, and then view the metrics that appear.

## Create a storage account in the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account with which you activated the sandbox.

2. In the Azure portal, select **Create a resource**.

3. In the **Search services and Marketplace** box, search for and select **Storage account**. The **Storage account** panel appears.

4. Select **Create**. The **Create a storage account** panel appears.

5. On the **Basics** tab, fill in the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project details** |
    | Subscription | **Concierge Subscription**  |
    | Resource group | <rgn>[Sandbox resource group]</rgn> |
    | **Instance details** |
    | Storage account name | *\<your-storage-account-name\>*, which is 3 to 24 characters and consists of only lowercase letters and numbers; for example, **monitorstorageaccount** |
    | Region | Use the default region |
    | Performance | **Standard** |
    | Redundancy | **Geo-redundant storage (GRS)** |

6. Select the **Advance** tab. Scroll down to the **Blob storage** section and make sure that **access tier** is set to **Hot**.

7. Select **Review + create**. After validation passes, select **Create**.

8. On the **Your deployment is complete** panel, select **Go to resource**.

## View the properties of the storage account

On the **Overview** page, you can see the following information about the storage account:

- Resource group name
- Status
- Location
- Subscription
- Performance or access tier
- Replication
- Account kind

You can change the storage account to another resource group.

## Add a blob container

Before you can add blobs to a storage account, you need to create a blob container.

1. Under **Data storage**, select **Containers**.  

   The **Containers** panel appears.

2. In the **Containers** panel, select **+ Container**.

   The **New container** pane appears.

3. In the **Name** field, enter **monitor-blobs-container**, and then select **Create**.

   When you select your new container, notice the **No results** status message.

You're now ready to upload files to the blob container.

## Upload files to the blob container

To upload a single file to the blob container:

1. Open the **monitor-blobs-container** container, and then select **Upload**.

2. On the **Upload blob** pane, select **Browse for files**.

3. In the **Open** dialog box, select a small text file from your local file system, and select **Open**.

4. On the **Upload blob** pane, Select **Advanced** to view the advanced upload options.

5. Select **Blob type**. In the drop-down list, the options are **Block blob**, **Page blob**, and **Append blob**. Ensure that **Block blob** is selected.

6. Under **Block size**, select **64 KiB**. Select **Upload** and note when the file upload has finished.

To upload multiple files to the blob container:

1. Select **Upload**.

2. On the **Upload blob** panel, select **Browse for files**.

3. In the **Open** dialog box, select several graphics files from your local file system, and then select **Open**. Ensure that you have at least 50 MB of files selected.

4. Select **Advanced** to view the advanced upload options.

5. Ensure that **Block blob** is selected.

6. Under **Block size**, select a file size that's slightly larger than the largest file you're uploading, and then select **Upload**. Note when the file uploads have finished.

Page blobs are typically for large files, such as virtual machine disk images (VHDs). The only block size available for page blobs is 4 MB. Append blobs are optimized for append operations, such as log file updates.

## Check the size of data

You can check the size of the data stored in a container, along with the number and types of blobs, by completing the following steps:

1. For the **monitor-blobs-container** container, select **Properties**.

2. On the **Properties** pane, select **Calculate size**.

The size and number of blobs now appear.

## Create a capacity metrics chart

Next, view the metrics that the storage account generates. Complete the following steps:

1. On the menu pane, select **Storage accounts**. On the **Storage accounts** pane, select the name of the storage account that you created.

2. Scroll down the middle pane to the **Monitoring** section, and then select **Metrics**.

3. Select **New Chart**.

4. Next to **Chart Title**, select the pen icon.

5. Enter **Capacity Chart** as the name for your chart.

6. Add several metrics to your chart:

   1. Select **Add metric**.

   2. Under **Scope**, select the name of the storage account that you created.

   3. Under **Metric Namespace**, select **Blob**.

   4. Under **Metric**, select **Blob Capacity**.

   5. Under **Aggregation**, select **Avg**.

   6. Repeat the previous steps to add **Blob Container Count** and **Blob Count** to the chart.

At the bottom of the chart, you now have a color bar and a count for the current value of the counter. It's highly likely that the counter is initially at zero for all the capacity metrics, because the values haven't been aggregated.

## Create a transaction metrics chart

Transaction metrics are updated hourly, so you should see changes in these values relatively quickly. To create a transaction metrics chart, complete the following steps:

1. Select **+ New Chart**.

2. Next to **Chart Title**, select the pen icon.

3. Enter **Transaction Chart** as the name for your chart.

4. Select **Add metric**.

5. Under **Scope**, select the name of the storage account that you created.

6. Under **Metric Namespace***, select **Blob**.

7. Under **Metric**, select **Availability**.

8. Under **Aggregation**, select **Avg**.

9. View the resulting chart. It should show just one line set at 100%.

10. Change the **Aggregation** option to **Min**. It's unlikely that an Azure outage happened during that time, so the line should stay at 100%. This information generally doesn't change much.

11. Select the **X** to the right of the monitor ellipsis to close it.

    ![Screenshot monitor ellipsis.](../media/3-monitor-ellipsis.png)

12. Select **Add metric**. Both the **Resource** and **Metric Namespace** values should already be selected.

13. Under **Metric**, select **Egress**.

14. Under **Aggregation**, select **Avg**, **Max**, and **Min**. Note how the data shapes change with each value. Finally, select **Sum**. You should have a single spike at the time when you imported the files.

## Split a metric

Splitting a chart enables you to view more dimensions in the data, depending on the type of metric that you're viewing. To split a metric, complete the following steps:

1. Select **Apply splitting**.

2. In the **Splitting** oval, from the **Values** drop-down list, select **API name**.

3. View the output in the chart window. You should now have the following splits of the monitoring data:

    - **ListBlobs** (note this value)
    - **BlobPreflightRequest**
    - **GetContainerProperties**
    - **GetBlobServiceProperties**
    - **PutBlob**
    - **GetBlobproperties**
    - **PutBlockList**
    - **GetContainerServiceMetadata**
    - **ListContainers**
    - **GetFileServiceProperties**
    - **GetBlobTags**


4. Select the **X** to the right of the **Splitting** oval.

## Add a filter

Filtering also enables you to look at the metrics with greater granularity. To apply a filter, complete the following steps:

1. Select **Add filter**.

1. Under **Property**, select **API name**.

1. Under **Values**, select **ListBlobs**. Note the data values and compare them with the **ListBlobs** value from the splitting exercise.

1. Select the **X** to the right of the filter oval to remove the filter.

## Customize charts

You can customize charts in various ways, such as by changing the time range, time granularity, and time zone. To make these changes, use the following steps:

1. Text at the top of the chart says **Last 24 hours (automatic)**. Select this oval, and a dialog box for time range and time granularity appears.

2. Under **Time range**, select **Last 4 hours**. Note the ability to change from local to UTC/GMT time, as needed.

3. Under **Time granularity**, select **1 hour**, and then select **Apply**.

## View data in other formats

You can view metric data in other formats, including line charts, bar charts, area charts, and scatter charts. To change the view of the data, complete the following steps:

1. By using the metrics defined in the previous section, select **Line Chart** > **Area Chart**. Note the change in the display of the data.

2. Select **Area Chart** > **Scatter Chart**. With the low levels of storage activity, the scatter chart shows only the peaks of activity.

3. Select the ellipsis next to **Save to dashboard**, and then select **Chart Settings**.

4. Under **Chart Title**, select **Custom**, and enter a more descriptive name for the chart.

5. For the displayed data, under **Min value**, enter a value in bytes that's lower than your lowest data point.

6. Under **Max value**, enter a value in bytes that's slightly higher than your highest data point. Your data should now fill the entire chart.

7. Select the different chart types and notice the change in the data display.

8. Select the **X** to close the **Chart settings** pane.

## Export a chart to Excel

Exporting a chart to Excel gives you all the data analysis tools of that platform. To export a chart to Excel, complete the following steps:

1. Select **Share**, and then select **Download to Excel**.

2. Open the Excel spreadsheet that's downloaded.

3. View the data in the chart.
