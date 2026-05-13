In this unit you will learn about Azure Sphere security.

Applications on Azure Sphere are secure by default. You must grant capabilities to the application. Granting capabilities is key to Azure Sphere security and is also known as the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege?azure-portal=true). You should grant only the capabilities that the Azure Sphere application needs to run correctly.

Application capabilities include what hardware can be accessed, what network endpoints can be called, and what inter-core communications is allowed.

## IoT Hub and DPS network endpoints

You must declare all network endpoints your application will use. As a security feature, if you try to access any endpoint that has not been declared in the application manifest then the application will fail when it tries to connect. This security is implemented as a network firewall that cannot be changed until the application package is updated.

When you connect to IoT Hub via the Device Provisioning Service (DPS), your application's `AllowedConnections` capability must include the DPS global endpoint `global.azure-devices-provisioning.net` and the hostname of every IoT hub that DPS may assign the device to (each hub's `<your-iot-hub>.azure-devices.net` hostname). Do **not** add the per-instance DPS service endpoint (the `<dpsName>.azure-devices-provisioning.net` value) to `AllowedConnections` — Azure Sphere devices reach DPS only through the global endpoint, and adding the service endpoint over-grants network access without enabling provisioning.

`AllowedConnections` entries are DNS hostnames or IPv4 addresses only. Don't include a URI scheme such as `https://`, a port number, a path, or wildcard characters.

## Network endpoint capabilities

Network endpoints are declared in the application **app_manifest.json** file as the **AllowedConnections** capability inside the **Capabilities** section. See the [App manifest reference](/azure-sphere/app-development/app-manifest?azure-portal=true) for the complete schema and a description of every capability.

```json
{
  "SchemaVersion": 1,
  "Name": "MyAzureSphereApp",
  "ComponentId": "<your component id>",
  "EntryPoint": "/bin/app",
  "CmdArgs": [],
  "Capabilities": {
    "AllowedConnections": [
      "global.azure-devices-provisioning.net",
      "<your-iot-hub>.azure-devices.net"
    ],
    "DeviceAuthentication": "<your Azure Sphere (Legacy) tenant UUID>"
  },
  "ApplicationType": "Default"
}
```

For Azure Sphere (Integrated), get the Azure Sphere (Legacy) tenant UUID by showing the catalog and extracting `tags.MigratedCatalogId`, for example: `az sphere catalog show --resource-group <rg> --catalog <name> --query "tags.MigratedCatalogId" -o tsv`. Don't use the catalog resource name, catalog Azure resource ID, Microsoft Entra tenant ID, Azure subscription ID, IoT Hub name, DPS name, or DPS ID Scope for `DeviceAuthentication`.

## Access to hardware

Remember, Azure Sphere applications are secure by default and you must declare access to hardware peripherals your application requires. If you do not declare the hardware your application needs, then your application will fail when it tries to access the hardware. Security access to hardware is implemented in hardware as a silicon firewall.

On a production Azure Sphere device — that is, one in the `DeviceComplete` manufacturing state with the `appDevelopment` device capability *not* present — the silicon firewall configuration is locked at the end of system startup and remains in place until the device is rebooted. This is what is meant by the firewall being "sticky": once locked, peripheral assignments cannot be changed without a reboot. On a development device (one that has the `appDevelopment` capability, as you do for the labs in this module), the firewall is reconfigured each time applications are sideloaded, so a device restart is only needed when peripheral assignments change between deployed apps. For details, see [Peripheral configuration locking](/azure-sphere/deployment/peripheral-configuration-locking?azure-portal=true).

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

Azure Sphere hardware is available from multiple vendors, and each vendor may expose features of the underlying chip in different ways. Azure Sphere applications manage hardware dependencies by using hardware definition files. For further information, review the [Managing target hardware dependencies](/azure-sphere/app-development/manage-hardware-dependencies?azure-portal=true) article.

The labs for this learning module have a set of hardware definition files for the AVNET and SEEED Studio Azure Sphere developer boards. The labs include the generated **azure_sphere_learning_path** hardware-definition header from the application's source or header files (for example, `#include "hw/azure_sphere_learning_path.h"` from `main.h`). The active hardware definition for a given board is selected at build time by the application's CMakeLists.txt.

```c
#include "hw/azure_sphere_learning_path.h"
```
