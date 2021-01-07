Next, you'll create an Event Hubs-triggered function inside a function app. This function will convert twin update events from their original form as JSON Patch documents to JSON objects, containing only updated, and added values from your twins.

## Create an Azure Function

Run the following command in PowerShell:

```powershell
az functionapp create --resource-group $rgname --consumption-plan-location $location --runtime dotnet --functions-version 3 --name $twinupdatefunctionname --storage-account  $functionstorage
```

## Create an Azure Functions app in Visual Studio Code for Event Hub

Use Visual Studio Code to create a local Azure Functions project. Later in this unit, you'll publish your function code to Azure.

1. Choose the Azure icon in the Activity bar, then in the **Azure: Functions** area, select the **Create new project** icon:

    :::image type="content" source="../media/create-azure-function-visual-studio-code.png" alt-text="Screenshot showing how to create a new Azure function project in Visual Studio Code":::

1. Choose a directory location for your project workspace and choose **Select**.

1. When prompted, provide the following information:

    - **Select a language for your function project:** Choose C#
    - **Select a template for your project's first function:** Choose "EventHubTrigger"
    - **Provide a function name:** Type "TSIFunction"
    - **Provide a namespace:** Type "TSIFunctionsApp"
    - **Select setting from local.settings.json:** Hit Enter
    - **Select subscription:** Select the subscription you're using
    - **Select an event hub namespace:** Choose the event hub namespace that ends with "twinsnamespace"
    - **Select an event hub:** Choose "twins-event-hub"
    - **Select an event hub policy:** Choose "EHPolicy"
    - **When prompted for a storage account:** Choose "Skip for now"
    - **Select how you would like to open your project:** Choose "Add to workspace"

1. Open the "TSIFunction.cs" file and replace the code in it with the following code sample:

    ```csharp
    using Microsoft.Azure.EventHubs;
    using Microsoft.Azure.WebJobs;
    using Microsoft.Extensions.Logging;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using System.Threading.Tasks;
    using System.Text;
    using System.Collections.Generic;
    
    namespace TSIFunctionsApp
    {
        public static class ProcessDTUpdatetoTSI
        { 
            [FunctionName("ProcessDTUpdatetoTSI")]
            public static async Task Run(
                [EventHubTrigger("twins-event-hub", Connection = "EventHubAppSetting-Twins")]EventData myEventHubMessage, 
                [EventHub("tsi-event-hub", Connection = "EventHubAppSetting-TSI")]IAsyncCollector<string> outputEvents, 
                ILogger log)
            {
                JObject message = (JObject)JsonConvert.DeserializeObject(Encoding.UTF8.GetString(myEventHubMessage.Body));
                log.LogInformation("Reading event:" + message.ToString());
    
                // Read values that are replaced or added
                Dictionary<string, object> tsiUpdate = new Dictionary<string, object>();
                foreach (var operation in message["patch"]) {
                    if (operation["op"].ToString() == "replace" || operation["op"].ToString() == "add")
                    {
                        //Convert from JSON patch path to a flattened property for TSI
                        //Example input: /Front/Temperature
                        //        output: Front.Temperature
                        string path = operation["path"].ToString().Substring(1);                    
                        path = path.Replace("/", ".");                    
                        tsiUpdate.Add(path, operation["value"]);
                    }
                }
                //Send an update if updates exist
                if (tsiUpdate.Count>0){
                    tsiUpdate.Add("$dtId", myEventHubMessage.Properties["cloudEvents:subject"]);
                    await outputEvents.AddAsync(JsonConvert.SerializeObject(tsiUpdate));
                }
            }
        }
    }
    ```

1. In the VSCode function extension, click on **Deploy to Function App...**

    :::image type="content" source="../media/deploy-azure-function-visual-studio-code.png" alt-text="Screenshot showing how to deploy an Azure function app in Visual Studio Code":::

    - **Select subscription:** Choose your subscription
    - **Select Function App in Azure:** Choose the function that ends in "twinupdatefunction"
    - **If prompted to overwrite a previous deployment:** Click "Deploy"

    :::image type="content" source="../media/overwrite-azure-function-visual-studio-code.png" alt-text="Screenshot of a Visual Studio Code prompt to overwrite the previous Azure function deployment":::

1. When the deployment finishes, you'll be prompted to start streaming logs:

    :::image type="content" source="../media/azure-function-stream-logs-visual-studio-code.png" alt-text="Screenshot of a Visual Studio Code prompt to stream logs for the deployed Azure function":::

    - Click on **Stream Logs** to see the twin update messages received by the Azure Function.

        - Alternatively, you can stream logs at a later time by right-clicking on the Azure Function in VSCode and choosing **Start Streaming Logs**:

        :::image type="content" source="../media/azure-function-stream-logs-later-visual-studio-code.png" alt-text="Screenshot showing how to stream logs for an Azure function after it's been deployed in Visual Studio Code":::

## Send telemetry to an event hub

You'll now create a second event hub and configure your function to stream its output to that event hub. This event hub will then be connected to Time Series Insights.

### Create an event hub

To create the second event hub, use the following PowerShell instructions:

1. Prepare your *Event Hubs namespace* and *resource group* name from earlier in this module

1. Create a new event hub:

    ```powershell
    # Create an event hub. Specify a name "tsi-event-hub" for the event hub. 
    az eventhubs eventhub create --name "tsi-event-hub" --resource-group $rgname --namespace-name $ehnamespace
    ```

1. Create an [authorization rule](https://docs.microsoft.com/cli/azure/eventhubs/eventhub/authorization-rule?view=azure-cli-latest#az-eventhubs-eventhub-authorization-rule-create) with "send" and "receive" permissions:

    ```powershell
    # Create an authorization rule. Specify a name for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group $rgname --namespace-name $ehnamespace --eventhub-name "tsi-event-hub" --name EHPolicy
    ```

## Configure your function

Next, you'll need to set environment variables in your function app from earlier, containing the connection strings for the event hubs you've created:

### Set the Twins event hub connection string

1. Get the Twins [event hub connection string](https://docs.microsoft.com/azure/event-hubs/event-hubs-get-connection-string), using the authorization rules you created in the previous section for the Twins hub:

    ```powershell
    $adtehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name twins-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    ```

1. Use the connection string you get as a result to create an app setting in your function app that contains your connection string:

    ```powershell
    az functionapp config appsettings set --settings "EventHubAppSetting-Twins=$adtehconnectionstring" -g $rgname -n $twinupdatefunctionname
    ```

### Set the Time Series Insights event hub connection string

1. Get the Time Series Insights [event hub connection string](https://docs.microsoft.com/azure/event-hubs/event-hubs-get-connection-string), using the authorization rules you created previously for the Time Series Insights hub:

    ```powershell
    $tsiehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name tsi-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    ```

1. In your function app, create an app setting containing your connection string:

    ```powershell
    az functionapp config appsettings set --settings "EventHubAppSetting-tsi=$tsiehconnectionstring" -g $rgname -n $twinupdatefunctionname 
    ```

At this point, Azure Digital Twins should be sending the twin updates it receives to an Event Hub whose events are processed by the Azure Function. The Azure Function formats the events and publishes them to another Event Hub where they can be ingested by Time Series Insights.
