---
metadata:
  title: Visualize your data in Time Series Insights
  description: This unit shows how to visualize the data ingested from Azure Digital Twins into Time Series Insights
  ms.date: 11/30/2020
  author: raniabayoumy
  ms.author: rabayoum
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Visualize your data in Time Series Insights
durationInMinutes: 5
---

## Create a Time Series Insights (TSI) environment

1. Enter the following command snippet in PowerShell to create a storage account (needed by TSI) and provision the TSI environment:

    ```powershell
    $storage="adtholtsitorage"+(get-random -maximum 10000)
    $tsiname=$random+"tsienv"
    az storage account create -g $rgname -n $storage --https-only -l $location
    $key=$(az storage account keys list -g $rgname -n $storage --query [0].value --output tsv)
    az timeseriesinsights environment longterm create -g $rgname -n $tsiname --location $location --sku-name L1 --sku-capacity 1 --data-retention 7 --time-series-id-properties '$dtId' --storage-account-name $storage --storage-management-key $key -l $location
    ```

1. After the TSI environment is provisioned, we need to set up an event source. We can use the Event Hub that receives the processed Twin Change events:

    ```powershell
    $es_resource_id=$(az eventhubs eventhub show -n tsi-event-hub -g $rgname --namespace $ehnamespace --query id -o tsv)
    $shared_access_key=$(az eventhubs namespace authorization-rule keys list -g $rgname --namespace-name $ehnamespace -n RootManageSharedAccessKey --query primaryKey --output tsv)
    az timeseriesinsights event-source eventhub create -g $rgname --environment-name $tsiname -n tsieh --key-name RootManageSharedAccessKey --shared-access-key $shared_access_key --event-source-resource-id $es_resource_id --consumer-group-name '$Default'
    ```

1. Finally, configure the permissions to access the data in the TSI environment:

    ```powershell
    $id=$(az ad user show --id $username --query objectId -o tsv)

    az timeseriesinsights access-policy create -g $rgname --environment-name $tsiname -n access1 --principal-object-id $id  --description "some description" --roles Contributor Reader
    ```

## View TSI data

Data should be flowing into your Time Series Insights instance now, ready to be analyzed. Refer to the following steps to explore the data coming in:

1. Open your instance of [Time Series Insights](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.TimeSeriesInsights%2Fenvironments) in the Azure portal.

1. Click on "Go to TSI Explorer" at the top of the page:

    :::image type="content" source="../media/adt-azure-portal-tsi-explorer.png" alt-text="Screenshot showing how to go to the TSI explorer in the Azure portal":::

1. In the explorer, you'll see one Twin from Azure Digital Twins shown on the left. Select GrindingStep, select Vibration, and hit add.

1. Next, you'll address the scenario that was presented earlier to *Visualize Vibration events in the past ~2 minutes and check if there are unusual spikes or dips to ensure the process meets manufacturing quality standards*. In the TSI explorer page, you'll see one Twin from Azure Digital Twins shown on the left. Select **GrindingStep** > select **Vibration** > and hit **Add**.

    :::image type="content" source="../media/adt-add-tsi-grindingStep-vibration-visualization.png" alt-text="Screenshot showing how to visualize vibration events in Azure Time Series Insights based on data ingested from the Digital Twin":::

You should now be seeing the Vibration readings from a device named "GrindingStep:"

:::image type="content" source="../media/adt-tsi-visualization-diagram.png" alt-text="Screenshot showing Digital Twin vibration events data visualized in Azure Time Series Insights":::

If you allow the simulation to run for much longer, your visualization will eventually look something like the following screenshot:

:::image type="content" source="../media/adt-tsi-prolonged-visualization-diagram.png" alt-text="Screenshot showing prolonged Digital Twin vibration events data visualized in Azure Time Series Insights":::

> [!TIP]
> If you don't see data or if it says there are no events to display:
>
> - Make sure the simulated client is running for at least 2 minutes
> - Ensure TSIFunction is deployed successfully with no errors
> - Try to hit refresh on the TSI Explorer toolbar

You can select the desired time range (2 minutes) by dragging the handles of the availability picker or using the date-time selector in the top-right corner:

:::image type="content" source="../media/adt-tsi-edit-time-range.png" alt-text="Screenshot showing how to change the time range in Azure Time Series Insights":::

Review events during the time window. You may expand the time range to get a broader understanding of the Vibration events. Based on the data input, the vibration events pattern in the past 2 minutes appear normal without unusual spikes or dips; no further analysis or action is required at this stage.
