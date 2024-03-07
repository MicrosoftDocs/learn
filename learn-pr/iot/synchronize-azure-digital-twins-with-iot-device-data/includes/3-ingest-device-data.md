In this unit, you set up data ingestion from a thermostat device in your building (represented here with a device simulator) into Azure Digital Twins. This involves the resources shown in Flow A below:

:::image type="content" source="../media/2-3-4-building-scenario.png" alt-text="Graph showing data flowing from a device into Azure Digital Twins, then throughout Azure Digital Twins." border="false" lightbox="../media/2-3-4-building-scenario.png":::

Data flow follows this path:
1. Temperature data is produced by the simulated device, *Thermostat 67*.
1. The temperature data is sent to the cloud, arriving in IoT Hub.
1. IoT Hub uses Event Grid to deliver the temperature data to a custom Azure function.
1. The Azure function code uses the temperature data to update the *Temperature* property on the corresponding twin in Azure Digital Twins. In this case, that's the *Thermostat67* twin.

## Create required resources

First, create the resources that are needed for this flow: the IoT Hub and the Azure function.

### Create IoT Hub

Run the following command in the Azure CLI to create an IoT hub. The default name is *iot-hub-smart-building*.

```azure-cli
IOT_HUB="iot-hub-smart-building"
echo "Your IoT Hub is named $IOT_HUB."
az iot hub create --name $IOT_HUB --resource-group $RESOURCE_GROUP --sku S1
```

### Create Azure function

In this section, you create an Azure function to process data from IoT Hub and update Azure Digital Twins.

### Create function app

First, create a new function app in Azure. Run the following CLI commands to create a storage account for the function app, create the new function app, and make sure Visual Studio will be able to publish to it. The commands generate a random number to use in the storage account name, and the function app is called *digitaltwinsfunctions*.

```azure-cli
STORAGE_ACCOUNT_NAME="functionstorage$RANDOM"
az storage account create --name $STORAGE_ACCOUNT_NAME --location $REGION --resource-group $RESOURCE_GROUP --sku Standard_LRS

FUNCTION_APP_NAME="digitaltwinsfunctions$RANDOM"
az functionapp create --name $FUNCTION_APP_NAME --storage-account $STORAGE_ACCOUNT_NAME --consumption-plan-location $REGION --resource-group $RESOURCE_GROUP --functions-version 4
az resource update --resource-group $RESOURCE_GROUP --name scm --namespace Microsoft.Web --resource-type basicPublishingCredentialsPolicies --parent sites/$FUNCTION_APP_NAME --set properties.allow=true
```

#### Configure function app

Run the following Azure CLI commands to create a system-assigned identity for the Azure function app, and grant that identity the *Azure Digital Twins Data Owner* role on your Azure Digital Twins instance. This will enable functions in your function app to make changes to data in the Azure Digital Twins instance.

```azure-cli
APP_ID=$(az functionapp identity assign --resource-group $RESOURCE_GROUP --name $FUNCTION_APP_NAME --query principalId -o tsv)
az dt role-assignment create --resource-group $RESOURCE_GROUP --dt-name $INSTANCE_NAME --assignee $APP_ID --role "Azure Digital Twins Data Owner"
```

Run the following Azure CLI command to create an environment variable in your Azure function that holds URL of your Azure Digital Twins instance. This variable will provide your Azure Digital Twins instance URL to the code of your Azure functions at runtime. Storing the URL in a function environment variable like this ensures that if you ever need to change this value, you can change it for all functions in the function app from this one spot.

```azure-cli
az functionapp config appsettings set --resource-group $RESOURCE_GROUP --name $FUNCTION_APP_NAME --settings "ADT_SERVICE_URL=https://$INSTANCE_NAME.api.wus2.digitaltwins.azure.net"
```

#### Set up function project

Next, set up a local project where you'll write the specific Azure function that will be published to your function app in Azure.

1. Open Visual Studio on your local machine and choose **Create a new project**.
1. Search for and select the **Azure functions** template.

    :::image type="content" source="../media/3-new-function-project.png" alt-text="Screenshot of Visual Studio showing the Azure Functions template for a new project." lightbox="../media/3-new-function-project.png":::

1. Continue through the setup prompts. Name your project *DigitalTwinsTrainingApp* and leave the default **Function** selection of *Event Grid trigger*. When setup is complete, the new function app project will open in Visual Studio and show a new function template file called *Function1.cs*.
1. Select and hold (or right-click) **DigitalTwinsTrainingApp** in the Solution Explorer to open a list of options, and select **Manage NuGet Packages...**.
    :::image type="content" source="../media/3-manage-packages.png" alt-text="Screenshot of Visual Studio showing the Manage NuGet Packages option." lightbox="../media/3-manage-packages.png":::

    Use the package manager to install these packages: *Azure.Identity*, *Azure.DigitalTwins.Core*.

#### Write function code

Next, fill in the code body of the function. The function needs to identify key information in the incoming message, then use the [Azure Digital Twins .NET SDK](https://learn.microsoft.com/dotnet/api/overview/azure/digitaltwins.core-readme) to update the correct twin in Azure Digital Twins, based on that information.

Build the code by following these steps:

1. Add these `using` statements to your function, so you can make the function asynchronous and access Azure functionality. (Additional `using` statements will be added by Visual Studio automatically as you paste in code.)

    ```csharp
    using Azure;
    using System.Threading.Tasks;
    ```

1. Make a few updates to the sample function that's been provided in the template. 
    1. The function has a default name of `Function1`. Rename it to `IoTHubToADT` to make it easier to recognize later.
    1. Remove `static` from the class declaration. Change the signature of the `Run` method from `public static void` to `public async Task`, to make this method asynchronous.
    
    :::image type="content" source="../media/3-code-1.png" alt-text="Screenshot of code in Visual Studio, showing the template changes." lightbox="../media/3-code-1.png":::

1. Add these variables to the top of your class, before the function declaration. These class variables will be used to authenticate your function with Azure Digital Twins. There are no placeholders to replace; just paste them in as shown.

    ```csharp
    private static readonly HttpClient httpClient = new HttpClient();
    private static string adtServiceUrl = Environment.GetEnvironmentVariable("ADT_SERVICE_URL");  //This will be populated at runtime by the environment variable you set up earlier for the Azure function app. adtServiceUrl will ultimately be set to "https://<host-name-of-your-Azure-Digital-Twins-instance>".
    ```

    :::image type="content" source="../media/3-code-2.png" alt-text="Screenshot of code in Visual Studio, showing the new variables." lightbox="../media/3-code-2.png":::

1. In the `Run` method, add the following code after the log line. This code snippet uses the authentication variables above to set up a `DigitalTwinsClient`, which contains methods to retrieve and update digital twin information. For more information about this class, see [DigitalTwinsClient Class](https://learn.microsoft.com/dotnet/api/azure.digitaltwins.core.digitaltwinsclient).

    ```csharp
    var credentials = new DefaultAzureCredential();
    DigitalTwinsClient client = new DigitalTwinsClient(
        new Uri(adtServiceUrl), credentials, new DigitalTwinsClientOptions
        { Transport = new HttpClientTransport(httpClient) });
    log.LogInformation($"ADT service client connection created.");
    ```

    :::image type="content" source="../media/3-code-3.png" alt-text="Screenshot of code in Visual Studio, showing the the DigitalTwinsClient." lightbox="../media/3-code-3.png":::

1. After this code (still in the `Run` method), set up an `if` statement to take action when the function receives an Event Grid event with data. This will be executed when the temperature data from IoT Hub arrives at the Azure function.

    ```csharp
    if (eventGridEvent != null && eventGridEvent.Data != null)
    {
        log.LogInformation(eventGridEvent.Data.ToString());
    }
    ```

    :::image type="content" source="../media/3-code-4.png" alt-text="Screenshot of code in Visual Studio, showing the if statement." lightbox="../media/3-code-4.png":::

1. In the body of the `if` statement, after the logger line, add the following code. This code snippet reads the incoming message to identify the device that's sending the message and the updated temperature value.

    ```csharp
    // Reading deviceId and temperature for IoT Hub JSON
    JObject deviceMessage = (JObject)JsonConvert.DeserializeObject(eventGridEvent.Data.ToString());
    string deviceId = (string)deviceMessage["systemProperties"]["iothub-connection-device-id"];
    var temperature = deviceMessage["body"]["Temperature"];

    log.LogInformation($"Device:{deviceId} Temperature is:{temperature}");
    ```

    :::image type="content" source="../media/3-code-5.png" alt-text="Screenshot of code in Visual Studio, showing the reading additions to the if statement." lightbox="../media/3-code-5.png":::

1. Complete the `if` statement by adding the following code. This code snippet uses the [UpdateDigitalTwinAsync](https://learn.microsoft.com/dotnet/api/azure.digitaltwins.core.digitaltwinsclient.updatedigitaltwinasync) method to update the digital twin that has an ID matching the device ID from the telemetry message. Using a JSON Patch document, the method updates the twin's `Temperature` property to match the new temperature value.

    ```csharp
    //Update twin using device temperature
    var updateTwinData = new JsonPatchDocument();
    updateTwinData.AppendReplace("/Temperature", temperature.Value<double>());
    await client.UpdateDigitalTwinAsync(deviceId, updateTwinData);
    ```

    :::image type="content" source="../media/3-code-6.png" alt-text="Screenshot of code in Visual Studio, showing the updating additions to the if statement." lightbox="../media/3-code-6.png":::

1. Save the completed function file.

#### Publish function

Follow these steps to publish your function to the Azure function app you created earlier in this unit.

1. Select and hold (or right-click) **DigitalTwinsTrainingApp** in the Solution Explorer to open a list of options, and select **Publish...**.
    :::image type="content" source="../media/3-publish-start.png" alt-text="Screenshot of Visual Studio showing the Publish option." lightbox="../media/3-publish-start.png":::

1. In the **Publish** dialog that pops up, make the following selections:
    1. **Target**: Select **Azure**.
    1. **Specific target**: Select **Azure Function App (Windows)**.
    1. **Functions instance**: Under **Subscription name**, select your subscription. Your resource groups will show up in the box. Expand your resource group (if you kept the default name for this module, it's *azure-digital-twins-training*), and select the function app, *digitaltwinsfunctions*. 
    1. Select **Finish** to finish setting up the publish profile.
1. Back in Visual Studio, verify the function is **Ready to publish** to your new function app, and select **Publish**.
    :::image type="content" source="../media/3-publish-finish.png" alt-text="Screenshot of code in Visual Studio, showing the updating additions to the if statement." lightbox="../media/3-publish-finish.png":::

On a successful publish, Visual Studio will indicate that the publish succeeded.

## Connect resources

Now that your IoT Hub and Azure function have been created, you can set up the connections between these resources so that the simulated device data can flow through them.

### Connect device to IoT Hub

First, you need to get the simulated device data into IoT Hub.

Run the following Azure CLI command to create a virtual device in IoT Hub to represent the thermostat device. The IoT Hub device will be called *Thermostat67*.

```azure-cli
az iot hub device-identity create --device-id Thermostat67 --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP
```

Next, configure the device to connect to its IoT Hub device representation. You'll do this by setting IoT Hub connection values in the device simulator code you downloaded to your machine in the previous unit.

Start by running the following Azure CLI commands to get the connection strings for the IoT Hub as a whole, and the specific virtual device in IoT Hub. You'll copy these output values, each one starting with `HostName=...`, into your device simulator code.

```azure-cli
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

Use the following Azure CLI command to create an Event Grid *event subscription* from your IoT Hub, with the Azure function as an endpoint. This "subscribes" the *IoTHubToADT* function to telemetry events happening in IoT Hub.

```azure-cli
az eventgrid event-subscription create --name iothubsubscription --event-delivery-schema eventgridschema --source-resource-id /subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Devices/IotHubs/$IOT_HUB --included-event-types Microsoft.Devices.DeviceTelemetry --endpoint-type azurefunction --endpoint /subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Web/sites/$FUNCTION_APP_NAME/functions/IoTHubToADT
```

Now, IoT Hub is set up to send data to your Azure function. From there, the function code that you wrote earlier in this unit will update Azure Digital Twins.

## Run simulation and verify results

Now it's time to run the data simulator and see the results!

On your machine, open a new console window and navigate to *digital-twins-samples-main\DeviceSimulator\DeviceSimulator*.

Run the following dotnet command in the console to run the device simulator project. In the sample scenario, this simulator represents a thermostat in the smart building that regularly records temperature readings.

```cmd/sh
dotnet run
```

The project will start running and begin displaying simulated temperature telemetry messages. A new message is sent every five seconds.

:::image type="content" source="../media/3-device-simulator.png" alt-text="Screenshot of the device simulator running in the console." lightbox="../media/3-device-simulator.png":::

While this is running, return to the Cloud Shell and run the following command to query your Azure Digital Twins instance. The query returns the ID value and temperature of all twins in the instance.

```azurecli
az dt twin query -n $INSTANCE_NAME -q "select T.\$dtId, T.Temperature from digitaltwins T"
```

The results show that the *Thermostat67* twin, which was originally created in Unit 2 with a *Temperature* value of 0.0, has a *Temperature* value that matches a value from the device simulator. The value is updating quickly, so repeat the query command a few more times to watch the value change.

:::image type="content" source="../media/3-publish-finish.png" alt-text="Screenshot of Cloud Shell showing the output of the queries." lightbox="../media/3-publish-finish.png":::

Once you've observed changing temperature values on the digital twin, you can stop the device simulator. These values indicate that it's successfully connected to the device simulator and being updated based on its readings. The Azure function you created will work for any number of devices, as long as they're all represented in IoT Hub and have a digital twin with a matching name. In the sample scenario, this means your Azure Digital Twins representation is now running with live data from the smart building.

You might notice that although the *Thermostat67* twin is updating, the *Room21* twin connected to it stays at zero. That's because you haven't yet connected data flow through the Azure Digital Twins graph. To set that up, continue on to the next unit.