In this unit, you'll create and configure an instance of Azure IoT Hub.  IoT Hub is used to receive telemetry from IoT Devices.  A node.js application will be used to simulate machines in a chocolate factory (IoT Devices).

## Create an IoT hub

Use the Azure CLI to create a resource group and then add an IoT hub. Use the resource group that was created for use by Azure Digital Twins and Azure Functions.

1. Run the following [command to create an IoT hub](https://docs.microsoft.com/cli/azure/iot/hub#az-iot-hub-create) in your resource group. Use a globally unique name for your IoT hub.

   ```azurecli-interactive
   az iot hub create --name $dtname --resource-group $rgname --sku S1
   ```

1. In the active PowerShell window, create a device in IoT Hub by using this command:

    ```azurecli
    az iot hub device-identity create --device-id GrindingStep --hub-name $dtname -g $rgname
    ```

You'll see the output information of the device that was created.

## Configure and run the simulation

Next, configure the device simulator to send data to your IoT Hub instance.

1. Get the device connection string by using this command:

    ```azurecli
    az iot hub device-identity connection-string show --device-id GrindingStep --hub-name $dtname
    ```

1. Open the file ~\digital-twins-samples\HandsOnLab\SimulatedClient\Sensor.js.
1. Find the line `const deviceConnectionString = ""` and update it by supplying the device connection string you created earlier.

      :::image type="content" source= "../media/update-device-key.png" alt-text="Partial screenshot of a code listing, showing the line in which to specify the device connection string.":::

1. Save and close the file.
1. In the PowerShell window, go to the SimulatedClient folder in the repo and run the simulated client:

    ```Azure CLI
    cd ~\digital-twins-samples\handsonlab\SimulatedClient
    npm install
    node ./Sensor.js
    ```

## Configure Event Grid on your IoT hub

In this section, you configure your IoT hub to publish events as they occur.

1. In the Azure portal, go to your IoT hub:
    1. Select **Resource groups**.
    1. Select the resource group for this module.
    1. Select your IoT hub from the list of resources.

1. Select **Events**.
1. Select **Event subscription**.

    :::image type="content" source= "../media/add-event-subscription.png" alt-text="Partial screenshot of the Events pane for IoT Hub, for creating a new event subscription.":::

1. In the **EVENT SUBSCRIPTION DETAILS** section:
    1. Provide a **name** for the event subscription: **twinevents**.
    1. Select **Event Grid Schema** for **Event Schema**.
1. In the **TOPIC DETAILS** section:
    1. Confirm that the **Topic type** is set to **IoT Hub**.
    1. Confirm that the name of the IoT hub is set as the value for the **Source Resource** field.
    1. For the **system topic**, enter **twin topic**.
1. In the **EVENT TYPES** section:
    1. Select the **Filter to Event Types** drop-down list.
    1. Select only the **Device Telemetry** check box. Clear the check boxes for all other list items.

        :::image type="content" source= "../media/event-types.png" alt-text="Partial screenshot showing the Filter to Event Types list box, with Device Telemetry as the only subscription event type selected.":::

1. In the **ENDPOINT DETAILS** section:
   1. Select **Endpoint Type** as **Azure Function**.
   1. Choose **Select an endpoint**, paste the URL that you copied from your logic app, and then select **Confirm Selection**.

      :::image type="content" source= "../media/select-azure-function.png" alt-text="Partial screenshot showing the Select Azure Function dialog box, with the Confirm Selection button highlighted.":::

1. Select **Create**

    At this point, you should see messages in the Azure Functions log stream that you configured in the preceding unit. The Azure Functions log stream shows the telemetry being received from Event Grid. It also shows any errors that occur when connecting to Azure Digital Twins or updating the twin.

    :::image type="content" source= "../media/log-stream.png" alt-text="Partial screenshot of console window showing the log stream.":::

## Verify that the twin is updated

To see the values being updated in the twin GrindingStep, run this command:

```azurecli
az dt twin show -n $dtname --twin-id GrindingStep
```
The values shown for ChasisTemperature should match the values being sent by the devices simulator.
