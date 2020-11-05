
Now, data should be flowing into your Time Series Insights instance, ready to be analyzed. Follow the steps below to explore the data coming in.

1. Open your Time Series Insights instance in the Azure portal (you can search for the name of your instance in the portal search bar). Visit the Time Series Insights Explorer URL shown in the instance overview.

    [![Screenshot showing the PAYG url](media/adt-twins-tsi-preview.png)](media/adt-twins-tsi-preview.png#lightbox)


1. In the explorer, you will see your three twins from Azure Digital Twins shown on the left. Select **vibrationsensorxx**, select **vibration**, and hit **add**.

    [![Screenshot showing selecting a device](media/adt-twins-tsi-preview-2.png)](media/adt-twins-tsi-preview-2.png#lightbox)

1. You should now be seeing the initial temperature readings from your vibration sensor, as shown below. That same temperature reading is updated for sensor2 and machine1, and you can visualize those data streams in tandem.

    [![Screenshot showing a TSI graph](media/adt-twins-tsi-preview-graph.png)](media/adt-twins-tsi-preview-graph.png#lightbox)

1. If you allow the simulation to run for much longer, your visualization will look something like this:

    [![Screenshot showing a longer term TSI graph](media/adt-twins-tsi-preview-graph-2.png)](media/adt-twins-tsi-preview-graph-2.png#lightbox)