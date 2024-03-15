In this unit, you set up data ingestion from a thermostat device in your building (represented with a device simulator) into Azure Digital Twins. This process involves the resources shown in Flow A in this diagram:

:::image type="content" source="../media/2-3-4-building-scenario.png" alt-text="Graph showing data flowing from a device into Azure Digital Twins, then throughout Azure Digital Twins." border="true" lightbox="../media/2-3-4-building-scenario.png":::

Data flow follows this path:
1. The simulated device, *Thermostat 67*, produces temperature data.
1. The temperature data is sent to the cloud, arriving in IoT Hub.
1. IoT Hub routes the temperature data to a custom Azure function (*IoTHubToADT*).
1. The Azure function code uses the temperature data to update the *Temperature* property on the corresponding *Thermostat67* twin in Azure Digital Twins.

## Create required resources

First, create the resources that are needed for this flow: the IoT Hub and the Azure function.

### Create IoT Hub

Return to your Cloud Shell window, and create an IoT hub with the following Azure CLI command. The default name is *iot-hub-smart-building*.

```azurecli
IOT_HUB="iot-hub-smart-building"
az iot hub create --name $IOT_HUB --resource-group $RESOURCE_GROUP --sku S1
```

### Create Azure function

Next, create an Azure function to process data from IoT Hub and update Azure Digital Twins.

### Create function app

First, create a new function app in Azure. Run the following CLI commands to create a storage account for the function app, create the new function app, and make sure Visual Studio will be able to publish to it. The commands generate a random number to use in the storage account name and the function app name.

```azurecli
STORAGE_ACCOUNT_NAME="functionstorage$RANDOM"
az storage account create --name $STORAGE_ACCOUNT_NAME --location $REGION --resource-group $RESOURCE_GROUP --sku Standard_LRS

FUNCTION_APP_NAME="digitaltwinsfunctions$RANDOM"
az functionapp create --name $FUNCTION_APP_NAME --storage-account $STORAGE_ACCOUNT_NAME --consumption-plan-location $REGION --resource-group $RESOURCE_GROUP --functions-version 4
az resource update --resource-group $RESOURCE_GROUP --name scm --namespace Microsoft.Web --resource-type basicPublishingCredentialsPolicies --parent sites/$FUNCTION_APP_NAME --set properties.allow=true
```

#### Configure function app

Run the following Azure CLI commands to create a system-assigned identity for the Azure function app, and grant that identity the *Azure Digital Twins Data Owner* role on your Azure Digital Twins instance. This enables functions in your function app to make changes to data in the Azure Digital Twins instance.

```azurecli
APP_ID=$(az functionapp identity assign --resource-group $RESOURCE_GROUP --name $FUNCTION_APP_NAME --query principalId -o tsv)
az dt role-assignment create --resource-group $RESOURCE_GROUP --dt-name $INSTANCE_NAME --assignee $APP_ID --role "Azure Digital Twins Data Owner"
```

Run the following Azure CLI command to create an environment variable in your Azure function that holds URL of your Azure Digital Twins instance. This variable will provide your Azure Digital Twins instance URL to the code of your Azure functions at runtime. Storing the URL in a function environment variable like this ensures that if you ever need to change this value, you can change it for all functions in the function app from this one spot.

```azurecli
az functionapp config appsettings set --resource-group $RESOURCE_GROUP --name $FUNCTION_APP_NAME --settings "ADT_SERVICE_URL=https://$INSTANCE_NAME.api.wus2.digitaltwins.azure.net"
```

#### Set up function project

Next, set up a local project where you'll write the first Azure function that will be published to your function app in Azure.

1. Open Visual Studio on your local machine and choose **Create a new project**.
1. Search for and select the **Azure Functions** template.

    :::image type="content" source="../media/3-new-function-project.png" alt-text="Screenshot of Visual Studio showing the Azure Functions template for a new project." lightbox="../media/3-new-function-project.png":::

1. Continue through the setup prompts. Name your project *DigitalTwinsTrainingApp* and leave the default **Function** selection of *Event Grid trigger*. When setup is complete, the new function app project opens in Visual Studio and shows a new function template file called *Function1.cs*.
1. Select and hold (or right-click) **DigitalTwinsTrainingApp** in the Solution Explorer to open a list of options, and select **Manage NuGet Packages...**
    :::image type="content" source="../media/3-manage-packages.png" alt-text="Screenshot of Visual Studio showing the Manage NuGet Packages option." lightbox="../media/3-manage-packages.png":::

    Use the package manager to install these packages: *Azure.Identity*, *Azure.DigitalTwins.Core*.

#### Write function code

Next, fill in the code body of the function. The function needs to identify key information in an incoming message from IoT Hub, then use the [Azure Digital Twins .NET SDK](/dotnet/api/overview/azure/digitaltwins.core-readme) to update the correct twin in Azure Digital Twins.

Start by completing the following steps to set up the function and prepare it to work with Azure Digital Twins.

1. Add these `using` statements to your file, so you can make the function asynchronous and access Azure functionality. (Other `using` statements will be added by Visual Studio automatically as you paste in code.)

    ```csharp
    using Azure;
    using System.Threading.Tasks;
    ```

1. Make these updates to the sample function that's been provided in the template. 
    1. The function has a default name of `Function1`. Rename it to `IoTHubToADT` to make it easier to recognize later.
    1. Remove `static` from the class declaration. 
    1. Make the function asynchronous, by changing the signature of the `Run` method from `public static void` to `public async Task`.
    
    :::image type="content" source="../media/3-code-1.png" alt-text="Screenshot of code in Visual Studio, showing the template changes." lightbox="../media/3-code-1.png":::

[!INCLUDE [Common Azure Digital Twins function setup steps](../../includes/azure-digital-twins-function.md)]

Next, add the unique functionality.

1. Still inside the `Run` method, set up an `if` statement to take action when the function receives an Event Grid event with data. This will be executed when the temperature data from IoT Hub arrives at the Azure function.

    ```csharp
    if (eventGridEvent != null && eventGridEvent.Data != null)
    {
        log.LogInformation(eventGridEvent.Data.ToString());
    }
    ```

    :::image type="content" source="../media/3-code-4.png" alt-text="Screenshot of code in Visual Studio, showing the if statement." lightbox="../media/3-code-4.png":::

1. In the body of the `if` statement, after the logger line, add the following code. This code snippet reads the incoming message from IoT Hub to identify the device that's sending the message and the updated temperature value.

    ```csharp
    // Reading deviceId and temperature for IoT Hub JSON
    JObject deviceMessage = (JObject)JsonConvert.DeserializeObject(eventGridEvent.Data.ToString());
    string deviceId = (string)deviceMessage["systemProperties"]["iothub-connection-device-id"];
    var temperature = deviceMessage["body"]["Temperature"];

    log.LogInformation($"Device:{deviceId} Temperature is:{temperature}");
    ```

    :::image type="content" source="../media/3-code-5.png" alt-text="Screenshot of code in Visual Studio, showing the reading additions to the if statement." lightbox="../media/3-code-5.png":::

1. Complete the `if` statement with the following code. This code snippet uses the [UpdateDigitalTwinAsync](/dotnet/api/azure.digitaltwins.core.digitaltwinsclient.updatedigitaltwinasync) method to update the digital twin that has an ID matching the device ID from the telemetry message. Using a JSON Patch document, the method updates the twin's `Temperature` property to match the new temperature value.

    ```csharp
    //Update twin using device temperature
    var updateTwinData = new JsonPatchDocument();
    updateTwinData.AppendReplace("/Temperature", temperature.Value<double>());
    await client.UpdateDigitalTwinAsync(deviceId, updateTwinData);
    ```

    :::image type="content" source="../media/3-code-6.png" alt-text="Screenshot of code in Visual Studio, showing the updating additions to the if statement." lightbox="../media/3-code-6.png":::

1. Save the completed function file.

>[!NOTE]
>You can see this full code sample in the same GitHub repository where you downloaded the device simulator: [ProcessHubToDTEvents.cs (digital-twins-samples)](https://github.com/Azure-Samples/digital-twins-samples/blob/main/AdtSampleApp/SampleFunctionsApp/ProcessHubToDTEvents.cs).

#### Publish function

Follow these steps to publish your function to the Azure function app you created earlier in this unit.

1. Select and hold (or right-click) **DigitalTwinsTrainingApp** in the Solution Explorer to open a list of options, and select **Publish...**
    :::image type="content" source="../media/3-publish-start.png" alt-text="Screenshot of Visual Studio showing the Publish option." lightbox="../media/3-publish-start.png":::

1. In the **Publish** dialog that pops up, make the following selections:
    1. **Target**: Select **Azure**.
    1. **Specific target**: Select **Azure Function App (Windows)**.
    1. **Functions instance**: Under **Subscription name**, select your subscription. Your resource groups show up in the box. Expand the resource group for this module (if you kept the default name, it's *azure-digital-twins-training*), and select the function app that starts with *digitaltwinsfunctions*. 
    1. Select **Finish** to finish setting up the publish profile.
1. Back in Visual Studio, verify the function is **Ready to publish** to your function app, and select **Publish**.
    :::image type="content" source="../media/3-publish-finish.png" alt-text="Screenshot of code in Visual Studio, showing the final Publish button." lightbox="../media/3-publish-finish.png":::

On a successful publish, Visual Studio indicates that the publish succeeded.

>[!TIP]
>If publish fails with an error that *The Publish URL ... is unreachable*, try re-running the following command in your Azure CLI to make sure Visual Studio is able to authenticate to carry out deployment. Then retry the publish.
> ```azurecli
> az resource update --resource-group $RESOURCE_GROUP --name scm --namespace Microsoft.Web --resource-type basicPublishingCredentialsPolicies --parent sites/$FUNCTION_APP_NAME --set properties.allow=true
> ```

## Connect resources

Now that your IoT Hub and Azure function are created, you can set up the connections between these resources so that the simulated device data can flow through them.

### Connect device to IoT Hub

First, get the simulated device data into IoT Hub.

Create a virtual device in IoT Hub to represent the thermostat device, by running the following command in the Azure CLI. The IoT Hub device twin will be called *Thermostat67*.

```azurecli
az iot hub device-identity create --device-id Thermostat67 --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP
```

Next, configure the device simulator to connect to its IoT Hub device representation. You'll do this by setting IoT Hub connection values in the device simulator code you downloaded in Unit 2.

Start by running the following Azure CLI commands to get the connection strings for the IoT Hub as a whole (the first command), and the *Thermostat67* virtual device in IoT Hub (the second command). You'll be copying these output values, each one starting with `HostName=...`, into your device simulator code.

```azurecli
az iot hub connection-string show --hub-name $IOT_HUB
az iot hub device-identity connection-string show --device-id Thermostat67 --hub-name $IOT_HUB
```

Next, navigate to the device simulator folder you downloaded onto your machine. Open the file at *digital-twins-samples-main\DeviceSimulator\DeviceSimulator\AzureIoTHub.cs* for editing. Look for the following code, and change the placeholders to the values you gathered above.

```csharp
private const string iotHubConnectionString = "<your-hub-connection-string>";
//...
private const string deviceConnectionString = "<your-device-connection-string>";
```

Save and close the file. 

Now, your device simulator is set up to send data into IoT Hub. In a real scenario with multiple devices, you'd register all of them with IoT Hub.

### Connect IoT Hub to Azure function

Next, set up data flow from IoT Hub into your Azure function.

Use the following Azure CLI command to create an Event Grid *event subscription* from your IoT Hub, with the Azure function as an endpoint. This "subscribes" the *IoTHubToADT* function to telemetry events happening in IoT Hub.

```azurecli
az eventgrid event-subscription create --name iothubsubscription --event-delivery-schema eventgridschema --source-resource-id /subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Devices/IotHubs/$IOT_HUB --included-event-types Microsoft.Devices.DeviceTelemetry --endpoint-type azurefunction --endpoint /subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Web/sites/$FUNCTION_APP_NAME/functions/IoTHubToADT
```

Now IoT Hub is ready to send data to your Azure function. From there, the function code that you wrote earlier in this unit updates Azure Digital Twins.

## Run simulation and verify results

Now it's time to run the data simulator and see the results!

On your machine, open a new console window and navigate into the *digital-twins-samples-main\DeviceSimulator\DeviceSimulator* folder.

Start the device simulator project by running the following dotnet command in the console. In the sample scenario, this simulator represents a thermostat in the smart building that regularly emits temperature readings.

```cmd/sh
dotnet run
```

The project starts running and, after a few minutes, begins sending simulated temperature telemetry messages. A new message is sent every five seconds.

:::image type="content" source="../media/3-device-simulator.png" alt-text="Screenshot of the device simulator running in the console." lightbox="../media/3-device-simulator.png":::

While this is running, query your Azure Digital Twins instance by returning to the Cloud Shell and running the following command. This command sends a query that returns the ID value and temperature of all twins in the instance.

```azurecli
az dt twin query -n $INSTANCE_NAME -q "select T.\$dtId, T.Temperature from digitaltwins T"
```

The results show that the *Thermostat67* twin, which was originally created in Unit 2 with a *Temperature* value of 0.0, has a *Temperature* value that matches a value from the device simulator. The value is updating quickly, so repeat the query command a few more times to watch the value change.

:::image type="content" source="../media/3-twin-results.png" alt-text="Screenshot of Cloud Shell showing the output of the queries." lightbox="../media/3-twin-results.png":::

After you observe changing temperature values on the digital twin, you can stop the device simulator. These values indicate that the twin is successfully connected to the device simulator and is being updated based on its readings. In the sample scenario, this means your Azure Digital Twins representation is now running with live data from the smart building.

>[!TIP]
>The Azure function you created will work for any number of devices, as long as they're all represented in IoT Hub and have a digital twin with a matching name.

You might notice in the query results that although the *Thermostat67* twin is updating, the *Room21* twin connected to it stays at zero. That's because you haven't yet connected data flow through the Azure Digital Twins graph. To set that up, continue to the next unit.