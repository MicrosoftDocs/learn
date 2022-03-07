To begin, you need to declare all network endpoints, peripherals, and inter-core communications that the Altair emulator will be using. Any attempt by an Altair emulator to connect to resources that are *not* declared in the capabilities section will fail.

The Altair emulator connects to two cloud services:
* Azure IoT Central, for configuration and reporting
* An [MQTT](https://en.wikipedia.org/wiki/MQTT?azure-portal=true) broker, to relay messages between the Altair emulator, the web terminal, and the virtual disk server

## Network endpoint capabilities

You declare network endpoints in the Altair emulator application *app_manifest.json* file, in the `AllowedConnections` section, as shown in the following JSON code:

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

The Altair emulator will be connecting to Azure IoT Central. You need to declare the global device provisioning service endpoint and the Azure IoT Central network endpoints in the `AllowedConnections` section in the application manifest file. If you don't declare the endpoints there, the Altair emulator can't connect to Azure IoT Central.

## The MQTT broker network endpoint

The Altair emulator will also be connecting to a public MQTT broker at the [test.mosquitto.org website](https://test.mosquitto.org/). You declare the network endpoint in the `AllowedConnections` section of the application manifest file.
