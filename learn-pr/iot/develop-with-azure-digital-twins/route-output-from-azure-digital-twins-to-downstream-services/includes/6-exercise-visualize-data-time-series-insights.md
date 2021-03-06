## Create a Time Series Insights environment

1. Enter the following command in PowerShell to create a storage account (needed by Time Series Insights) and provision the Time Series Insights environment:

    ```powershell
    $storage="adtholtsitorage"+(get-random -maximum 10000)
    $tsiname=$random+"tsienv"
    az storage account create -g $rgname -n $storage --https-only -l $location
    $key=$(az storage account keys list -g $rgname -n $storage --query [0].value --output tsv)
    az timeseriesinsights environment longterm create -g $rgname -n $tsiname --location $location --sku-name L1 --sku-capacity 1 --data-retention 7 --time-series-id-properties '$dtId' --storage-account-name $storage --storage-management-key $key -l $location
    ```

1. After the Time Series Insights environment is provisioned, you need to set up an event source. Use the Event Hub that receives the processed Twin Change events:

    ```powershell
    $es_resource_id=$(az eventhubs eventhub show -n tsi-event-hub -g $rgname --namespace $ehnamespace --query id -o tsv)
    $shared_access_key=$(az eventhubs namespace authorization-rule keys list -g $rgname --namespace-name $ehnamespace -n RootManageSharedAccessKey --query primaryKey --output tsv)
    az tsi event-source eventhub create -g $rgname --environment-name $tsiname -n tsieh --key-name RootManageSharedAccessKey --shared-access-key $shared_access_key --event-source-resource-id $es_resource_id --consumer-group-name '$Default' --event-hub-name "ehn" --service-bus-namespace "sbn" -l $location
    ```

1. Finally, configure the permissions to access the data in the Time Series Insights environment. Make sure you replace "{subscriptionId}" with your Azure Subscription ID:

    ```powershell
    $id=$(az ad user show --id {subscriptionId} --query objectId -o tsv)
    az timeseriesinsights access-policy create -g $rgname --environment-name $tsiname -n access1 --principal-object-id $id  --description "some description" --roles Contributor Reader
    ```

## View Time Series Insights data

Data should be flowing into your Time Series Insights instance now, ready to be analyzed. Refer to the following steps to explore the data coming in:

1. Open your instance of [Time Series Insights](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.TimeSeriesInsights%2Fenvironments) in the Azure portal.

1. Click on "Go to TSI Explorer" at the top of the page:

    :::image type="content" source="../media/azure-portal-time-series-insights-explorer.png" alt-text="Screenshot showing how to go to the Time Series Insights explorer in the Azure portal":::

1. Next, you'll address the scenario that was presented earlier to *Visualize Vibration events in the past ~2 minutes and check if there are unusual spikes or dips to ensure the process meets manufacturing quality standards*. In the Time Series Insights explorer page, you'll see one twin from Azure Digital Twins shown on the left. Select **GrindingStep**, then select **Vibration**, and finally, select **Add**.

    :::image type="content" source="../media/add-grinding-step-vibration-visualization.png" alt-text="Screenshot showing how to visualize vibration events in Azure Time Series Insights based on data ingested from the Digital Twin":::

You should now be seeing the Vibration readings from a device named "GrindingStep:"

:::image type="content" source="../media/visualization-diagram.png" alt-text="Screenshot showing Digital Twin vibration events data visualized in Azure Time Series Insights" lightbox="../media/visualization-diagram.png":::

If you allow the simulation to run for much longer, your visualization will eventually look something like the following screenshot:

:::image type="content" source="../media/prolonged-visualization-diagram.png" alt-text="Screenshot showing prolonged Digital Twin vibration events data visualized in Azure Time Series Insights" lightbox="../media/prolonged-visualization-diagram.png":::

> [!TIP]
> If you don't see data or if it says there are no events to display:
>
> - Make sure the simulated client is running for at least 2 minutes
> - Ensure "TSIFunction" is deployed successfully with no errors
> - Select refresh on the Time Series Insights Explorer toolbar

You can select the desired time range (2 minutes) by dragging the handles of the availability picker or using the date-time selector in the top-right corner:

:::image type="content" source="../media/edit-time-range.png" alt-text="Screenshot showing how to change the time range in Azure Time Series Insights" lightbox="../media/edit-time-range.png":::

Review events during the time window. You may expand the time range to get a broader understanding of the Vibration events. Based on the data input, the vibration events pattern in the past 2 minutes appear normal without unusual spikes or dips; no further analysis or action is required at this stage.
