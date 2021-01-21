In this unit, you'll learn how to visualize the data ingested into Time Series Insights from Azure Digital Twins.

## Create a Time Series Insights environment

1. Enter this command in PowerShell to create a storage account (needed by Time Series Insights) and provision the Time Series Insights environment:

    ```powershell
    $storage="adtholtsitorage"+(get-random -maximum 10000)
    $tsiname=$random+"tsienv"
    az storage account create -g $rgname -n $storage --https-only -l $location
    $key=$(az storage account keys list -g $rgname -n $storage --query [0].value --output tsv)
    az timeseriesinsights environment longterm create -g $rgname -n $tsiname --location $location --sku-name L1 --sku-capacity 1 --data-retention 7 --time-series-id-properties '$dtId' --storage-account-name $storage --storage-management-key $key -l $location
    ```

1. After the Time Series Insights environment is provisioned, you need to set up an event source. Use the event hub that receives the processed twin change events:

    ```powershell
    $es_resource_id=$(az eventhubs eventhub show -n tsi-event-hub -g $rgname --namespace $ehnamespace --query id -o tsv)
    $shared_access_key=$(az eventhubs namespace authorization-rule keys list -g $rgname --namespace-name $ehnamespace -n RootManageSharedAccessKey --query primaryKey --output tsv)
    az timeseriesinsights event-source eventhub create -g $rgname --environment-name $tsiname -n tsieh --key-name RootManageSharedAccessKey --shared-access-key $shared_access_key --event-source-resource-id $es_resource_id --consumer-group-name '$Default' -l $location
    ```

1. Configure the permissions for accessing the data in the Time Series Insights environment. Be sure to replace `{sunscriptionId}` with your Azure subscription ID.

    ```powershell
    $id=$(az ad user show --id {subscriptionId} --query objectId -o tsv)
    az timeseriesinsights access-policy create -g $rgname --environment-name $tsiname -n access1 --principal-object-id $id  --description "some description" --roles Contributor Reader
    ```

## View Time Series Insights data

Data should now be flowing into your Time Series Insights instance, ready to be analyzed. Follow these steps to explore the data coming in:

1. Open your instance of [Time Series Insights](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.TimeSeriesInsights%2Fenvironments) in the Azure portal.

1. At the top of the page, select **Go to TSI Explorer**:

    :::image type="content" source="../media/azure-portal-time-series-insights-explorer.png" alt-text="Screenshot that shows the Go to TSI Explorer button in the Azure portal.":::

1. You'll now address the scenario that was presented earlier: 

   - Visualize vibration events during approximately the past two minutes. 
   - Check if there are unusual spikes or dips to ensure the process meets manufacturing quality standards. 

   On the left side of the Time Series Insights Explorer page, you'll see one twin from Azure Digital Twins. Select **GrindingStep**, select **Vibration**, and then select **Add**:

    :::image type="content" source="../media/add-grinding-step-vibration-visualization.png" alt-text="Screenshot that shows how to visualize vibration events in Azure Time Series Insights.":::

You should now see the vibration readings from a device named GrindingStep:

:::image type="content" source="../media/visualization-diagram.png" alt-text="Screenshot that shows vibration event data visualized in Azure Time Series Insights." lightbox="../media/visualization-diagram.png":::

If you allow the simulation to run for much longer, your visualization will eventually look something like this one:

:::image type="content" source="../media/prolonged-visualization-diagram.png" alt-text="Screenshot that shows prolonged Azure Digital Twin vibration event data visualized in Azure Time Series Insights." lightbox="../media/prolonged-visualization-diagram.png":::

> [!TIP]
> If you don't see data or if a message says there are no events to display:
>
> - Make sure the simulated client is running for at least 2 minutes.
> - Be sure that TSIFunction is deployed successfully, with no errors.
> - Select the refresh button on the Time Series Insights Explorer toolbar.

You can select the time range (two minutes) by dragging the handles of the availability picker or by using the date/time selector in the upper-right corner:

:::image type="content" source="../media/edit-time-range.png" alt-text="Screenshot that shows how to change the time range in Azure Time Series Insights." lightbox="../media/edit-time-range.png":::

Review events during the time window. You can expand the time range to get a broader understanding of the vibration events. Based on the data input, the vibration events pattern for the past two minutes appears normal, without unusual spikes or dips. No further analysis or action is required at this stage.
