In this unit, you'll learn how to declare the network endpoints for the Altair emulator.

## Granting access to `Mosquitto.org`

The Altair emulator will be connecting to test.mosquitto.org. The network endpoint must be declared in the **AllowedConnections** section in the application manifest file.

## Azure IoT Central network endpoints

The Altair emulator will also be connecting to IoT Central. The global device provisioning service endpoint and the IoT Central network endpoints must be declared in the **AllowedConnections** section in the application manifest file. If you don't, the Altair emulator can't connect to IoT Central.

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

In the following exercise, you'll learn how to declare the Azure IoT Central network endpoints.
