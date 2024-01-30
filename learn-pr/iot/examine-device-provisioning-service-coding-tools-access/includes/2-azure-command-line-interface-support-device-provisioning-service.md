Azure CLI commands can be used to accomplish many of the tasks associated with the Azure IoT Hub Device Provisioning Service (DPS).

## Azure IoT extension for Azure CLI

To use Azure CLI commands, you must first install the Azure IoT extension for Azure CLI using the following command:

```azurecli
az extension add --name azure-iot
```

## Azure CLI commands for DPS

### DPS service commands

You can use DPS service commands to manage Device Provisioning Service instances. The DPS service commands are listed as follows:

| Command | Description |
| --- | --- |
| [az iot dps create](/cli/azure/iot/dps?view=azure-cli-latest#az-iot-dps-create&preserve-view=true) | Create an Azure IoT Hub Device Provisioning Service instance. |
| [az iot dps delete](/cli/azure/iot/dps?view=azure-cli-latest#az-iot-dps-delete&preserve-view=true) | Delete an Azure IoT Hub Device Provisioning Service instance. |
| [az iot dps list](/cli/azure/iot/dps?view=azure-cli-latest#az-iot-dps-list&preserve-view=true) | List Azure IoT Hub Device Provisioning Service instances. |
| [az iot dps show](/cli/azure/iot/dps?view=azure-cli-latest#az-iot-dps-show&preserve-view=true) | Get the details of an Azure IoT Hub Device Provisioning Service instance. |
| [az iot dps update](/cli/azure/iot/dps?view=azure-cli-latest#az-iot-dps-update&preserve-view=true) | Update an Azure IoT Hub Device Provisioning Service instance. |

### Other DPS command categories

Other Azure CLI Commands for DPS are available in the following categories:

| Category | Description |
| --- | --- |
| [certificate](/cli/azure/iot/dps/certificate?view=azure-cli-latest&preserve-view=true) | Manage certificates for an Azure IoT Hub Device Provisioning Service instance. |
| [connection-string](/cli/azure/iot/dps/connection-string?view=azure-cli-latest&preserve-view=true) | Manage connection strings for an Azure IoT Hub Device Provisioning Service instance. |
| [enrollment](/cli/azure/iot/dps/enrollment?view=azure-cli-latest&preserve-view=true) | Manage individual device enrollments in an Azure IoT Hub Device Provisioning Service. |
| [enrollment-group](/cli/azure/iot/dps/enrollment-group?view=azure-cli-latest&preserve-view=true) | Manage enrollment groups in an Azure IoT Hub Device Provisioning Service. |
| [linked-hub](/cli/azure/iot/dps/linked-hub?view=azure-cli-latest&preserve-view=true) | Manage linked IoT Hubs in an Azure IoT Hub Device Provisioning Service instance. |
| [policy](/cli/azure/iot/dps/policy?view=azure-cli-latest&preserve-view=true) | Manage shared access policies for an Azure IoT Hub Device Provisioning Service instance. |

## Using the DPS commands

DPS commands have required and optional parameters. The create and delete DPS service commands are listed as examples.

> [!NOTE]
> To view usage information for any Azure CLI command, enter the command followed by \`--help\`

### Create command

The `az iot dps create` command can be used to create an Azure IoT Hub device provisioning service.

This command takes the following arguments:

:::row:::
  :::column:::
    **command arguments**
  :::column-end:::
  :::column:::
    **description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--name
  :::column-end:::
  :::column:::
    IoT Provisioning Service name.
\--name is a required argument.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--resource-group
  :::column-end:::
  :::column:::
    Name of resource group.
\--resource-group is a required argument.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--location
  :::column-end:::
  :::column:::
    Location of your IoT Provisioning Service. Default is the location of target resource group.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--sku
  :::column-end:::
  :::column:::
    Pricing tier for the IoT provisioning service. Allowed values: S1. Default: S1.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--unit
  :::column-end:::
  :::column:::
    Units in your IoT Provisioning Service. Default: 1.
  :::column-end:::
:::row-end:::

For example, the following command can be used to create an Azure IoT Hub device provisioning service with the standard pricing tier S1, in the region of the resource group:

`az iot dps create --name MyDps --resource-group MyResourceGroup`

Or, to create an Azure IoT Hub device provisioning service with the standard pricing tier S1, in the 'eastus' region, use the following command:

`az iot dps create --name MyDps --resource-group MyResourceGroup --location eastus`

### Delete command

The `az iot dps delete` command can be used to delete an Azure IoT Hub device provisioning service.

This command takes the following arguments:

:::row:::
  :::column:::
    **command arguments**
  :::column-end:::
  :::column:::
    **description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--ids
  :::column-end:::
  :::column:::
    One or more resource IDs (space-delimited). If provided, no other 'Resource ID' arguments should be specified.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--name
  :::column-end:::
  :::column:::
    IoT Provisioning Service name.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    \--resource-group
  :::column-end:::
  :::column:::
    Name of resource group.
  :::column-end:::
:::row-end:::

For example, the following command can be used to delete an Azure IoT Hub device provisioning service named 'MyDps':

`az iot dps delete --name MyDps --resource-group MyResourceGroup`
