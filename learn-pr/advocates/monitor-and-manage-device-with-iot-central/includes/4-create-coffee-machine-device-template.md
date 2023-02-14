To create a device template, you can either build it from scratch in the IoT Central UI, or get started by importing a device capability model.

Recall that in the IoT enabled coffee machines example, you'll connect a coffee machine simulator to IoT Central for monitoring telemetry such as water temperature and humidity, observe the state of the machine, set optimal temperature, receive warranty status, and send commands.

Here, you'll create and publish the **Connected Coffee Machine** device template defined in the device capability model.

## Create a device template

You already have a device capability model for the coffee machine defined in the `CoffeeMaker.json`, so you'll use that.

1. Browse to the URL for your IoT application that you created in the previous exercise, such as https://coffee-maker-1234.azureiotcentral.com.

1. Select the icon for **Device templates** on the home page of your Azure IoT Central application in Azure IoT Central, and then select **+ New**.

1. On the **Select template type** page, select the **IoT device** tile, and then select **Next: Customize**.

1. On the **Customize** page, enter _Connected Coffee Machine_ as the device template name, then select **Next: Review**, and then select **Create**.

1. On the **Create a model** page, select the **Import a model** tile.

1. Browse to the **CoffeeMaker.json** file you created previously, and select **Open**.

IoT Central displays the **Connected Coffee Maker** capability model that defines the telemetry, properties, and commands that the device supports.

![Imported Connected Coffee Machine template.](../media/2-imported-template.png)

## Add cloud properties

To add the cloud properties that store the ideal water temperature range for coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select  **Connected Coffee Maker** capability model.

1. Add two cloud properties to the device template using the information in the following table; you might need to select the down icon to expand some of these values:

    | Display name | Name |Capability type | Semantic type | Schema | Min value | Max value | Decimal places | Unit|
    | ------------ | ---- | ------------- | ------------- | ------ | --------- | --------- | -------------- | ---- |
    | Coffee Maker Min Temperature | CoffeeMakerMinTemperature | Cloud Property | Temperature | Double | 88 | 92 | 1 | Degree celsius |
    | Coffee Maker Max Temperature | CoffeeMakerMaxTemperature | Cloud Property | Temperature | Double | 96 | 99 | 1 | Degree celsius |

1. Save your changes.

    ![Connected Coffee Machine cloud properties.](../media/2-cloud-properties.png)

## Add views to your template

To create a view that lets you visualize the telemetry from your coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Views**.

1. Add a new **Visualizing the device** view called _Telemetry_.

1. Select **Start with devices** and add the following tiles:

    - Add a 2x1 tile called **Cup Detected** to show the last known value of the **Cup Detected** telemetry value.

    - Add a 2x1 tile called **Brewing** to show the last known value of the **Brewing** telemetry value.

    - Add a 3x3 tile called **Telemetry** that uses a line chart to plot the average values of **Water Temperature** and **Air Humidity** for the past 30 minutes.

    - Add a 1x1 tile called **Water Temperature (Min)** that displays the minimum water temperature over the past 12 hours as a KPI.

    - Add a 1x1 tile called **Air Humidity (Max)** that displays the maximum air humidity over the past 12 hours as a KPI.

1. Save your changes.

    ![Connected Coffee Machine telemetry view.](../media/2-telemetry-view.png)

To create a view that lets you manage the properties of your coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Views**.

1. Add a new **Editing device and cloud data** form called _Properties_.

1. Add a section that includes both the **Optimal Temperature** and **Device Warranty Expired** properties and the **Coffee Maker Min Temperature** and **Coffee Maker Max Temperature** cloud properties, and then select **Add section**.

1. Save your changes.

    ![Connected Coffee Machine property view.](../media/2-properties-form.png)

## Publish the Coffee Machine template

Before you can connect a coffee machine device to your IoT Central application, you need to publish the **Connected Coffee Machine** device template:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Publish**.

1. The **Publish this device template to the application** shows you the changes that you're publishing. Select **Publish**.

To verify that the device template was published and is ready to use:

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Check that the **Connected Coffee Machine** device is in the list of available device types:

    ![Connected Coffee Machine published device template.](../media/2-published-template.png)
