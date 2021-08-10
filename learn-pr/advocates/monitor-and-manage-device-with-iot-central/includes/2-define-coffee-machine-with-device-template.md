In Azure IoT Central, the data that a device can exchange with your application is specified in a device template. The template defines the behavior and capabilities of a device or in this case, a coffee machine.

After you create a device template, you can create a simulated device. The simulated device generates telemetry for you to test the behavior of your application before connecting a real device.

In this unit, you create a device template for a coffee machine that specifies its capabilities and behaviors. Telemetry and property definitions are grouped together in interfaces. In this scenario, you only define a single interface for the coffee machine device that includes telemetry, property, and command definitions:

### Telemetry

Telemetry is the data that comes from your device. You can add multiple telemetry types to your device template to match the capabilities of your device. The coffee machine sends air humidity and water temperature values from its sensors. It also sends state information about whether it's currently brewing and whether a cup is detected.

### Properties

You use properties to share configuration data between a device and your application.

In this scenario, you use a _writeable_ property to set the optimal water temperature and send it to the coffee machine. When the writeable property is updated in IoT Central, it's marked as pending in the UI until the device acknowledges that it has responded to the update.

You can use _read-only_ properties to enable a device to send values to your application. Read-only properties can only be changed by the device. In this scenario, you define a device property called **Device Warranty Expired** in the device template. The **Device Warranty Expired** field remains empty until the coffee machine is connected to IoT Central. Once connected, the coffee machine sends the warranty status to the application.

### Commands

You use commands to remotely manage your device from your application. You can directly run commands on the device from the cloud to control the device. In this scenario, you run commands on your coffee machine to set it to maintenance mode or to start brewing.

### Cloud properties

_Cloud properties_ are the device metadata that's associated with the device. You use cloud properties to record information about your device in your IoT Central application. In this scenario, you use cloud properties to record the ideal water temperature range of the coffee machine. Cloud properties are stored in the application and don't synchronize with the device. Cloud properties are not part of an interface definition.

### Customizations

You can customize how IoT Central uses the items defined in an interface, for example by specifying maximum and minimum temperature values and customizing how IoT Central displays values. In this scenario, you customize the temperature and air humidity telemetry types, and the optimal temperature and device warranty property types.

### Views

You can customize the UI that IoT Central displays for managing and monitoring devices associated with the device template. In this scenario, you create a view to plot the telemetry values sent from the device, and create a form to manage the device properties.

## Device capability models

A device capability model defines the telemetry, properties, and commands that a device supports. You can store a device capability model in a JSON file and import it into IoT Central. The following JSON is the device capability model for the connected coffee machine. Copy the JSON and save it on your local machine in a file called `CoffeeMaker.json`:

```json
{
  "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_cm:1",
  "@type": "CapabilityModel",
  "implements": [
    {
      "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_cm:gch18jeg:1",
      "@type": "InterfaceInstance",
      "displayName": {
        "en": "Connected Coffee Maker"
      },
      "name": "ConnectedCoffeeMaker_if",
      "schema": {
        "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:1",
        "@type": "Interface",
        "displayName": {
          "en": "Coffee Maker Interface"
        },
        "contents": [
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:WaterTemperature:1",
            "@type": [
              "Telemetry",
              "SemanticType/Temperature"
            ],
            "displayName": {
              "en": "Water Temperature"
            },
            "name": "WaterTemperature",
            "displayUnit": {
              "en": "Celsius"
            },
            "schema": "double",
            "unit": "Units/Temperature/celsius"
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:AirHumidity:1",
            "@type": [
              "Telemetry",
              "SemanticType/Humidity"
            ],
            "displayName": {
              "en": "Air Humidity"
            },
            "name": "AirHumidity",
            "displayUnit": {
              "en": "%"
            },
            "schema": "integer",
            "unit": "Units/Humidity/percent"
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:Brewing:1",
            "@type": [
              "Telemetry",
              "SemanticType/State"
            ],
            "displayName": {
              "en": "Brewing"
            },
            "name": "Brewing",
            "schema": {
              "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:Brewing:ukyropau:1",
              "@type": "Enum",
              "valueSchema": "string",
              "enumValues": [
                {
                  "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:Brewing:ukyropau:Brewing:1",
                  "@type": "EnumValue",
                  "displayName": {
                    "en": "Brewing"
                  },
                  "enumValue": "brewing",
                  "name": "Brewing"
                },
                {
                  "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:Brewing:ukyropau:NotBrewing:1",
                  "@type": "EnumValue",
                  "displayName": {
                    "en": "Not Brewing"
                  },
                  "enumValue": "notbrewing",
                  "name": "NotBrewing"
                }
              ]
            }
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:CupDetected:1",
            "@type": [
              "Telemetry",
              "SemanticType/State"
            ],
            "displayName": {
              "en": "Cup Detected"
            },
            "name": "CupDetected",
            "schema": {
              "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:CupDetected:eknxwzoxs:1",
              "@type": "Enum",
              "valueSchema": "string",
              "enumValues": [
                {
                  "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:CupDetected2:twuxgg9v:Detected:1",
                  "@type": "EnumValue",
                  "displayName": {
                    "en": "Detected"
                  },
                  "enumValue": "detected",
                  "name": "Detected"
                },
                {
                  "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:CupDetected2:twuxgg9v:NotDetected:1",
                  "@type": "EnumValue",
                  "displayName": {
                    "en": "Not Detected"
                  },
                  "enumValue": "notdetected",
                  "name": "NotDetected"
                }
              ]
            }
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:OptimalTemperature:1",
            "@type": [
              "Property",
              "SemanticType/Temperature"
            ],
            "displayName": {
              "en": "Optimal Temperature"
            },
            "name": "OptimalTemperature",
            "writable": true,
            "schema": "double",
            "unit": "Units/Temperature/celsius"
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:DeviceWarrantyExpired:1",
            "@type": "Property",
            "displayName": {
              "en": "Device Warranty Expired"
            },
            "name": "DeviceWarrantyExpired",
            "schema": "boolean"
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:SetMaintenanceMode:1",
            "@type": "Command",
            "commandType": "synchronous",
            "displayName": {
              "en": "Set Maintenance Mode"
            },
            "name": "SetMaintenanceMode"
          },
          {
            "@id": "urn:coffeeMakerContoso:ConnectedCoffeeMaker_if:StartBrewing:1",
            "@type": "Command",
            "commandType": "synchronous",
            "displayName": {
              "en": "Start Brewing"
            },
            "name": "StartBrewing"
          }
        ]
      }
    }
  ],
  "displayName": {
    "en": "Connected Coffee Maker"
  },
  "contents": [],
  "@context": [
    "http://azureiot.com/v1/contexts/IoTModel.json"
  ]
}
```

## Create a device template

To create a device template, you can either build it from scratch in the IoT Central UI, or get started by importing a device capability model. You already have a device capability model for the coffee machine defined in a JSON file, so you'll use that.

1. Navigate to the **Device templates** page of your Azure IoT Central application in Azure IoT Central and select **+ New**.

1. On the **Select template type** page, select the **IoT device** tile, and then select **Next: Customize**.

1. On the **Customize device** page, select **Next: Review**. Then select **Create**.

1. Enter _Connected Coffee Machine_ as the device template name, and then press **Enter**.

1. On the **Create a capability model** page, select the **Import capability model** tile. Then browse to and select the **CoffeeMaker.json** file you created previously, and select **Open**.

IoT Central displays the **Connected Coffee Maker** capability model with the **Coffee Maker** interface that defines the telemetry, properties, and commands that the device supports.

![Imported Connected Coffee Machine template.](../media/2-imported-template.png)

## Add cloud properties

To add the cloud properties that store the ideal water temperature range for coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Cloud properties**.

1. Add two cloud properties to the device template using the information in the following table:

    | Display name | Name | Semantic type | Schema | Min value | Max value | Decimal places | Unit |
    | ------------ | ---- | ------------- | ------ | --------- | --------- | -------------- | ---- |
    | Coffee Maker Min Temperature | CoffeeMakerMinTemperature | Temperature | Double | 88 | 92 | 1 | &deg;C |
    | Coffee Maker Max Temperature | CoffeeMakerMaxTemperature | Temperature | Double | 96 | 99 | 1 | &deg;C |

1. Save your changes.

    ![Connected Coffee Machine cloud properties.](../media/2-cloud-properties.png)

## Customize your template

To add the customizations that control how IoT Central displays information about a coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Customize**.

1. Use the information in the following table to customize the **Water Temperature** and **Air Humidity** telemetry types, and the **Optimal Temperature** property type:

    | Display name | Min value | Max value | Decimal places | Initial value |
    | ------------ | --------- | --------- | -------------- | ------------- |
    | Water Temperature | 86   | 100       | 1              | |
    | Air Humidity      | 20   | 100       | 0              | |
    | Optimal Temperature | 86 | 100       | 1              | 96            |

1. Use the information in the following table to customize the **Device Warranty** property type:

    | Display name            | True name | False name  |
    | ----------------------- | --------- | ----------- |
    | Device Warranty Expired | Expired   | In warranty |

1. Save your changes.

    ![Connected Coffee Machine template customizations.](../media/2-template-customizations.png)

## Add views to your template

To create a view that lets you visualize the telemetry from your coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Views**.

1. Add a new **Visualizing the device** view called _Telemetry_.

1. Add a 2x1 tile called **Cup Detected** to show the last known value of the **Cup Detected** state telemetry value.

1. Add a 2x1 tile called **Brewing** to show the last known value of the **Brewing** state telemetry value.

1. Add a 3x3 tile called **Telemetry** that uses a line chart to plot the average values of **Water Temperature** an **Air Humidity** for the past 30 minutes.

1. Add a 1x1 tile called **Water Temperature (Min)** that displays the minimum water temperature over the past 12 hours as a KPI.

1. Add a 1x1 tile called **Air Humidity (avg)** that displays the maximum air humidity over the past 12 hours as a KPI.

1. Save your changes.

    ![Connected Coffee Machine telemetry view.](../media/2-telemetry-view.png)

To create a view that lets you manage the properties of your coffee machine:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Views**.

1. Add a new **Editing device and cloud data** form called _Properties_.

1. Add a section that includes both the **Optimal Temperature** and **Device Warranty Expired** properties and the **Coffee Maker Min Temperature** and **Coffee Maker Max Temperature** cloud properties.

1. Save your changes.

    ![Connected Coffee Machine telemetry view.](../media/2-properties-form.png)

## Publish the Coffee Machine template

Before you can connect a coffee machine device to your IoT Central application, you need to publish the **Connected Coffee Machine** device template:

1. Navigate to the **Connected Coffee Machine** device template you created, and select **Publish**.

1. The **Publish this device template to the application** shows you the changes that you're publishing. Select **Publish**.

To verify that the device template was published and is ready to use:

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Check that the **Connected Coffee Machine** device is in the list of available device types:

    ![Connected Coffee Machine published device template.](../media/2-published-template.png)
