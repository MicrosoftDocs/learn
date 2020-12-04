In this unit you will learn about Azure Sphere security.

Applications on Azure Sphere are secure by default. You must grant capabilities to the application. Granting capabilities is key to Azure Sphere security and is also known as the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege?azure-portal=true). You should grant only the capabilities that the Azure Sphere application needs to run correctly, and no more.

Application capabilities include what hardware can be accessed, what network endpoints can be called, and what inter-core communications is allowed.

## IoT Central network endpoints

You must declare all network endpoints your application will use. As a security feature, if you try to access any endpoint that has not been declared in the application manifest then the application will fail when it tries to connect. This security is implemented as a network firewall that cannot be changed until the device is restarted.

When connecting to IoT Central you must declare the global device provisioning service endpoint as well as the endpoints for your IoT Central application. Otherwise, your Azure Sphere application will not be able to connect to IoT Central.

## Network endpoint capabilities

Network endpoints are declared in the application **app_manifest.json** file in the **AllowedConnections** section.

```json
{
    ...
    "AllowedConnections": [
      "global.azure-devices-provisioning.net",
      "your-iot-central-network-endpoints"
    ],
    ...
}
```

## Access to hardware

Remember, Azure Sphere applications are secure by default and you must declare access to hardware peripherals your application requires. If you do not declare the hardware your application needs, then your application will fail when it tries to access the hardware. Security access to hardware is implemented in hardware as a silicon firewall. As an extra layer of security, the silicon firewall is "sticky", silicon firewall settings remain in place until the device is restarted.

## Hardware capabilities

Hardware is declared in the application **app_manifest.json** file in the **Capabilities** section.

```json
{
  ...
  "Capabilities": {
    "Gpio": [
      "$BUTTON_A",
      "$NETWORK_CONNECTED_LED",
      "$ALERT_LED"
    ],
    "I2cMaster": [
      "$I2cMaster2"
    ],
  ...
  },
  ...
}
```

## Hardware definitions

Azure Sphere hardware is available from multiple vendors, and each vendor may expose features of the underlying chip in different ways. Azure Sphere applications manage hardware dependencies by using hardware definition files. For further information, review the [Managing target hardware dependencies](https://docs.microsoft.com/azure-sphere/app-development/manage-hardware-dependencies?azure-portal=true) article.

The labs for this learning module have a set of hardware definition files for the AVNET and SEEED Studio Azure Sphere developer boards. The **azure_sphere_learning_path** hardware definition file is included in main.c for each lab.

```c
#include "hw/azure_sphere_learning_path.h"
```

You will learn how to declare network endpoints in the following exercise.
