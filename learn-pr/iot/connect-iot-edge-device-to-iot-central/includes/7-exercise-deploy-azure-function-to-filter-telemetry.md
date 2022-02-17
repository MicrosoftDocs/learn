Filter the telemetry sent by the device.

To reduce the amount of telemetry sent to your IoT Central application, you want to filter the data on the IoT Edge device.

In this unit, you'll use Azure Functions running on the IoT Edge device to implement a filter. The filter ensures that the device only sends telemetry when the ambient temperature is above 21&deg;C.

## Configure a container registry

Your IoT Edge device will need to download and install the custom Azure Functions module that implements the filter. IoT Edge modules are packaged as Docker-compatible images that you can store in a container repository. You decide to use the Azure Container Registry (ACR) to store your new module. You'll also use ACR to build the container from a source project.

Run the following commands to add a container registry to your resource group in Azure:

```azurecli
REGISTRY_NAME="edgeCentral$RANDOM"
az acr create -n $REGISTRY_NAME -g <rgn>[sandbox resource group name]</rgn> --sku Standard --admin-enabled true
az acr credential show -n $REGISTRY_NAME
echo "Your registry name is: $REGISTRY_NAME"
```

Make a note of the registry name and `password` values, you use them later in this unit.

## Create an Azure Functions project

You're using C# to implement the function. Run the following commands to install the project template and then generate a skeleton project:

```azurecli
dotnet new -i Microsoft.Azure.IoT.Edge.Function
dotnet new aziotedgefunction -n FilterFunction -r $REGISTRY_NAME.azurecr.io/filterfunction
cd FilterFunction
ls
```

Run the following command to replace the existing _FilterFunction.cs_ with an implementation that filters the machine temperature telemetry:

```azurecli
curl -O https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/master/edge-vm-deploy/FilterFunction.cs
```

Now build the image and upload it to your container registry. Expect this command to take a couple of minutes to run:

```azurecli
az acr build --registry $REGISTRY_NAME --image filterfunction:v1 -f Dockerfile.amd64 .
```

You can list the images in your registry with the following command:

```azurecli
az acr repository list --name $REGISTRY_NAME
```

## Update the device template to use the new module

To use the new filter module on your IoT Edge device, update the deployment manifest associated with the device template and add a new interface to the device template. You'll also need to version the device template and migrate your device to use the new template.

Download the new deployment manifest and interface definition to your local machine by right-clicking on the following links and choosing **Save as**:

- [EnvironmentalSensorManifestFilter.json](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/master/edge-vm-deploy/EnvironmentalSensorManifestFilter.json)
- [TelemetryInterfaceFilter.json](https://raw.githubusercontent.com/Azure-Samples/iot-central-docs-samples/master/edge-vm-deploy/TelemetryInterfaceFilter.json)

Open the _EnvironmentalSensorManifestFilter.json_ in a text editor and update it to use the filter module from your container registry:

1. Replace the three instances of `<YOUR CONTAINER REGISTRY NAME>` with the name of your container registry. The name looks like `edgecentral27912`.
1. Replace `<YOUR CONTAINER REGISTRY PASSWORD>` with the password you made a note of previously in this unit.
1. Save the changes.

This version of the deployment manifest:

- Adds the module with the Azure function you created:

    ```json
    "filterfunction": {
        "settings": {
            "image": "{your container registry}.azurecr.io/filterfunction:v1",
            "createOptions": ""
        },
        "type": "docker",
        "status": "running",
        "restartPolicy": "always",
        "version": "1.0"
    }
    ```

- Routes the output from the **SimulatedTemperatureSensor** module to the **filterfunction** module before sending the filtered telemetry to your IoT Central application:

    ```json
    "routes": {
        "FilterFunctionToIoTCentral": "FROM /messages/modules/filterfunction/outputs/* INTO $upstream",
        "sensorToFilterFunction": "FROM /messages/modules/SimulatedTemperatureSensor/outputs/temperatureOutput INTO BrokeredEndpoint(\"/modules/filterfunction/inputs/input1\")"
    },
    ```

Before you can upload the new version of the manifest to the device template, you need to create a new version of the template:

1. Navigate to the **Device templates** page in the IoT Central application.
1. Select the **Environmental Sensor Edge Device** device template.
1. Select **Version**. Then select **Create** to accept the new template name.
1. Select **Edit manifest**, then select **replace it with a new file**, Then select the *EnvironmentalSensorManifestFilter.json* file you edited previously.
1. When the manifest is validated, select **Save** to replace the deployment manifest with the new version.

The new module in the deployment manifest requires a new module definition in the device template. IoT Central doesn't add the module definition automatically when you replace the deployment manifest:

1. On the **Environmental Sensor Edge Device v2** device template, select **Modules**, then select **+ Add module**, and then select **Custom**. A new module called **Environmental Sensor Edge Device v2** is added to your device template.
1. Select **Edit identity** and change both the **Relationship name** and **Name** to *filterfunction*. Change the **Display name** to *Module FilterFunction*. Select **Save**.

    :::image type="content" source="../media/7-module-filterfunction.png" alt-text="Screenshot that shows the FilterFunction module added to the device template.":::

The new module now sends the telemetry to IoT Central. Next, add an interface to the new filter module that specifies the telemetry and update the chart:

1. Select **Module FilterFunction**, then **+ Add inherited interface**.
1. Choose the **Import interface** tile. Select the **TelemetryInterfaceFilter.json** file you downloaded previously.
1. Select **Save** to save your changes.

You can remove the original **Telemetry** interface because the **SimulatedTemperatureModule** no longer sends telemetry directly to IoT Central. The output from this module is routed to the **FilterFunction** module by the IoT Edge runtime:

1. Select the **Telemetry** interface in the **SimulatedTemperatureSensor** module.
1. Select **Delete** and then confirm the operation.

Modify the **View IoT Edge device telemetry** view to display the telemetry sent by the **FilterFunction** module:

1. In the device template, select the **View IoT Edge device telemetry** view, and then select the **Edit** option on the chart tile.
1. Add the **ambient/temperature**, **humidity**, **machine/temperature**, and **pressure** telemetry values.
1. Select **Update** and then **Save** to save your changes.
1. Select **Publish** to publish the new version of the device template.

## Deploy the new module to your device

To send the updated deployment manifest to the device:

1. Navigate to the **Devices** page in the IoT Central application.
1. Select the **store-001** device.
1. Select **Migrate**, in the **Migrate** dialog select **Environmental Sensor Edge Device v2**. Then select **Migrate**.

    :::image type="content" source="../media/7-migrate-device.png" alt-text="Screenshot that shows the migrate device dialog.":::

After a few seconds, the device is migrated to the new template version. The device now uses the new **FilterFunction** module and routes.

To verify that the deployment of the new module was successful:

1. On the **Devices** page, click on the **store-001** device.
1. Select the **Modules** view. There are now four modules running on the device, including the new **filterfunction** module. You may need to wait for several minutes until the new module starts running.

    :::image type="content" source="../media/7-filterfunction-running.png" alt-text="Screenshot that shows the FilterFunction module running on the IoT Edge device.":::

1. Select the **View IoT Edge device telemetry** view.
1. You can see the filtered telemetry on the chart. There are no values shown with an average ambient temperature of less than 21.0 degrees.

    :::image type="content" source="../media/7-telemetry-view.png" alt-text="Screenshot that shows telemetry plot with no average ambient temperature values less than 21.":::

If the device appears to stop sending telemetry, it's likely to be because the **SimulatedTemperatureSensor** module stops sending telemetry after sending 500 messages. If you restart the VM, the count resets and you see telemetry start to flow again:

```azurecli
az vm restart --resource-group <rgn>[sandbox resource group name]</rgn> \
  --name $(az vm list --resource-group <rgn>[sandbox resource group name]</rgn> --query [0].name -o tsv)
```
