A device template in Azure IoT Central is a blueprint that defines the characteristics and behaviors of a type of device that connects to your application. For example, the device template defines the telemetry that a device sends, so that IoT Central can create visualizations that use the correct units and data types.

A device template includes the following sections:
- A *device model*. The data that the coffee machine simulator exchanges with your application is specified in a device model.
    - *Root component*. The root component's interface describes capabilities that are specific to the device model.
    - *Components*. A device model may include components in addition to the root component to describe device capabilities. In this scenario, you will only use the root component to define the *Connected Coffee Maker* model.
    - *Inherited interfaces*. A device model contains one or more interfaces that extend the capabilities of the root component. In this scenario, you will define only one interface.
- *Cloud properties*. This part of the device template lets you specify the ideal water temperature range for the coffee machine. Cloud properties are never synchronized with devices and only exist in the application.
- *Views*. This part of the device template lets you define visualizations to view data from the device, and forms to manage and control the coffee machine.

After you create a device template, you can connect a simulated device. The simulated device generates telemetry so you can test the behavior of your application before connecting a real device.

In this unit, you will see how telemetry, properties and commands definitions are specified in the device model, and the cloud properties and views needed to manage and control the devices in the IoT enabled coffee machines example.

### Telemetry

Telemetry is the data that streams from your device. You can add multiple telemetry types to your device template to match the capabilities of your device. The coffee machine sends air humidity and water temperature values from its sensors. It also sends state information about whether it's currently brewing and when a cup is detected.

### Properties

Use properties to share configuration data between a device and your application.

In this scenario, you use a *writeable* property to set the optimal water temperature and send it to the coffee machine. When the writeable property is updated in IoT Central, it's marked as pending in the UI until the device acknowledges that it has responded to the update.

You can use *read-only* properties to enable a device to send values to your application. Read-only properties can only be changed by the device. In this scenario, you define a read-only device property called `Device Warranty Expired` in the device template. The `Device Warranty Expired` field remains empty until the coffee machine is connected to IoT Central. Once connected, the coffee machine sends the warranty status to the application.

### Commands

Use commands to remotely manage your device from your application. You can directly run commands on the device from the cloud to control the device. In this scenario, you run commands on your coffee machine to set it to maintenance mode or to start brewing.

### Cloud properties

Cloud properties are device metadata that's associated with the device. Use cloud properties to record information about your device in your IoT Central application. In this scenario, you use cloud properties to record the ideal water temperature range of the coffee machine. Cloud properties are stored in the IoT Central application and don't synchronize with the device. Cloud properties are not part of an interface definition.

### Views

You can customize the UI that IoT Central displays for managing and monitoring devices associated with the device template. In this scenario, you create a view to plot the telemetry values sent from the device, and create a form to manage the device properties.

## Connected Coffee Maker model

A device model is the part of the device template that defines the telemetry, properties, and commands that a device supports. You can store a device capability model in a JSON file and import it into IoT Central. The following JSON is the device capability model for the connected coffee machine. Copy the JSON and save it on your local machine in a file called `CoffeeMaker.json`:

```json
{
    "@id": "dtmi:com:example:ConnectedCoffeeMaker;1",
    "@type": "Interface",
    "contents": [
        {
            "@type": [
                "Telemetry",
                "NumberValue",
                "Temperature"
            ],
            "displayName": {
                "en": "Water Temperature"
            },
            "name": "WaterTemperature",
            "schema": "double",
            "unit": "degreeCelsius",
            "decimalPlaces": 1,
            "maxValue": 100,
            "minValue": 86
        },
        {
            "@type": [
                "Telemetry",
                "NumberValue",
                "Humidity"
            ],
            "displayName": {
                "en": "Air Humidity"
            },
            "name": "AirHumidity",
            "schema": "integer",
            "unit": "percent",
            "maxValue": 100,
            "minValue": 20
        },
        {
            "@type": [
                "Telemetry",
                "State"
            ],
            "displayName": {
                "en": "Brewing"
            },
            "name": "Brewing",
            "schema": {
                "@type": "Enum",
                "enumValues": [
                    {
                        "displayName": {
                            "en": "Brewing"
                        },
                        "enumValue": "brewing",
                        "name": "Brewing"
                    },
                    {
                        "displayName": {
                            "en": "Not Brewing"
                        },
                        "enumValue": "notbrewing",
                        "name": "NotBrewing"
                    }
                ],
                "valueSchema": "string"
            }
        },
        {
            "@type": [
                "Telemetry",
                "State"
            ],
            "displayName": {
                "en": "Cup Detected"
            },
            "name": "CupDetected",
            "schema": {
                "@type": "Enum",
                "enumValues": [
                    {
                        "displayName": {
                            "en": "Detected"
                        },
                        "enumValue": "detected",
                        "name": "Detected"
                    },
                    {
                        "displayName": {
                            "en": "Not Detected"
                        },
                        "enumValue": "notdetected",
                        "name": "NotDetected"
                    }
                ],
                "valueSchema": "string"
            }
        },
        {
            "@type": [
                "Property",
                "NumberValue",
                "Initialized",
                "Temperature"
            ],
            "displayName": {
                "en": "Optimal Temperature"
            },
            "name": "OptimalTemperature",
            "schema": "double",
            "unit": "degreeCelsius",
            "writable": true,
            "decimalPlaces": 1,
            "initialValue": 98,
            "maxValue": 100,
            "minValue": 86
        },
        {
            "@type": [
                "Property",
                "BooleanValue"
            ],
            "displayName": {
                "en": "Device Warranty Expired"
            },
            "name": "DeviceWarrantyExpired",
            "schema": "boolean",
            "writable": false
        },
        {
            "@type": "Command",
            "commandType": "synchronous",
            "displayName": {
                "en": "Set Maintenance Mode"
            },
            "name": "SetMaintenanceMode"
        },
        {
            "@type": "Command",
            "commandType": "synchronous",
            "displayName": {
                "en": "Start Brewing"
            },
            "name": "StartBrewing"
        }
    ],
    "displayName": {
        "en": "Connected Coffee Maker"
    },
    "@context": [
        "dtmi:iotcentral:context;2",
        "dtmi:dtdl:context;2"
    ]
}
```

## Create a device template

To create a device template, you can either build it from scratch in the IoT Central UI, or get started by importing a device capability model. You already have a device capability model for the coffee machine defined in a JSON file, so you'll use that.

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
