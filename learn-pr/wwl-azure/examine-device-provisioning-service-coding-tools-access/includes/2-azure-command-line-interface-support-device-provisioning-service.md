Azure CLI commands can be used to accomplish many of the tasks associated with the Azure IoT Hub Device Provisioning Service.

## Azure CLI commands for DPS

Azure CLI Commands for DPS are available in the following categories:

 -  DPS Service.
 -  Access Policy.
 -  Certificates.
 -  Linked Hub.

The commands available in each of these categories are shown in the tables below.

:::row:::
  :::column:::
    **Service Commands**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps create
  :::column-end:::
  :::column:::
    Create an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps delete
  :::column-end:::
  :::column:::
    Delete an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps list
  :::column-end:::
  :::column:::
    List Azure IoT Hub Device Provisioning Service instances.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps show
  :::column-end:::
  :::column:::
    Get the details of an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps update
  :::column-end:::
  :::column:::
    Update an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::


:::row:::
  :::column:::
    **Access Policy Commands**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps access-policy
  :::column-end:::
  :::column:::
    Manage Azure IoT Hub Device Provisioning Service access policies.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps access-policy create
  :::column-end:::
  :::column:::
    Create a new shared access policy in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps access-policy delete
  :::column-end:::
  :::column:::
    Delete a shared access policies in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps access-policy list
  :::column-end:::
  :::column:::
    List all shared access policies in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps access-policy show
  :::column-end:::
  :::column:::
    Show details of a shared access policy in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps access-policy update
  :::column-end:::
  :::column:::
    Update a shared access policy in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::


:::row:::
  :::column:::
    **Certificate Commands**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate
  :::column-end:::
  :::column:::
    Manage Azure IoT Hub Device Provisioning Service certificates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate create
  :::column-end:::
  :::column:::
    Create/upload an Azure IoT Hub Device Provisioning Service certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate delete
  :::column-end:::
  :::column:::
    Delete an Azure IoT Hub Device Provisioning Service certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate generate-verification-code
  :::column-end:::
  :::column:::
    Generate a verification code for an Azure IoT Hub Device Provisioning Service certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate list
  :::column-end:::
  :::column:::
    List all certificates contained within an Azure IoT Hub device provisioning service.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate show
  :::column-end:::
  :::column:::
    Show information about a particular Azure IoT Hub Device Provisioning Service certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate update
  :::column-end:::
  :::column:::
    Update an Azure IoT Hub Device Provisioning Service certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps certificate verify
  :::column-end:::
  :::column:::
    Verify an Azure IoT Hub Device Provisioning Service certificate.
  :::column-end:::
:::row-end:::


:::row:::
  :::column:::
    **Linked Hub Commands**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps linked-hub
  :::column-end:::
  :::column:::
    Manage Azure IoT Hub Device Provisioning Service linked IoT hubs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps linked-hub create
  :::column-end:::
  :::column:::
    Create a linked IoT hub in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps linked-hub delete
  :::column-end:::
  :::column:::
    Update (delete) a linked IoT hub in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps linked-hub list
  :::column-end:::
  :::column:::
    List all linked IoT hubs in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps linked-hub show
  :::column-end:::
  :::column:::
    Show details of a linked IoT hub in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    az iot dps linked-hub update
  :::column-end:::
  :::column:::
    Update a linked IoT hub in an Azure IoT Hub Device Provisioning Service instance.
  :::column-end:::
:::row-end:::


## Using the DPS service commands

As noted previously, Azure CLI commands can be used to manage DPS at the service level.

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
