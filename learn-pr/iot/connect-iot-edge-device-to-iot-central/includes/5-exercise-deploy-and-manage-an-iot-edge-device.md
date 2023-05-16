Deploy the IoT Edge runtime to a Linux VM and manage your IoT Edge device from IoT Central.

Recall that to test the solution before deploying it to your stores, you'll run the IoT Edge modules on a Linux Virtual Machine (VM) in the cloud.

Here, you'll deploy the IoT Edge runtime to a Linux VM to test the behavior of your modules with your IoT Central application.

## Configure and deploy the IoT Edge device

In the previous module, you learned that an IoT Edge device needs the connection information from the IoT Central application. Set the following environment variables in your Cloud Shell sandbox:

1. Generate a strong password to connect to your virtual machine. Your password must be at least 12 characters long and have three of four of the following: lowercase characters, uppercase characters, digits, and special characters. You will use the command `openssl rand --base64 15` to generate a series of random characters that are suitable for a password:

    ```azurecli
    VM_PASSWORD=$(openssl rand --base64 15)
    echo "Your VM password is: $VM_PASSWORD"
    ```
    
    Make a note of the password just in case the shell times out and loses the environment variable.

1. Replace `<IOT_CENTRAL_APP_SCOPE_ID>` with the scope ID you made a note of in the previous exercise:

    ```azurecli
    SCOPE_ID="<IOT_CENTRAL_APP_SCOPE_ID>"
    ```

1. Replace `<IOT_CENTRAL_DEVICE_KEY>` with the device primary key you made a note of in the previous exercise:

    ```azurecli
    DEVICE_KEY="<IOT_CENTRAL_DEVICE_KEY>"
    ```

The following command creates a Linux VM, installs the IoT Edge runtime, and edits the configuration file. By default, an IoT Edge installation connects directly to an IoT hub. The edits to the configuration file ensure that the IoT Edge device uses the Device Provisioning Service (DPS) to connect to your IoT Central application:

```azurecli
az deployment group create \
  --name edgeModuleVM \
  --resource-group <rgn>[sandbox resource group name]</rgn> \
  --template-uri https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/main/edge-vm-deploy-1-4/edgeModuleVMDeploy.json \
  --parameters dnsLabelPrefix="$APP_NAME" \
  --parameters adminUsername="AzureUser" \
  --parameters adminPassword="$VM_PASSWORD" \
  --parameters scopeId="$SCOPE_ID" \
  --parameters deviceId="store-001" \
  --parameters deviceKey="$DEVICE_KEY"
```

Navigate to the **Environmental Sensor Edge Device** devices on the **Devices** page in your IoT Central application. If you've forgotten the URL, run the following command:

```azurecli
echo "You can now navigate to: https://$APP_NAME.azureiotcentral.com/devices"
```

The **Device status** changes from **Registered** to **Provisioned** when the IoT Edge device connects.

:::image type="content" source="../media/5-device-provisioned.png" alt-text="Screenshot of device list that shows provisioned device.":::

> [!TIP]
> Expect to wait for several minutes for the status to change to **Provisioned**.

Wait until the **Device status** is **Provisioned**, then click on the device name **store-001**. You can see the available views for the device, including **Modules**. Select the **Modules** view. The status of the three modules changes to **Running** when the IoT Central application detects the modules are running. You may need to wait a couple of minutes for the status to update.

:::image type="content" source="../media/5-running-modules.png" alt-text="Screenshot that shows three running modules on the IoT Edge device.":::

## Monitor the telemetry

To view the telemetry coming from the IoT Edge device, select **View IoT Edge device telemetry**. This view is the one you created previously. After a few minutes, you'll see the telemetry on the  line chart.

:::image type="content" source="../media/5-telemetry-plot.png" alt-text="Screenshot that shows telemetry plot from IoT Edge module - includes ambient temperature values less than 21.":::

> [!NOTE]
> The IoT Edge module is sending some ambient temperature values less than 21&deg;. In the next unit you'll learn how to filter these low values out at the edge.

## Check your work

You now have an IoT Edge device running in an Azure VM, connected to your IoT Central application using DPS, and sending telemetry.

You can also:

- View the raw data coming from the IoT Edge device on the **Raw data** page.
- Edit the cloud properties you defined on the **Store information** page.
- Edit the devices writable properties - **Send Data** and **Send Interval** - on the **Manage** page. IoT Central creates this page automatically for IoT Edge devices.