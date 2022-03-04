Azure Digital Twins uses compute resources, such as a function that's made by using Azure Functions, to manage data ingress and egress. Functions can be used to manage the following data workflows:

 -  Data ingress from an upstream source (such as data ingestion from IoT hub).
 -  Process Azure Digital Twins data egress for downstream services (such as analysis, storage, workflow integration, analytics).
 -  Process Azure Digital Twins data egress for in-service updates (such as digital twin updates originating from a different twin within the twin graph).

The following steps can be used to create your Azure function:

1.  Create an Azure Functions project.
2.  Write the function code.
    
     -  Add authentication code to the function (for accessing Azure Digital Twins).
     -  Add code that will interact with Azure Digital Twins (and other Azure resources).
3.  Publish the function app to Azure.
4.  Set up security access for the function app.

> [!NOTE]
> The Azure Function will interact with either upstream or downstream Azure services. Azure resource configuration before and/or after creating the Azure Function will be required.

## Configure software packages

The function app interacts with Azure Digital Twins using the Azure Digital Twins SDK. In this example, we use the Azure Digital Twins SDK for .NET (C\#). The SDK requires that your code project include the packages listed below. You can install the packages using Visual Studio's NuGet package manager or by using dotnet in a command-line tool.

 -  Azure.DigitalTwins.Core
 -  Azure.Identity
 -  System.Net.Http
 -  Azure.Core

You will then need to add the following using statements for these packages to your function code.

```csharp
using Azure.DigitalTwins.Core;
using Azure.Identity;
using System.Net.Http;
using Azure.Core.Pipeline;

```

## Add authentication code to the function

It is good practice to use class level variables within the authentication code that provide the function with access Azure Digital Twins. You will add the following to the .cs code file of your function.

 -  Code to read the Azure Digital Twins service URL as an environment variable. It's a good practice to read the service URL from an environment variable, rather than hard-coding it in the function.
    
    ```csharp
    private static readonly string adtInstanceUrl = Environment.GetEnvironmentVariable("ADT_SERVICE_URL");
    
    ```
 -  A static variable to hold an HttpClient instance. HttpClient is relatively expensive to create, and we want to avoid having to do this for every function invocation.
    
    ```csharp
    private static readonly HttpClient httpClient = new HttpClient();
    
    ```
 -  You can use the managed identity credentials in Azure Functions.
    
    ```csharp
    // Authenticate with Digital Twins
    var cred = new ManagedIdentityCredential("https://digitaltwins.azure.net");
    
    ```
 -  Add a local variable DigitalTwinsClient inside of your function to hold your Azure Digital Twins client instance. Do not make this variable static inside your class.
    
    ```csharp
    var client = new DigitalTwinsClient(
        new Uri(adtInstanceUrl),
        cred,
        new DigitalTwinsClientOptions { Transport = new HttpClientTransport(httpClient) });
    
    
    ```

## Azure Function - data ingestion from IoT hub

```csharp
using System;
using Azure;
using System.Net.Http;
using Azure.Core.Pipeline;
using Azure.DigitalTwins.Core;
using Azure.Identity;
using Microsoft.Azure.EventGrid.Models;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.EventGrid;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace IotHubtoTwins
{
    public class IoTHubtoTwins
    {
        private static readonly string adtInstanceUrl = Environment.GetEnvironmentVariable("ADT_SERVICE_URL");
        private static readonly HttpClient httpClient = new HttpClient();

        [FunctionName("IoTHubtoTwins")]
        public async void Run([EventGridTrigger] EventGridEvent eventGridEvent, ILogger log)
        {
            if (adtInstanceUrl == null) log.LogError("Application setting \"ADT_SERVICE_URL\" not set");

            try
            {
                // Authenticate with Digital Twins
                var cred = new ManagedIdentityCredential("https://digitaltwins.azure.net");
                var client = new DigitalTwinsClient(
                    new Uri(adtInstanceUrl),
                    cred,
                    new DigitalTwinsClientOptions { Transport = new HttpClientTransport(httpClient) });
                log.LogInformation($"Azure Digital Twins service client connection created.");
           
                if (eventGridEvent != null && eventGridEvent.Data != null)
                {
                    log.LogInformation(eventGridEvent.Data.ToString());

                    // <Find_device_ID_and_temperature>
                    JObject deviceMessage = (JObject)JsonConvert.DeserializeObject(eventGridEvent.Data.ToString());
                    string deviceId = (string)deviceMessage["systemProperties"]["iothub-connection-device-id"];
                    var temperature = deviceMessage["body"]["Temperature"];
                    // </Find_device_ID_and_temperature>

                    log.LogInformation($"Device:{deviceId} Temperature is:{temperature}");

                    // <Update_twin_with_device_temperature>
                    var updateTwinData = new JsonPatchDocument();
                    updateTwinData.AppendReplace("/Temperature", temperature.Value<double>());
                    await client.UpdateDigitalTwinAsync(deviceId, updateTwinData);
                    // </Update_twin_with_device_temperature>
                }
            }
            catch (Exception ex)
            {
                log.LogError($"Error in ingest function: {ex.Message}");
            }
        }
    }
}

```

> [!NOTE]
> This function runs in response to an Event Grid trigger. Event Grid must configured separately for this code to run successfully. Event Grid can be configured in the Azure portal. The course lab provides a complete set of instructions.
