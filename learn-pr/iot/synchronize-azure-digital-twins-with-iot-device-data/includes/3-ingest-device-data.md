In this unit, you set up data ingestion into Azure Digital Twins. This involves the resources shown in Flow A below:

:::image type="content" source="../media/2-3-4-building-scenario.png" alt-text="Graph showing data flowing from a device into Azure Digital Twins, then throughout Azure Digital Twins." border="false" lightbox="../media/2-3-4-building-scenario.png":::

Data flow follows this path:
1. Temperature data is produced by the simulated device, *Thermostat 67*.
1. The temperature data is sent to the cloud, arriving in IoT Hub.
1. IoT Hub routes the temperature data to a custom Azure function.
1. The Azure function code uses the temperature data to update the *Temperature* property on the corresponding twin in Azure Digital Twins. In this case, that's the *Thermostat67* twin.

## Create required resources

### Create IoT Hub

https://learn.microsoft.com/en-us/azure/digital-twins/tutorial-end-to-end#create-an-iot-hub-instance

### Create Azure functions

#### Publish Azure function
https://learn.microsoft.com/en-us/azure/digital-twins/tutorial-end-to-end#publish-the-app

#### Configure permissions

## Connect resources

### Connect device to IoT Hub

Register device in IoT Hub

#### Update device configuration

### Connect IoT Hub to Azure function

## Run simulation