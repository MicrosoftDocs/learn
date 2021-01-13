The following exercise units require that you have an Azure Digital Twins instance set up for the Chocolate Factory Production Line. The instance should have already been updated several times through a connection to an IoT source of data, which streams sensor and actuator data connected to the factory assets to closely monitor the underlying processes and operations.

This pattern relies on the twin updates, rather than forwarding telemetry from an IoT device. This set up gives you the flexibility to change the underlying data source without needing to update your Time Series Insights logic.

To proceed, choose one of the following options:

- If you have been following the "Develop with Azure Digital Twins" Learning Path modules in sequence, have successfully completed all exercises in [Module 3: Ingest Data into Azure Digital Twins](https://review.docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/ingest-data-into-azure-digital-twins/1-introduction?branch=pr-en-us-13689), and retained the solution resources in your Azure Subscription, skip to [**Create a route and filter to twin update notifications**](https://docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/route-output-from-azure-digital-twins-to-downstream-services/4-exercise-create-route-filter-twin-update-notifications).

- Otherwise, if you haven't completed the previous modules and would still like to proceed with the exercises in this module, continue with the following steps.

## Deploy an ARM template

This step is required to re-provision the resources created in [Module 3: Ingest Data into Azure Digital Twins](https://review.docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/ingest-data-into-azure-digital-twins/1-introduction?branch=pr-en-us-13689).

[![homepage](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure-Samples%2Fdigital-twins-samples%2Fmaster%2FHandsOnLab%2Fdeployment%2FMSLearnModule3%2Fadt-hol-pt1-arm-template.json "Deploy template")

1. Click "Deploy to Azure" and complete the following custom deployment template steps to start the deployment:
    - Select the subscription where you'd like to deploy the resources to
    - Create a new resource group and give it a unique name
    - Select a **Region**, ideally nearest to your location
    - Leave **Location** and **Utc Value** as defaults
    - Run the following command in PowerShell (do not forget to replace ID with your Azure Subscription ID) and paste the output in the **Userid** field:

        ```powershell
        az ad user show --id jdoe@contoso.com --query objectId -o tsv
        ```

    :::image type="content" source="../media/custom-template-deployment.png" alt-text="Customizing the ARM template deployment":::

1. Now the deployment is underway, wait a few minutes until the deployment is complete.

1. The deployment will take a few minutes to complete. When it's done, click **Outputs** from the left-side bar, and copy and paste the result in Notepad.

    :::image type="content" source="../media/custom-template-deployment-complete.png" alt-text="Navigating to the output of an ARM template deployment after it completed deploying":::

1. Format the output into a list of variables like the following example:

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

1. In PowerShell, login and set your Azure Subscription using the following commands:

    ```powershell
    az login
    
    az account set --subscription "<your-Azure-subscription-ID>"
    ```

1. Copy and paste the list of variables you had in Notepad and run these variables in PowerShell in order to continue working locally on the next exercises.

1. Now you have an Azure Digital Twin of a factory production line! You can view your Digital Twin using a sample application like [Azure Digital Twins Explorer](https://docs.microsoft.com/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/). Azure Digital Twins Explorer also provides more twin capabilities like uploading models, creating twins, relationships, and updating twin properties.

:::image type="content" source="../media/azure-digital-twins-explorer.png" alt-text="A screenshot showing the Azure Digital Twins explorer user interface":::

Additionally, you have provisioned the IoT Hub and an Azure function that is connected and configured to ingest telemetry from the IoT Hub.

## Create a device and send data from a simulated local client

1. In Azure portal, go to the resource group you created for these exercises. Select your IoT Hub and navigate to IoT devices.

    :::image type="content" source="../media/azure-iot-hub-devices.png" alt-text="Opening the IoT Hub devices in the Azure portal":::

1. In the IoT devices page, click **New** at the top to create a new device and refer to the following steps to customize the device:
    - In **Device ID**, provide the name "GrindingStep"
    - Leave **Authentication type** as "Symmetric Key"
    - Leave all other values as defaults and click **Save**
    - Click the new device listed under **IoT devices**
    - Copy the **connection string** and save it, as it will be needed in the next steps

    :::image type="content" source="../media/iot-device-connection-string.png" alt-text="Getting the connection string for an IoT device in the Azure portal":::

1. On your local machine, create a directory and clone the **Digital Twins Samples** GitHub repo by pasting the following code lines in PowerShell and replacing "username" with a valid directory:

    ```powershell
    mkdir c:\users\username\repos
    cd c:\users\username\repos
    git clone https://github.com/Azure-Samples/digital-twins-samples/ 
    ```

1. From your cloned repo, open the file "~\digital-twins-samples\HandsOnLab\SimulatedClient\Sensor.js" in a text editor.

1. Find the line `const deviceConnectionString = ""` and update it with the device connection saved earlier from deploying the script in the previous section.

    ```javascript
    // String containing Hostname, Device Id & Device Key in the following formats:
    // "HostName=<iothub_host_name>;DeviceId=<device_id>;SharedAccessKey=<device_key>"
    const deviceConnectionString = "";
    let sendInterval;
    ```

    > [!NOTE]
    > If you lost the device connection string, you can retrieve it by running the command: `az iot hub device-identity connection-string show -d GrindingStep --hub-name $dtname -o tsv`

1. Save and close the file.

1. In PowerShell, navigate to the SimulatedClient folder in the cloned repo and run the simulated client:

    ```powershell
    cd C:\Users\username\repos\digital-twins-samples\handsonlab\SimulatedClient
    npm install
    node ./Sensor.js
    ```

1. The simulated device should start sending data. Let the script run for a couple of minutes, then hit `Ctrl`+`C` to break the operation. The output from the SimulatedClient should look similar to the following example:

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

1. Validate that Azure Digital Twins is receiving data by looking at the values being updated in the Twin GrindingSensor by running the following command:

    ```powershell
    az dt twin show -n $dtname --twin-id GrindingStep
    ```

## Challenge: Simulate fanning, roasting, and molding devices

The Sensor.js script can be edited to send data as other devices. The Azure Function has logic that evaluates the device type specified in the payload. Change the value stored in the deviceType and deviceConnection string to send as Fanning and Molding sensors.

:::image type="content" source="../media/sensor-type.png" alt-text="A screenshot showing which deployment script value to change to simulate sending data as a different sensor type":::

```javascript
// String containing Hostname, Device Id & Device Key in the following formats:
// "HostName=<iothub_host_name>;DeviceId=<device_id>;SharedAccessKey=<device_key>"
const deviceConnectionString = "";
let sendInterval;
```

> [!NOTE]
> Remember that the Azure Function assumes the `--device-id` matches the `--twin-id` created when a Twin is initialized.
