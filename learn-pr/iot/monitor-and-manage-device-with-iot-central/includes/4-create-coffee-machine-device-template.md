To create a device template, you can either build it from scratch in the IoT Central UI, or get started by importing a device capability model.

Recall that in the IoT enabled coffee machines example, you'll connect a coffee machine simulator to IoT Central for monitoring telemetry such as water temperature and humidity, observe the state of the machine, set optimal temperature, receive warranty status, and send commands.

Here, you'll create and publish the **Connected Coffee Machine** device template defined in the device capability model.

## Create a device template

The [Sample code for Azure IoT Central Documentation](https://github.com/Azure-Samples/iot-central-docs-samples) GitHub repository contains the sample code. Copy the JSON from [iot-central-docs-samples/main/monitor-manage-device-with-iotcentral/CoffeeMaker.json](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/monitor-manage-device-with-iotcentral/CoffeeMaker.json) and save it on your local machine in a file called *CoffeeMaker.json*. This JSON is the device capability model for the coffee machine.

1. Browse to the URL for your IoT application that you created in the previous exercise, such as `https://coffee-maker-1234.azureiotcentral.com`.

1. Select the icon for **Device templates** on the home page of your Azure IoT Central application, and then select **+ New**.

1. On the **Select type** page, select the **IoT device** tile, and then select **Next: Customize**.

1. On the **Customize** page, enter *Connected Coffee Machine* as the device template name, then select **Next: Review**, and then select **Create**.

1. On the **Create a model** page, select the **Import a model** tile.

1. Browse to the *CoffeeMaker.json* file you created previously, and select **Open**.

IoT Central displays the **Connected Coffee Maker** capability model that defines the telemetry, properties, and commands that the device supports.

![Screenshot that shows Imported Connected Coffee Machine template.](../media/4-imported-template.png)

## Add views to your template

To create a view that lets you visualize the telemetry from your coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Views**.

1. Add a new **Visualizing the device** view called *Telemetry*.

1. Select **Start with devices** and add the following tiles:

    - Select **Cup Detected** in the **Telemetry** category and then **Add tile**. Change the tile visualization to **Last Known Value** and size to **2 x 1**.

    - Select **Brewing** in the **Telemetry** category and then **Add tile**. Change the tile visualization to **Last Known Value** and size to **2 x 1**.

    - Select **Water Temperature** and **Air Humidity** in the **Telemetry** category and then **Add tile**. Change the tile visualization to **Line chart** and size to **2 x 2** then select **Edit**. Change **Title** to *Telemetry* and confirm the **Display range** is set to **Past 30 minutes**. Select **Update**.

    - Select **Water Temperature** in the **Telemetry** category and then **Add tile**. Change the tile visualization to **KPI** and size to **1 x 1** then select **Edit**. Change **Title** to *Water Temperature* and select **Past 12 hours** in **Time range**. Select **Update**.

    - Select **Air Humidity** in the **Telemetry** category and then **Add tile**. Change the tile visualization to **KPI** and size to **1 x 1** then select **Edit**. Change **Title** to *Air Humidity* and select **Past 12 hours** in **Time range**. Select **Update**.

1. Save your changes.

    ![Screenshot that shows Connected Coffee Machine telemetry view.](../media/4-telemetry-view.png)

To create a view that lets you manage the properties of your coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Views**.

1. Add a new **Editing device and cloud data** form called *Properties*.

1. Select both the **Optimal Temperature** and **Device Warranty Expired** properties and the **Coffee Maker Min Temperature** and **Coffee Maker Max Temperature** cloud properties, and then select **Add section**.

1. Save your changes.

    ![Screenshot that shows Connected Coffee Machine property view.](../media/4-properties-form.png)

## Publish the Coffee Machine template

Before you can connect a coffee machine device to your IoT Central application, you need to publish the **Connected Coffee Machine** device template:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Publish**.

1. The **Publish this device template to the application** shows you the changes that you're publishing. Select **Publish**.

## Check your work

Verify that the device template was published and is ready to use:

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Check that the **Connected Coffee Machine** device is in the list of available device types:

    ![Screenshot that shows the Connected Coffee Machine published device template.](../media/4-published-template.png)
