Now, data should be flowing into your Time Series Insights instance, ready to be analyzed. Follow the steps below to explore the data coming in.

1. Open your Time Series Insights instance in the Azure portal (you can search for the name of your instance in the portal search bar). Visit the Time Series Insights Explorer URL shown in the instance overview.

    :::image type="content" source="../media/adt-twins-tsi-preview.png" alt-text="Screenshot showing the PAYG url" lightbox="../media/adt-twins-tsi-preview.png":::

1. In the explorer, you will see your three twins from Azure Digital Twins shown on the left. Select **vibrationsensorxx**, select **vibration**, and hit **add**.

    :::image type="content" source="../media/adt-twins-tsi-preview-2.png" alt-text="Screenshot showing selecting a device" lightbox="../media/adt-twins-tsi-preview-2.png":::

1. You should now be seeing the initial temperature readings from your vibration sensor, as shown below. That same temperature reading is updated for sensor2 and machine1, and you can visualize those data streams in tandem.

    :::image type="content" source="../media/adt-twins-tsi-preview-graph.png" alt-text="Screenshot showing a TSI graph" lightbox="../media/adt-twins-tsi-preview-graph.png":::

1. If you allow the simulation to run for much longer, your visualization will look something like this:

    :::image type="content" source="../media/adt-twins-tsi-preview-graph-2.png" alt-text="Screenshot showing a longer term TSI graph" lightbox="../media/adt-twins-tsi-preview-graph-2.png":::