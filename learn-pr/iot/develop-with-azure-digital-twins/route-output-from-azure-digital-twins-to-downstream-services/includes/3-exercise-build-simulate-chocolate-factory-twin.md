The following exercise units require that you have an Azure Digital Twins instance set up for the Chocolate Factory Production Line. The instance should have already been updated several times through a connection to an IoT source of data, which streams sensor and actuator data connected to the factory assets to closely monitor the underlying processes and operations.

This pattern relies on the twin updates, rather than forwarding telemetry from an IoT device. This set up gives you the flexibility to change the underlying data source without needing to update your Time Series Insights logic.

To proceed, choose one of the following options:

- If you have been following the "Develop with Azure Digital Twins" Learning Path modules in sequence, have successfully completed all exercises in [Module 3: Ingest Data into Azure Digital Twins](https://review.docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/ingest-data-into-azure-digital-twins/1-introduction?branch=pr-en-us-13689), and retained the solution resources in your Azure Subscription, skip to [**Create a route and filter to twin update notifications**](/learn/modules/developing-with-azure-digital-twins/route-output-from-azure-digital-twins-to-downstream-services/4-exercise-create-route-filter-twin-update-notifications).

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

    :::image type="content" source="../media/custom-template-deployment-variables.png" alt-text="Saving a list of deployment output variables":::

1. In PowerShell, login and set your Azure Subscription using the following commands:

    ```powershell
    az login
    
    az account set --subscription "<your-Azure-subscription-ID>"
    ```

1. Copy and paste the list of variables you had in Notepad and run these variables in PowerShell in order to continue working locally on the next exercises.

1. Now you have an Azure Digital Twin of a factory production line! You can view your Digital Twin using a sample application like [Azure Digital Twins Explorer](https://docs.microsoft.com/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/). Azure Digital Twins Explorer also provides more twin capabilities like uploading models, creating twins, relationships, and updating twin properties.

:::image type="content" source="../media/azure-digital-twins-explorer.png" alt-text="A screenshot showing the Azure Digital Twins explorer user interface":::

Additionally, you have provisioned the IoT Hub and an Azure function that is connected and configured to ingest telemetry from the IoT Hub.

## Create a device and Send data from a simulated local client

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

    :::image type="content" source="../media/deploy-script-connection-string.png" alt-text="A screenshot showing where to insert the connection string in the deployment script":::

    > [!NOTE]
    > If you lost the device connection string, you can retrieve it by running the command: `az iot hub device-identity connection-string show -d GrindingStep --hub-name $dtname -o tsv`

1. Save and close the file.

1. In PowerShell, navigate to the SimulatedClient folder in the cloned repo and run the simulated client:

    ```powershell
    cd C:\Users\username\repos\digital-twins-samples\handsonlab\SimulatedClient
    npm install
    node ./Sensor.js
    ```

1. The simulated device should start sending data. Let the script run for a couple of minutes, then hit `Ctrl`+`C` to break the operation.

    :::image type="content" source="../media/deploy-script-output.png" alt-text="A screenshot showing the output from running the deployment script":::

1. Validate that Azure Digital Twins is receiving data by looking at the values being updated in the Twin GrindingSensor by running the following command:

    ```powershell
    az dt twin show -n $dtname --twin-id GrindingStep
    ```

## Challenge: simulate Fanning/Roasting and Molding devices

The Sensor.js script can be edited to send data as other devices. The Azure Function has logic that evaluates the device type specified in the payload. Change the value stored in the deviceType and deviceConnection string to send as Fanning and Molding sensors.

:::image type="content" source="../media/sensor-type.png" alt-text="A screenshot showing which deployment script value to change to simulate sending data as a different sensor type":::

:::image type="content" source="../media/deploy-script-connection-string.png" alt-text="A screenshot showing where to insert the connection string in the deployment script":::

> [!NOTE]
> Remember that the Azure Function assumes the `--device-id` matches the `--twin-id` created when a Twin is initialized.
