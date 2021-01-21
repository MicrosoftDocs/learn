To complete the following exercise units, you need to have an Azure Digital Twins instance set up for the chocolate factory production line. The instance needs to have been updated several times through a connection to an IoT source of data. The data source streams sensor and actuator data connected to the factory assets to closely monitor the underlying processes and operations.

This pattern relies on the twin updates rather than forwarding telemetry from an IoT device. This setup gives you the flexibility to change the underlying data source without needing to update your Time Series Insights logic.

To continue, choose one of these options:

- If you've been following the **Develop with Azure Digital Twins** learning path modules in sequence, have successfully completed all exercises in [Module 3: Ingest data into Azure Digital Twins](https://docs.microsoft.com/en-us/learn/modules/develop-with-azure-digital-twins/ingest-data-into-azure-digital-twins/), and have kept the solution resources in your Azure subscription, skip to [Create a route and filter for twin update notifications](https://docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/route-output-from-azure-digital-twins-to-downstream-services/4-exercise-create-route-filter-twin-update-notifications).

- If you haven't completed the previous modules and you still want to proceed with the exercises in this module, continue with the following steps.

## Deploy an ARM template

This step is required to re-provision the resources created in [Module 3: Ingest data into Azure Digital Twins](https://docs.microsoft.com/en-us/learn/modules/develop-with-azure-digital-twins/ingest-data-into-azure-digital-twins/).

1. Select **Deploy to Azure**: 

   [![homepage](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fdigital-twins-samples%2Fmaster%2FHandsOnLab%2Fdeployment%2FMSLearnModule3%2Fadt-hol-pt1-arm-template.json "Deploy template")
1. Complete these custom-deployment template steps to start the deployment:
    - Select the **Subscription** in which you want to deploy the resources.
    - Create a **Resource group** and give it a unique name.
    - Select a **Region**, ideally the one closest to your location.
    - Leave the default values in the **Location** and **Utc Value** boxes.
    - Run the following command in PowerShell. (Don't forget to replace `id` with your Azure subscription ID.) Paste the output into the **Userid** box.

        ```powershell
        az ad user show --id jdoe@contoso.com --query objectId -o tsv
        ```

    :::image type="content" source="../media/custom-template-deployment.png" alt-text="Screenshot of the Custom deployment page.":::

1. The deployment will take a few minutes to complete. When it's done, select **Outputs** in the left pane. Copy the result and paste it into Notepad.

    :::image type="content" source="../media/custom-template-deployment-complete.png" alt-text="Screenshot that shows the Outputs option.":::

1. Format the output into a list of variables, as you see in this example:

    ```powershell
    $random = 'a2gtf4b'
    $rgname = 'ChocolateFactoryRG'
    $location = 'westus2'
    $dtname = 'a2gtf4bdigtwins'
    $functionstorage = 'a2gtf4bstorage'
    $telemetryfunctionname = 'a2gtf4b-telemetryfunction'
    $twinupdatefunctionname = 'a2gtf4b-twinupdatefunction'
    $username = 'replaceme@contoso.com'
    ```

1. In PowerShell, sign in to Azure and set your Azure subscription by using these commands:

    ```powershell
    az login
    
    az account set --subscription "<your-Azure-subscription-ID>"
    ```

1. Copy the list of variables you had in Notepad and run them in PowerShell to continue working locally in the next exercises.

You now have an Azure digital twin of a factory production line! You can view your digital twin by using a sample application like [Azure Digital Twins Explorer](https://docs.microsoft.com/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/). Azure Digital Twins Explorer also provides capabilities like uploading models, creating twins, creating relationships, and updating twin properties.

:::image type="content" source="../media/azure-digital-twins-explorer.png" alt-text="Screenshot that shows Azure Digital Twins Explorer.":::

You've also provisioned the IoT hub and an Azure function that's connected, and configured ingestion of telemetry from the IoT hub.

## Create a device and send data from a simulated local client

1. In the Azure portal, go to the resource group you created for these exercises. Select your IoT hub and then go to **IoT devices**:

    :::image type="content" source="../media/azure-iot-hub-devices.png" alt-text="Screenshot that shows IoT hub devices in the Azure portal.":::

1. At the top of the IoT devices page, select **New**  to create a device. Customize the device by completing these steps:
    - In the **Device ID** box, enter **GrindingStep**.
    - In **Authentication type**, keep the default value: **Symmetric Key**.
    - Keep the other default values and select **Save**.
    - Under **IoT devices**, select the new device. 
    - Copy the **Primary Connection String** and save it. You'll need it in one of the following steps.

    :::image type="content" source="../media/iot-device-connection-string.png" alt-text="Getting the connection string for an IoT device in the Azure portal":::

1. On your local computer, create a directory and clone the Digital Twins Samples GitHub repo by pasting the following code into PowerShell. (Replace `username` with a valid directory.)

    ```powershell
    mkdir c:\users\username\repos
    cd c:\users\username\repos
    git clone https://github.com/Azure-Samples/digital-twins-samples/ 
    ```

1. From your cloned repo, open the file ~\digital-twins-samples\HandsOnLab\SimulatedClient\Sensor.js in a text editor.

1. Find the line `const deviceConnectionString = ""`. Update it with the device connection string that you saved earlier:

    ```javascript
    // String containing host name, device ID, and device key in the following formats:
    // "HostName=<iothub_host_name>;DeviceId=<device_id>;SharedAccessKey=<device_key>"
    const deviceConnectionString = "";
    let sendInterval;
    ```

    > [!NOTE]
    > If you don't have the device connection string, you can retrieve it by running this command: `az iot hub device-identity connection-string show -d GrindingStep --hub-name $dtname -o tsv`

1. Save and close the file.

1. In PowerShell, go to the SimulatedClient folder in the cloned repo and run the simulated client:

    ```powershell
    cd C:\Users\username\repos\digital-twins-samples\handsonlab\SimulatedClient
    npm install
    node ./Sensor.js
    ```

1. The simulated device should start sending data. Let the script run for a couple minutes, and then select **Ctrl+C** to break the operation. The output from SimulatedClient should look similar to this example:

    ```powershell
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":11.239450994067955,"Force":304.7945237204837,"ChasisTemperature":205.1585276634945,"
    PowerUsage":79.86458827835732,"Vibration":104.75852762708509,"RoastingTime":113}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":11.65510471920836,"Force":302.38775444252246,"ChasisTemperature":203.1265937510678,"PowerUsage":79.31430532474408,"Vibration":103.39104882273048,"RoastingTime":122}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":10.95830327417518,"Force":302.8335929383297,"ChasisTemperature":205.2672902796224,"PowerUsage":75.34132599704334,"Vibration":104.91422689939382,"RoastingTime":58}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":10.376991639726047,"Force":302.94183564405273,"ChasisTemperature":205.20923237934085,"PowerUsage":66.56459280744645,"Vibration":100.16056682070258,"RoastingTime":37}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":13.164550669553883,"Force":302.7405984216997,"ChasisTemperature":203.8705250372148,"PowerUsage":73.79862331833012,"Vibration":107.92820366760179,"RoastingTime":116}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":10.861356284347368,"Force":303.3070308598643,"ChasisTemperature":208.20771721887766,"PowerUsage":60.920791467329295,"Vibration":101.78865706179853,"RoastingTime":109}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":13.77014040354804,"Force":307.89601176016896,"ChasisTemperature":203.50575731162425,"PowerUsage":63.62677222680977,"Vibration":103.98644066931159,"RoastingTime":125}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":10.515498957178437,"Force":306.75910466578034,"ChasisTemperature":208.41898204480768,"PowerUsage":70.69945692582367,"Vibration":101.52169537106404,"RoastingTime":90}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":10.594385617492911,"Force":306.44708944963384,"ChasisTemperature":208.4723060060253,"PowerUsage":77.57097749063523,"Vibration":108.92294279811038,"RoastingTime":69}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":10.263063690568453,"Force":302.0236254855938,"ChasisTemperature":202.333910831971,"PowerUsage":62.46525813736985,"Vibration":104.57814316148986,"RoastingTime":39}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":12.003716989189329,"Force":305.3785935443024,"ChasisTemperature":205.23629203264616,"PowerUsage":70.38400771889943,"Vibration":104.52301883415295,"RoastingTime":87}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":13.358670608303564,"Force":307.43042681562963,"ChasisTemperature":202.00118000995732,"PowerUsage":65.42448670254498,"Vibration":105.66177787752787,"RoastingTime":112}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":11.595552013759182,"Force":304.75841727215595,"ChasisTemperature":200.82303601954064,"PowerUsage":76.63886703515739,"Vibration":102.35952875749464,"RoastingTime":91}
    send status: MessageEnqueued
    Sending message: {"DeviceType":"GrindingSensor","FanSpeed":13.03570939908017,"Force":304.0808514782594,"ChasisTemperature":202.19873238322907,"PowerUsage":60.45025110024883,"Vibration":100.6077473972765,"RoastingTime":100}
    send status: MessageEnqueued
    ```

1. Confirm that Azure Digital Twins is receiving data by looking at the values being updated in the twin GrindingSensor by running the following command:

    ```powershell
    az dt twin show -n $dtname --twin-id GrindingStep
    ```

## Challenge: Simulate the fanning, roasting, and molding devices

You can edit the Sensor.js script so that it sends data as other devices. The Azure function has logic that evaluates the device type specified in the payload. Change the values stored in `deviceType` and `deviceConnectionString` to send data as fanning and molding sensors:

:::image type="content" source="../media/sensor-type.png" alt-text="Screenshot that shows the script value to change to simulate sending data as a different sensor type.":::

```javascript
// String containing host name, device ID, device key in the following formats:
// "HostName=<iothub_host_name>;DeviceId=<device_id>;SharedAccessKey=<device_key>"
const deviceConnectionString = "";
let sendInterval;
```

> [!NOTE]
> Remember that the Azure function expects the `--device-id` to match the `--twin-id` that's created when a twin is initialized.
