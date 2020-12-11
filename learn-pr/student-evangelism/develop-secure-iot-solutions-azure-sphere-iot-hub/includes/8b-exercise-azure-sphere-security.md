In this exercise, we'll secure an Azure Sphere application

## Step 1: List your IoT Hub and DPS network endpoints

Follow these steps:

1. Return to the Azure portal.

2. Select **Overview** from the Device Provisioning Service sidebar menu.

3. Copy the device provisioning service **Service endpoint** URI to Notepad.

4. Copy the device provisioning service **Global device endpoint** URI to Notepad.

5. Copy the **ID Scope** to Notepad.

6. Click the **Resource group URL** to return to the resource group.

    :::image type="content" source="../media/dps-overview.png" alt-text="The illustration shows the overview page of device provisioning service.":::

7. Select the **IoT Hub** resource.

8. Copy the IoT hub **Hostname** URL to Notepad.

    :::image type="content" source="../media/iot-hub-endpoint-url.png" alt-text="The illustration shows the overview page of IoT Hub.":::

## Step 2: Get your Azure Sphere tenant ID

We need the Azure Sphere Tenant ID that is now trusted by DPS.

1. From the  Windows **PowerShell command line** or Linux **Terminal**, run the following command.

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

2. Copy the Azure Sphere tenant ID to Notepad, as you'll need it soon.
