---
metadata:
  title: Build and simulate the chocolate factory twin
  description: This unit covers setting up all the resources necessary for creating the chocolate factory twin and simulating data input to the twin
  ms.date: 11/30/2020
  author: raniabayoumy
  ms.author: rabayoum
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Build and simulate the chocolate factory twin
durationInMinutes: 13
---

The following exercise units require that you have an Azure Digital Twins instance set up for the Chocolate Factory Production Line. The instance should have already been updated several times through a connection to an IoT source of data, which streams sensor and actuator data connected to the factory assets to closely monitor the underlying processes and operations.

This pattern relies on the twin updates, rather than forwarding telemetry from an IoT device. This set up gives you the flexibility to change the underlying data source without needing to update your Time Series Insights logic.

To proceed, please choose one of the following options:

- If you have been following the "Developing with Azure Digital Twins" Learning Path modules in sequence, and have successfully completed all exercises in "Module 3: Ingest Data into Azure Digital Twins," and retained the solution resources in your Azure Subscription, please skip to [Create a route and filter to twin update notifications](../includes/4-exercise-create-a-route-and-filter-to-twin-update-notifications.md).

- If you haven't completed the previous modules and would still like to proceed with the exercises in this module, please continue with the following steps.

## Deploy a PowerShell script

This is required to re-provision the resources created in "Module 3: Ingest Data into Azure Digital Twins."

1. Create a directory and clone the repo. Replace *username* with a valid directory:

    ```powershell-interactive
    mkdir c:\users\<username>\repos
    cd c:\users\<username>\repos
    git clone https://github.com/Teodelas/digital-twins-samples
    ```

1. To deploy the script, browse to the local directory C:\Users\username\repos\digital-twins-samples\HandsOnLab\deployment and right click on **deploymentscript.ps1**. Click Edit. This will open PowerShell in a new window where you should see a split view of the script pane and the command shell.

    :::image type="content" source="../media/adt-deploy-script.png" alt-text="Running the PowerShell resource deployment script":::

    1. Click on Run Script
    1. Enter your Azure Subscription ID when prompted (for more information on finding your Subscription ID, see the [guide for setting Azure subscription](https://docs.microsoft.com/en-us/azure/media-services/latest/how-to-set-azure-subscription?tabs=portal))
    1. Enter your username. This should be the same email you use to sign in your Azure account
    1. Your deployment should start, though it may take a few minutes while all resources are provisioned and deployed. Please wait until the command prompt re-appears
    1. Save the device connection string displayed at the end of the deployment as you'll need it in the following steps

1. Now you have an Azure Digital Twin of a factory production line! You can view your DT using a tool like [ADT Explorer](https://docs.microsoft.com/en-us/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/). ADT explorer also provides additional Twin Capabilities like uploading models, creating twins, relationship, and updating twin properties.

    :::image type="content" source="../media/adt-explorer.png" alt-text="A screenshot showing the ADT explorer user interface":::

    Additionally, the script has provisioned the IoT Hub, IoT Device, and an Azure function that's connected and configured to ingest telemetry from IoT Hub.

## Send data from a simulated device

1. From your cloned repo, open the file ~\digital-twins-samples\HandsOnLab\SimulatedClient\Sensor.js in a text editor.

1. Find the line `const deviceConnectionString = ""` and update it with the device connection saved earlier from deploying the script in the [previous section](#deploy-a-powershell-script).

    :::image type="content" source="../media/adt-deploy-script-connection-string.png" alt-text="A screenshot showing where to insert the connection string in the deployment script":::

    > [!NOTE]
    > if you lost the device connection string, you can retrieve it by running the command: `az iot hub device-identity connection-string show -d GrindingStep --hub-name $dtname -o tsv`

1. In PowerShell, navigate to the SimulatedClient folder in the cloned repo and run the simulated client:

    ```powershell-interactive
    cd C:\Users\<username>\repos\digital-twins-samples\handsonlab\SimulatedClient
    npm install
    node ./Sensor.js
    ```

1. The simulated device should start sending data. Let it run for a couple of minutes, then hit `Ctrl`+`C` to break.

    :::image type="content" source="../media/adt-deploy-script-output.png" alt-text="A screenshot showing the output from running the deployment script":::

1. Validate that Azure Digital Twin is receiving data by looking at the values being updated in the Twin GrindingSensor by running the following command:

    ```powershell-interactive
    az dt twin show -n $dtname --twin-id GrindingStep
    ```

## Challenge: simulate fanning, roasting and moulding devices

The Sensor.js script can be edited to send data as additional devices. The Azure Function has logic that evaluates the device type specified in the payload. Change the value stored in the deviceType and deviceConection string to send as **Fanning** and **Moulding** sensors.

:::image type="content" source="../media/adt-sensor-type.png" alt-text="A screenshot showing which deployment script value to change to simulate sending data as a different sensor type":::

:::image type="content" source="../media/adt-deploy-script-connection-string.png" alt-text="A screenshot showing where to insert the connection string in the deployment script":::

> [!NOTE]
> Remember that the Azure Function assumes the `--device-id` matches the `--twin-id` created when a Twin is initialized.
