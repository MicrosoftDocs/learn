In this unit, you will learn how to declare the network endpoints for the Altair emulator.

## Granting access to Mosquitto.org

The Altair emulator will be connecting to test.mosquitto.org. The connection must be declared in the **AllowedConnections** section in the application manifest file.

## Azure IoT Central network endpoints

When connecting to IoT Central you must declare the global device provisioning service endpoint as well as the endpoints for your IoT Central application. Otherwise, The Altair on Azure Sphere application will not be able to connect to IoT Central.

## Network endpoint capabilities

Network endpoints are declared in the application **app_manifest.json** file in the **AllowedConnections** section.

```json
{
    ...
    "AllowedConnections": [
      "test.mosquitto.org",
      "global.azure-devices-provisioning.net",
      "your-iot-central-network-endpoints"
    ],
    ...
}
```

In the following exercise you will learn how to declare the Azure IoT Central network endpoints.
