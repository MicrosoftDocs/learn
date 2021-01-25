You can ingest data into Azure Digital Twins through external compute resources. An example might be an Azure Functions instance that receives the data and uses the Digital Twins APIs to set properties.

## Configure your environment

You'll use the following tools and extensions in this unit:

- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- The [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) for Visual Studio Code.
- The [Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) for Visual Studio Code.

## Create an Azure Functions instance via the CLI

1. Create an Azure storage account:

    ```azurecli
    az storage account create --name $functionstorage --location $location --resource-group $rgname --sku Standard_LRS
    ```

1. Create an Azure function app:

    ```azurecli
    az functionapp create --resource-group $rgname --consumption-plan-location $location --name $telemetryfunctionname --storage-account $functionstorage --functions-version 3
    ```

## Configure security access for the function app

The Azure function skeleton from earlier examples requires that a bearer token be passed in order to authenticate with Digital Twins. To make sure that this bearer token is passed, you'll need to create a managed identity for the function app.

In this section, we'll create a system-managed identity and assign the function app's identity to the **Azure Digital Twins Owner (Preview)** role for your Azure Digital Twins instance. The managed identity gives the function app permission in the instance to perform data-plane activities. We'll also provide the URL of Digital Twins instance to the function by setting an environment variable.

1. Use the following command to create the system-managed identity and save the *principalId* to a variable for later use:

    ```azurecli	
    az functionapp identity assign -g $rgname -n $telemetryfunctionname $principalID = $(az functionapp identity assign -g $rgname -n $telemetryfunctionname  --query principalId)
    ```

1. Use the *principalId* value in the following command to assign the function app's identity to the **Azure Digital Twins Data Owner** role for your Digital Twins instance:

    ```azurecli	
    az dt role-assignment create --dt-name $dtname --assignee $principalID --role "Azure Digital Twins Data Owner"
    ```

1. Finally, set the URL of your Digital Twins instance as an environment variable:

    > [!TIP]
    > The URL of the Azure Digital Twins instance is formed by adding **https://** to the beginning of the *hostName* of your Digital Twins instance, which you retrieved earlier.

    ```azurecli
    $adthostname = "https://" + $(az dt show -n $dtname --query 'hostName' -o tsv)
    az functionapp config appsettings set -g $rgname -n $telemetryfunctionname --settings "ADT_SERVICE_URL=$adthostname"
    ```

## Create an Azure function app in Visual Studio Code

In this section, you use Visual Studio Code to create a local Azure Functions project in your chosen language. Later in this unit, you'll publish your function code to Azure.

1. Select the Azure icon in the Activity bar. Then, in the **Azure: Functions** area, select the **Create new project...** icon.

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
dotnet add package Azure.DigitalTwins.Core --version 1.0.0-preview.3
dotnet add package Azure.identity --version 1.2.2
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
                    var uou = new UpdateOperationsUtility();
                    uou.AppendReplaceOp("/ChasisTemperature", temperature.Value<double>());
                    await client.UpdateDigitalTwinAsync(deviceId, uou.Serialize());
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

1. In the Visual Studio Code function extension, select **Deploy to Function App...**

    ![Choose Deploy to Function App...](../media/deploy-to-function-app.png)

    - **Select subscription**: Choose your subscription
    - **Select Function App in Azure**: Choose `<name>twinfunction`.

1. When the deployment finishes, you'll be prompted to Start Streaming Logs

     ![Stream Logs](../media/function-stream-logs.png)

1. Select **Stream Logs** to see the messages received by the Azure Function after the IoT Hub set up in the next step. There won't be any messages received until the IoT Hub is set up and a device sends messages.
1. Alternatively, you can Stream Logs at a later time by right-clicking on the Azure Function in VS Code and choosing **Start Streaming Logs**

     ![Stream logs extension](../media/function-stream-logs-extension.png)