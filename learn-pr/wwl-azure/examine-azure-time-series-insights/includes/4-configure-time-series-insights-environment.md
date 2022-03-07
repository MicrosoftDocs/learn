Azure Time Series Insights allows you to get started visualizing and querying data flowing into Azure IoT Hubs and Event Hubs in minutes, enabling you to query large volumes of time series data in seconds.

## Create your TSI resource

You can create a new Azure Time Series Insights resource in the Azure portal using the process described below. Azure CLI can also be used.

> [!NOTE]
> The steps shown here are for a Gen1 environment. Creating a Gen2 environment follows a similar series of configuration steps.

1.  Search the Azure Marketplace for "Time Series Insights". :::image type="content" source="../media/m05-l01-azure-tsi-setup-1-create-b6af0a59.png" alt-text="Screenshot that shows Time Series Insights in the Azure Marketplace.":::
    
2.  On the Create Time Series Insights environment blade, fill in the parameters on the Basic tab
    
    :::row:::
      :::column:::
        **Parameter**
      :::column-end:::
      :::column:::
        **Action**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Environment name
      :::column-end:::
      :::column:::
        Enter a unique name for the Azure Time Series Insights Preview environment.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Enter the subscription where you want to create the Azure Time Series Insights Preview environment. A best practice is to use the same subscription as the rest of the IoT resources that are created by the device simulator.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        Select an existing resource group or create a new resource group for the Azure Time Series Insights Preview environment resource. A resource group is a container for Azure resources. A best practice is to use the same resource group as the other IoT resources that are created by the device simulator.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        Select a data center region for your Azure Time Series Insights Preview environment. To avoid extra latency, it's best to create your Azure Time Series Insights Preview environment in the same region as your IoT hub created by the device simulator.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Tier
      :::column-end:::
      :::column:::
        Select PAYG (pay-as-you-go). This is the SKU for the Azure Time Series Insights Preview product.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Property ID
      :::column-end:::
      :::column:::
        Enter a value that uniquely identifies your time series instance. The value you enter in the Property ID box cannot be changed later. When the data source is an IoT Hub, iothub-connection-device-id is often used. To learn more about Time Series ID, see Best practices for choosing a Time Series ID.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Storage account name
      :::column-end:::
      :::column:::
        Enter a globally unique name for a new storage account.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Enable warm store
      :::column-end:::
      :::column:::
        Select Yes to enable warm store.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Data retention (in days)
      :::column-end:::
      :::column:::
        Choose the default option of 7 days.
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/m05-l01-azure-tsi-setup-2-parameters-1-04679ae1.png" alt-text="Screenshot that shows initial configuration details for the Time Series Insights environment.":::
    :::image type="content" source="../media/m05-l01-azure-tsi-setup-2-parameters-2-e583be2a.png" alt-text="Screenshot that shows Storage Configuration details for the Time Series Insights environment.":::
     Once you have this information entered, navigate to the Event Source tab.
3.  Fill in the parameters on the Event Source tab.
    
    :::row:::
      :::column:::
        **Parameter**
      :::column-end:::
      :::column:::
        **Action**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Create an event source?
      :::column-end:::
      :::column:::
        Select Yes.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Name
      :::column-end:::
      :::column:::
        Enter a unique value for the event source name.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Source type
      :::column-end:::
      :::column:::
        Select IoT Hub.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Select a hub
      :::column-end:::
      :::column:::
        Choose Select existing.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        Select the subscription that you are using for this course.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        IoT Hub name
      :::column-end:::
      :::column:::
        Select the IoT hub name that you are using for this course.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        IoT Hub access policy
      :::column-end:::
      :::column:::
        Select iothubowner.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        IoT Hub consumer group
      :::column-end:::
      :::column:::
        Select New, enter a unique name, and then select Add. The consumer group must be a unique value in Azure Time Series Insights Preview.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Timestamp property
      :::column-end:::
      :::column:::
        This value is used to identify the Timestamp property in your incoming telemetry data. Time Series Insights defaults to the incoming timestamp from IoT Hub.
      :::column-end:::
    :::row-end:::
    
    
    :::image type="content" source="../media/m05-l01-azure-tsi-setup-2-parameters-3-5aae94ce.png" alt-text="Screenshot that shows Event Source configuration details for the Time Series Insights environment.":::
     Once you have this information entered, navigate to the Review + Create tab.
4.  Use the Review + Create tab to ensure that you entered values correctly, and then click Create to deploy your TSI service. You have access to your Azure Time Series Insights Preview environment by default if you are an owner of the Azure subscription. You can verify that you have access by opening your TSI service and checking to see that your credentials are listed on the Data Access Policies blade.

## Gen2 environment differences

There a few key differences between a Gen2 environment and Gen1 S1 or Gen1 S2 environments to bear in mind when you manage your environment through the Azure portal:

 -  The Azure portal Gen2 Overview pane has the following changes:<br>
    
     -  Capacity is removed because it doesn't apply to Gen2 environments.<br>
     -  The Time series ID property is added. It determines how your data is partitioned.
     -  Reference data sets are removed.
     -  The displayed URL directs you to the Azure Time Series Insights Explorer.
     -  Your Azure Storage account name is listed.
 -  The Azure portal's Configure pane is removed because scale units don't apply to Azure Time Series Insights Gen2 environments. However, you can use Storage Configuration to configure the newly introduced warm store.
 -  The Azure portal's Reference data pane is removed in Azure Time Series Insights Gen2 because reference data concept has been replaced by Time Series Model (TSM).<br>
