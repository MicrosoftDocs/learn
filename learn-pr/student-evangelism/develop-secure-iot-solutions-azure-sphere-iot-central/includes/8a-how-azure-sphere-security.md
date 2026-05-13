In this unit you will learn about Azure Sphere security.

Applications on Azure Sphere are secure by default. You must grant capabilities to the application. Granting capabilities is key to Azure Sphere security and is also known as the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege?azure-portal=true). You should grant only the capabilities that the Azure Sphere application needs to run correctly, and no more.

Application capabilities include what hardware can be accessed, what network endpoints can be called, and which application components can communicate with each other.

## IoT Central network endpoints

You must declare all network endpoints your application will use. As a security feature, if an application tries to access an endpoint that isn't declared in the application manifest, the connection attempt fails. The manifest is packaged with the application image, and the Azure Sphere runtime reads it when the image is sideloaded or deployed. To change IoT Central endpoints, update **AllowedConnections**, rebuild and repackage the application, and then sideload or deploy the updated image package.

When connecting to IoT Central, you must declare the global Device Provisioning Service endpoint and all IoT Hub endpoints returned for your IoT Central application. Otherwise, your Azure Sphere application won't be able to complete DPS provisioning or connect to IoT Central.

## Network endpoint capabilities

Network endpoints are declared in the application **app_manifest.json** file in the **AllowedConnections** capability under the **Capabilities** section. If the application uses Azure Sphere device authentication, such as when it authenticates to Azure IoT services with an Azure Sphere device certificate, the same **Capabilities** section must also include **DeviceAuthentication** set to the Azure Sphere (Legacy) tenant UUID associated with your catalog.

```json
{
    "SchemaVersion": 1,
    "Name": "IoTCentralSample",
    "ComponentId": "00000000-0000-0000-0000-000000000000",
    "EntryPoint": "/bin/app",
    "Capabilities": {
        "AllowedConnections": [
            "global.azure-devices-provisioning.net",
            "your-iot-central-network-endpoint.azure-devices.net"
        ],
        "DeviceAuthentication": "00000000-0000-0000-0000-000000000000"
    }
}
```

Replace the IoT Central network endpoint with your application's endpoints and replace the **DeviceAuthentication** value with the Azure Sphere (Legacy) tenant UUID associated with your catalog. With Azure Sphere Integrated, every catalog exposes this tenant UUID through the `properties.tenantId` field of the Azure Sphere Catalog Azure resource. Run the following command to retrieve it. Don't use the Azure Resource Manager catalog resource ID for **DeviceAuthentication**.

```azurecli
az sphere catalog show --resource-group <resource-group-name> --catalog <catalog-name> --query "properties.tenantId" --output tsv
```

> [!NOTE]
> `properties.tenantId` is documented on the [Catalog REST API schema](https://learn.microsoft.com/rest/api/azuresphere/catalogs/get?view=rest-azuresphere-2024-04-01) and is present on every Azure Sphere catalog (both brand-new Integrated catalogs and catalogs that were migrated from Azure Sphere (Legacy)). Catalogs that were migrated from Azure Sphere (Legacy) also store the same value in the `tags.MigratedCatalogId` resource tag for backward compatibility, but querying `properties.tenantId` works for every catalog type.

## Access to hardware

Remember, Azure Sphere applications are secure by default and you must declare access to hardware peripherals your application requires. If you do not declare the hardware your application needs, then attempts to open or use that hardware fail with permission errors. Security access to hardware is enforced with hardware firewalls, which are silicon countermeasures that ensure I/O peripherals are accessible only to the core to which they are assigned. For production devices, Azure Sphere adds defense-in-depth by locking the peripheral configuration during system startup after applications initialize, but only when the device manufacturing state is DeviceComplete and the **appDevelopment** device capability is absent. On development-enabled devices, or devices that are not DeviceComplete, this peripheral configuration locking does not apply. After the configuration is locked, it cannot be revised until the device is rebooted.

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

Azure Sphere hardware is available from multiple vendors, and each vendor may expose features of the underlying chip in different ways. Azure Sphere applications manage hardware dependencies by using hardware definition files. In CMake, the project targets a hardware definition JSON file. In application code, you include the corresponding header file and use its constants in code and in **app_manifest.json**. For further information, review the [Managing target hardware dependencies](/azure-sphere/app-development/manage-hardware-dependencies?azure-portal=true) article.

The labs for this learning module have a set of hardware definition files for the AVNET and SEEED Studio Azure Sphere developer boards. The **azure_sphere_learning_path** hardware definition header is included in **main.c** for each lab.

```c
#include "hw/azure_sphere_learning_path.h"
```

In the following exercise, you will gather the IoT Central endpoint and tenant values. In a later deployment exercise, you will apply those values in **app_manifest.json**.
