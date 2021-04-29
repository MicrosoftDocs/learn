You can ingest data into Azure Digital Twins through external compute resources such as Virtual Machines, Azure Functions, and Logic Apps. In this module, a function app will be invoked by Event Grid.  The function app receives the data and uses the [Azure Digital Twins APIs](https://docs.microsoft.com/rest/api/azure-digitaltwins) to set properties.

Additionally, when choosing what type of external compute to use, remember to factor in the additional cost. Virtual Machines, Functions, and Logic Apps all have different cost models.

## Configure your environment

You'll use the following tools and extensions in this unit:

- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) for Visual Studio Code.
- The [Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) for Visual Studio Code.

## Create a function app via the CLI

First we'll created and configure the Azure resources needed.

1. Create an Azure storage account:

    ```azurecli
    az storage account create --name $functionstorage --location $location --resource-group $rgname --sku Standard_LRS
    ```

1. Create a function app:

    ```azurecli
    az functionapp create --resource-group $rgname --consumption-plan-location $location --name $telemetryfunctionname --storage-account $functionstorage --functions-version 3
    ```

## Configure security access for the function app

The Azure function requires a bearer token to be passed in order to authenticate with Azure Digital Twins. To make sure that this token is passed, you'll need to create a managed identity for the function app.

In this section, we'll create a system-managed identity. We'll then assign the function app's identity to the **Azure Digital Twins Owner (Preview)** role for your Azure Digital Twins instance. The managed identity gives the function app permission in the instance to perform data-plane activities. We'll also provide the URL of the Azure Digital Twins instance to the function by setting an environment variable.

1. Use the following command to create the system-managed identity and save the *principalId* to a variable for later use:

    ```azurecli	
    az functionapp identity assign -g $rgname -n $telemetryfunctionname 
    $principalID = $(az functionapp identity assign -g $rgname -n $telemetryfunctionname  --query principalId)
    ```

1. Use the *principalId* value in the following command to assign the function app's identity to the **Azure Digital Twins Data Owner** role for your Azure Digital Twins instance:

    ```azurecli	
    az dt role-assignment create --dt-name $dtname --assignee $principalID --role "Azure Digital Twins Data Owner"
    ```

1. Finally, set the URL of your Azure Digital Twins instance as an environment variable:

    > [!TIP]
    > The URL of the Azure Digital Twins instance is formed by adding **https://** to the beginning of the *hostName*, which you retrieved earlier.

    ```azurecli
    $adthostname = "https://" + $(az dt show -n $dtname --query 'hostName' -o tsv)
    az functionapp config appsettings set -g $rgname -n $telemetryfunctionname --settings "ADT_SERVICE_URL=$adthostname"
    ```

## Create an Azure function project in Visual Studio Code

In this section, you use Visual Studio Code to create a local Azure Functions project in your chosen language. Later in this unit, you'll publish your function code to the Azure Function that was created earlier.

1. Select the Azure icon in the Activity bar. Then, in the **Azure: Functions** area, select the **Create new project** icon.

    ![Partial screenshot showing the elements to select to create a new Azure Functions project.](../media/create-new-project.png)

1. Choose a directory location for your project workspace, and then choose **Select**.

    >[!NOTE]
    >This directory should be new, empty, and unique for this Azure Functions project.
    >

1. Provide the following information at the prompts:

    - **Select a language for your function project**: Select **C#**.
    - **Select a template for your project's first function**: Select **Change template filter**.
    - **Select a template filter**: Select **All**.
    - **Select a template for your project's first function**: Select **EventGridTrigger**.
    - **Provide a function name**: Type **TwinsFunction**.
    - **Provide a namespace**: Type **My.Function**.
    - **When prompted for a storage account choose**: Skip for now.
    - **Select how you would like to open your project**: Select **Add to workspace**.

### Install NuGet packages

In the Visual Studio Code terminal, add the required NuGet packages by typing the following commands:

```dos
dotnet add package Azure.DigitalTwins.Core --version 1.2.0
dotnet add package Azure.identity --version 1.3.0
dotnet add package System.Net.Http
```

### Write an Azure function with an Event Grid trigger

1. In Visual Studio Code, open the file TwinsFunction.cs.
1. Replace the code in the function app template with the sample provided here.

> [!TIP]
> The namespace and function name must match.  If you changed them in the previous steps, make sure to do the same in the code sample.

```csharp
using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Azure.EventGrid.Models;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using Azure.DigitalTwins.Core;
using Azure.DigitalTwins.Core.Serialization;
using Azure.Identity;
using System.Net.Http;
using Azure.Core.Pipeline;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace My.Function
{
    public class TwinsFunction
    {
        //Your Digital Twins URL is stored in an application setting in Azure Functions.
        private static readonly string adtInstanceUrl = Environment.GetEnvironmentVariable("ADT_SERVICE_URL");
        private static readonly HttpClient httpClient = new HttpClient();

        [FunctionName("TwinsFunction")]
        public async void Run([EventGridTrigger] EventGridEvent eventGridEvent, ILogger log)
        {
            log.LogInformation(eventGridEvent.Data.ToString());
            if (adtInstanceUrl == null) log.LogError("Application setting \"ADT_SERVICE_URL\" not set");
            try
            {
                //Authenticate with Digital Twins.
                ManagedIdentityCredential cred = new ManagedIdentityCredential("https://digitaltwins.azure.net");
                DigitalTwinsClient client = new DigitalTwinsClient(new Uri(adtInstanceUrl), cred, new DigitalTwinsClientOptions { Transport = new HttpClientTransport(httpClient) });
                log.LogInformation($"Azure digital twins service client connection created.");
                if (eventGridEvent != null && eventGridEvent.Data != null)
                {
                    log.LogInformation(eventGridEvent.Data.ToString());

                    // Read deviceId and temperature for IoT Hub JSON.
                    JObject deviceMessage = (JObject)JsonConvert.DeserializeObject(eventGridEvent.Data.ToString());
                    string deviceId = (string)deviceMessage["systemProperties"]["iothub-connection-device-id"];
                    var chasistemperature = deviceMessage["body"]["ChasisTemperature"];
                    log.LogInformation($"Device:{deviceId} Temperature is:{chasistemperature}");

                    //Update twin by using device temperature.
                    var patch = new Azure.JsonPatchDocument();
                    patch.AppendReplace<double>("/ChasisTemperature", chasistemperature.Value<double>()); 

                    await client.UpdateDigitalTwinAsync(deviceId, patch); 
                }
            }
            catch (Exception e)
            {
                log.LogError(e.Message);
            }

        }
    }
}
```

## Publish the function app to Azure

1. In the Azure Functions extension for Visual Studio Code, select **Deploy to Function App**:

    ![Partial screenshot showing selection of the icon for the Deploy to Function App command.](../media/deploy-to-function-app.png)

1. Make these selections:
    - **Select subscription**: Select your subscription.
    - **Select Function App in Azure**: Select `<dtname>-telemetryfunction`.

   When the deployment finishes, you'll be prompted to start streaming logs:

     ![Screenshot of dialog box showing three options: Stream logs, Upload settings, and View output.](../media/function-stream-logs.png)

1. Select **Stream logs** to see the messages that are received by the Azure function after the IoT hub set up in the next unit. No messages will be received until the IoT hub is set up and a device sends messages.

    Or, you can choose to stream logs at a later time. Right-click the Azure function in Visual Studio Code and select **Start Streaming Logs**:

     ![Partial screenshot showing the context menu for the function app in Visual Studio Code, including the command to Start Streaming Logs.](../media/function-stream-logs-extension.png)
