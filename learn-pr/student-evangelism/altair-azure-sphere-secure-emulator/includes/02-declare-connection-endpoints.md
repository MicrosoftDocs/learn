In this unit, you'll learn how to declare the network endpoints for the Altair emulator.

You must declare all network endpoints, peripherals, and inter-core communications the Altair emulator will be using. Any attempt by an Altair emulator to connect to resources not declared in the Capabilities section will fail.

The Altair emulator connects to two cloud services. IoT Central for configuration and reporting, and an [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) broker. The MQTT broker is used to relay messages between the Altair emulator, the Web Terminal, and the virtual disk server.

## Network endpoint capabilities

Network endpoints are declared in the Altair emulator application **app_manifest.json** file in the **AllowedConnections** section. 

The following JSON is an example of how network endpoints are declared.

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

## Azure IoT Central network endpoints

The Altair emulator will be connecting to IoT Central. The global device provisioning service endpoint and the IoT Central network endpoints must be declared in the **AllowedConnections** section in the application manifest file. If you don't, the Altair emulator can't connect to IoT Central.

## The MQTT broker network endpoint

The Altair emulator will also be connecting to a public MQTT broker at *test.mosquitto.org*. The network endpoint must be declared in the **AllowedConnections** section in the application manifest file.

