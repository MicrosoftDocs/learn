
In this exercise, you will set up a Time Series Insights instance to receive the data from your second event hub. Follow the steps below, and for more details about this process, see Tutorial: Set up an [Azure Time Series Insights Gen2 PAYG environment](https://docs.microsoft.com/azure/time-series-insights/tutorials-set-up-tsi-environment).

In the Azure portal, begin creating a Time Series Insights resource.

1. Select the **PAYG(Previe**w) pricing tier.
1. You will need to choose a **time series ID** for this environment. Your time series ID can be up to three values that you will use to search for your data in Time Series Insights. For this tutorial, you can use `$dtId`. Read more about selecting an ID value in [Best practices for choosing a Time Series ID](https://docs.microsoft.com/azure/time-series-insights/how-to-select-tsid).

    [![Screenshot showing the first steps in creating time series insights](media/adt-create-time-series-insights.png)](media/adt-create-time-series-insights.png#lightbox)

1. Select **Next: Event Source** and select your Event Hubs information from above. You will also need to create a new Event Hubs consumer group.

    [![Screenshot showing the first steps in creating time series insights-2](media/adt-create-time-series-insights-2.png)](media/adt-create-time-series-insights-2.png#lightbox)

## Begin sending IoT data to Azure Digital Twins

To begin sending data to Time Series Insights, you will need to start updating the digital twin properties in Azure Digital Twins with changing data values. Use the [az dt twin update](https://docs.microsoft.com/cli/azure/ext/azure-iot/dt/twin?view=azure-cli-latest#ext-azure-iot-az-dt-twin-update) command.

    > [!Note]
    > There is currently a known issue in Cloud Shell affecting these command groups: az dt route, az dt model, az dt twin.
    > To resolve, either run az login in Cloud Shell prior to running the command, or use the local CLI instead of Cloud Shell. For more detail on this, see [Troubleshooting: Known issues in Azure Digital Twins](https://docs.microsoft.com/azure/digital-twins/troubleshoot-known-issues#400-client-error-bad-request-in-cloud-shell).
