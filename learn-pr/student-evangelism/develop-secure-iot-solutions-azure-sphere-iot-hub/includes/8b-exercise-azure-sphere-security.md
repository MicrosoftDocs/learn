In this exercise, we'll secure an Azure Sphere application

## Step 1: List your IoT Hub and DPS network endpoints

Follow these steps:

1. Return to the Azure portal.

1. Your IoT Hub service blade should already be selected, if not, then select your **IoT Hub** resource.

1. Select **Overview** from the IoT Hub sidebar menu.

1. Copy the IoT hub **Hostname** to Notepad.

    :::image type="content" source="../media/iot-hub-endpoint-url.png" alt-text="The illustration shows the overview page of IoT Hub." lightbox="../media/iot-hub-endpoint-url.png":::

1. Select the **Resource group** URL to return to the resource group blade.

1. Select your DPS resource.

1. Select **Overview** from the Device Provisioning Service sidebar menu.

1. From the DPS **Overview** blade, copy the following values to a temporary text file:

    - **Global device endpoint** (always `global.azure-devices-provisioning.net`).
    - **ID Scope** of your DPS instance. The application uses the ID Scope at run time to identify the DPS instance; it is not an `AllowedConnections` value.

    :::image type="content" source="../media/dps-overview.png" alt-text="The illustration shows the overview page of device provisioning service." lightbox="../media/dps-overview.png":::

1. From the DPS sidebar menu, under **Settings**, select **Linked IoT hubs**. Note the IoT hub name(s) linked to this DPS instance and copy each hostname in the format `<your-iot-hub>.azure-devices.net`. If you linked only one IoT hub during deployment, this is the IoT Hub **Hostname** you copied earlier.

    > [!NOTE]
    > Azure Sphere applications connect through the global device endpoint, so you do not need the DPS *Service endpoint* (`<dpsName>.azure-devices-provisioning.net`) for the device's `AllowedConnections` capability.

## Step 2: Get the Azure Sphere (Legacy) tenant UUID for DeviceAuthentication

Azure Sphere DPS enrollment groups trust the Azure Sphere catalog/tenant CA certificate that you uploaded and verified in DPS — not a catalog, tenant, or subscription identifier. During provisioning, DPS attests the device's per-device certificate against that verified CA certificate. However, Azure Sphere applications must still declare the Azure Sphere (Legacy) tenant UUID in the `DeviceAuthentication` capability of `app_manifest.json` so that the OS will allow the application to connect using the device's per-device certificate.

1. If you use the **Azure Sphere Integrated** CLI (the current `az sphere` CLI), retrieve the Azure Sphere (Legacy) tenant UUID from the catalog's `tags.MigratedCatalogId` value after you run `az login` and select the subscription that contains your Azure Sphere catalog. Replace the resource group and catalog names with your values, or omit them if you configured Azure CLI defaults.

   ```
   az sphere catalog show --resource-group <rg> --catalog <name> --query "tags.MigratedCatalogId" -o tsv
   ```

   Copy the returned UUID to your temporary text file. Use this UUID for the `DeviceAuthentication` capability; don't use the catalog name, Azure resource ID, Microsoft Entra tenant ID, Azure subscription ID, IoT Hub hostname, DPS name, or DPS ID Scope.

1. If you use the **legacy** CLI (`azsphere`, still available), retrieve the tenant UUID with the following command.

   ```
   azsphere tenant show-selected
   ```

   The output of this command will look similar to the following.

    ```
    ------------------------------------ -------------------
    Id                                   Name
    ========================================================
    99999999-e021-43ce-9999-fa9999499994 yourSphereTenant
    ------------------------------------ -------------------
    ```

   Copy the value of the `Id` field to your temporary text file, as you'll need it soon.
