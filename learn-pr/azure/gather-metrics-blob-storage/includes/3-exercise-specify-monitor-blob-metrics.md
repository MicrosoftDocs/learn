As a proof of concept exercise, you want to move some simple files into Azure Blob storage to see how the metrics are displayed in the Azure portal. You will create a new storage group with associated blob storage, then view the different metrics that appear.

## Create a storage account in the Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account with which you activated the sandbox.

1. In the Azure portal, select **Create a sesource**.

1. In the *Search the Marketplace* search box, search for and select **Storage account**. The **Storage account** panel appears.

1. Select **Create**. The **Create storage account** panel appears.

1. On the **Basics** tab, fill in the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | **Project details** |
    | Subscription | Concierge Subscription  |
    | Resource group | <rgn>[Sandbox resource group]</rgn> |
    | **Instance details** |
    | Storage account name | *\<your-storage-account-name\>* between 3 and 24 characters consisting only of lower case letters and numbers; for example, **monitorstorageaccount** |
    | Location | Use the *default* location |
    | Performance | Standard |
    | Account kind | StorageV2 (general purpose v2) |
    | Replication | Read-access geo-redundant storage (RA-GRS) |

1. Select the **Advance** tab, and enter the following value.

    | Setting  | Value  |
    |---|---|
    | **Blob storage** |
    | Blob access tier (default) | Hot  |

1. Select **Review + create**, and after validation passes, select **Create**.

1. On the **Your deployment is complete** panel, select **Go to resource**.

## View the properties of the storage account

On the Overview page, you can see information about the Storage account, including:

- Resource group name
- Status
- Location
- Subscription
- Performance/Access Tier
- Replication
- Account kind

Notice that you can change the storage account to another resource group.

## Add a blob container

Before you can add blobs to a Storage Account, you need to create a blob container.

1. On the Overview panel of your storage account, to add a blob container, select the **Containers** box. The **Containers** panel appears. Select **Container**. The **New container** pane appears.

1. In the **Name** field, enter **monitor-blobs-container**, and then select **Create**. When you select your new container, notice the *No results* status message.

You are now ready to upload files to the blob container.

## Upload Files to the Blob Container

1. To upload a single file to the blob container, select **Upload**.

1. In the **Upload blob** pane, select the folder icon.

1. In the **Open** dialog box, select a small text file from your local file system, and select **Open**.

1. Select **Advanced** to view the advanced upload blob options.

1. Select **Blob type**, and in the dropdown, note the options for: **Block blob**, **Page blob**, and **Append blob**. Ensure that **Block blob** is selected.

1. Under **Block size**, select **64 KB**, then select **Upload**. Note when the file upload has completed.

1. To upload multiple files to the blob container, select **Upload**.

1. In the **Upload blob** panel, select the folder icon.

1. In the **Open** dialog box, select several graphics files from your local file system, and select **Open**. Ensure that you have at least 50 MB of files selected.

1. Select **Advanced** to view the advanced upload blob options.

1. Ensure that **Block blob** is selected.

1. Under **Block size**, select a file size that is slightly larger than the largest file you are uploading, and then select **Upload**. Note when the file uploads have completed.

Page blobs are typically for very large files, such as virtual machine disk images (VHDs) and the only block size available is 4 MB. Append blobs are optimized for append operations (such as log file updates).

## Check size

You can simply check the size of the data stored in a container and the number and type of blobs by completing the following steps.

1. On the **monitor-blobs-container** container, select **Properties**.

1. On the **Properties** pane, select **Calculate size**.

1. The size and number of blobs will now appear.

## Create a Capacity Metrics Chart

Next, you will view the metrics that the storage account generates. To do this, complete the following steps.

1. In the menu pane, select **Storage accounts**, and then in the **Storage accounts** pane, select the name of the storage account you created.

1. Scroll down the middle pane to the **Monitoring** section, and then select **Metrics**.

1. Select **New Chart**.

1. Next to **Chart Title**, select the pen icon.

1. Enter **Capacity Chart** as the name for your chart.

1. Add several metrics to your chart.

   1. Select **Add metric**.

   1. Under **RESOURCE**, select the name of the storage account you created.

   1. Underneath appears the Subscription name, the name of the Resource Group, and the Resource Type. Note that all resource types are selected by default.

   1. Under **METRIC NAMESPACE**, select **Blob**.

   1. Under **METRIC**, select **Blob Capacity**.

   1. Under **AGGREGATION**, select **Avg**.

   1. Repeat the previous six steps to add **Blob Container Count** and **Blob Count** to the chart.

Note at the bottom of the chart that you now have a color bar and a count for the current value of the counter. It is highly likely that the counter will initially be zero for all the Capacity metrics, as the values have not been aggregated.

## Create a Transaction Metrics Chart

Transaction metrics are updated hourly, so you should relatively quickly be able to see changes in these values. To create a transaction metrics chart, complete the following steps.

1. Select **+ New Chart**.

1. Next to **Chart Title**, select the pen icon.

1. Enter **Transaction Chart** as the name for your chart.

1. Select **Add metric**.

1. Under **RESOURCE**, select the name of the storage account you created.

1. Under **METRIC NAMESPACE**, select **Blob**.

1. Under **METRIC**, select **Availability**.

1. Under **AGGREGATION**, select **Avg**.

1. View the resulting chart. It should show just one line set at 100%.

1. Change the **AGGREGATION** option to **Min**. Again, it is unlikely that there will have been an Azure outage during the time, so the line should stay at 100%. This information generally doesn't change very much.

1. Select the **X** to the end of the right of the monitor ellipse to close it.

1. Select **Add metric**. Both the **RESOURCE** and **METRIC NAMESPACE** values should already be selected.

1. Under **METRIC**, select **Egress**.

1. Under **AGGREGATION**, select **Avg**, **Max**, and **Min**. Note how the data shapes change with each value. Finally, select **Sum**. You should have a single spike at the time when you imported the files.

## Split a Metric

Splitting a chart enables you to view additional dimensions in the data, depending on the type of metric that you are viewing. To split a metric, complete the following steps.

1. Select **Apply splitting**.

1. In the **SPLITTING** oval, from the dropdown, select **API name**.

1. View the output in the chart window. You should now have the following splits of the monitoring data:

    - ListBlobs - note this value
    - BlobPreflightRequest
    - PutBlockList
    - PutBlock
    - ListContainers
    - GetBlobproperties

1. Select the **X** to the right of the **SPLITTING** oval.

## Add a Filter

Filtering also enables you to look at the metrics with greater granularity. To apply a filter, complete the following steps.

1. Select **Add filter**.

1. Under **PROPERTY**, select **API name**.

1. Under **VALUES**, select **ListBlobs**. Note the data values and compare those with the **ListBlobs** value from the splitting exercise.

1. Select the **X** to the right of the filter oval to remove the filter.

## Customizing charts

You can customize charts in various ways, such as by changing the time range, time granularity, and time zone. To make these changes, carry out the following steps.

1. At the top of the chart, it says **Last 24 hours (automatic)**. Select this oval and the Time range and Time granularity dialog box appears.

1. Under **Time range**, select **Last 4 hours**. Note the ability to change from Local to UTC/GMT time, as needed.

1. Under **Time granularity**, select **5 minutes**, and then select **Apply**.

## View data in other Formats

Metric data can be viewed in other formats, including Line charts, bar charts, area charts, and scatter charts. To change the view of the data, complete the following steps.

1. Using the metrics defined in the previous section, select **Line Chart**, and then select **Area Chart**. Note the change in the display of the data.

1. Select **Area Chart**, and then select **Scatter Chart**. Note that with the low levels of storage activity, the scatter chart will only show the peaks of activity.

1. Select the ellipsis next to **Pin to dashboard**, and then select **Chart Settings**.

1. Under **Chart Title**, select **Custom**, and enter a more descriptive name for the chart.

1. Looking at the data you have displayed, under **Min value**, enter a value in bytes that is lower than the lowest data point you have.

1. Under **Max value**, enter a value in bytes that is slightly higher than the highest data point that you have. Your data should now fill the entire chart.

1. Select the different chart types and notice the change in the data display.

1. Select the **X** to close the **Chart settings** pane.

## Export a chart to Excel

Exporting a chart to Excel gives you all the data analysis tools of that platform.To export a chart to Excel, complete the following steps.

1. Select **Export to Excel**.

1. Open the Excel spreadsheet that gets downloaded.

1. View the data that the chart contains.
