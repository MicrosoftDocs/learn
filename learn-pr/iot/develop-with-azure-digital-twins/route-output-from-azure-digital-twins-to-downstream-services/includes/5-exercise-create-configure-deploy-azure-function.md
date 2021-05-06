Next, you'll create an Event Hubs-triggered function inside a function app. This function will convert twin update events from their original form as JSON Patch documents to JSON objects. The objects will contain only updated and added values from your twins.

## Create an Azure function

Run this command in PowerShell:

```powershell
az functionapp create --resource-group $rgname --consumption-plan-location $location --runtime dotnet --functions-version 3 --name $twinupdatefunctionname --storage-account  $functionstorage
```

## Create an Azure Functions app in Visual Studio Code

Use Visual Studio Code to create a local Azure Functions project. Later in this unit, you'll publish your function code to Azure.

1. Select the Azure icon in the Activity Bar. On the **Azure: Functions** menu, select the **Create new project** button:

    :::image type="content" source="../media/create-azure-function-visual-studio-code.png" alt-text="Screenshot that shows the Create new project button in Visual Studio Code.":::

1. Choose a directory location for your project workspace, and then click **Select**.

1. When prompted, provide the following information:

    - **Select a language for your function project:** Select **C#**.
    - **Select a template for your project's first function:** Select **EventHubTrigger**.
    - **Provide a function name:** Enter **TSIFunction**.
    - **Provide a namespace:** Enter **TSIFunctionsApp**.
    - **Select setting from local.settings.json:** Select **Enter**.
    - **Select subscription:** Select the subscription you're using.
    - **Select an event hub namespace:** Select the event hub namespace that ends with **twinsnamespace**.
    - **Select an event hub:** Select **twins-event-hub**.
    - **Select an event hub policy:** Select **EHPolicy**.
    - **When prompted for a storage account:** Select **Skip for now.**
    - **Select how you would like to open your project:** Select **Add to workspace**.

1. Open the TSIFunction.cs file and replace the code in it with this code:

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
    
                // Read values that are replaced or added.
                Dictionary<string, object> tsiUpdate = new Dictionary<string, object>();
                foreach (var operation in message["patch"]) {
                    if (operation["op"].ToString() == "replace" || operation["op"].ToString() == "add")
                    {
                        // Convert from JSON patch path to a flattened property for TSI.
                        // Example input: /Front/Temperature
                        //        output: Front.Temperature
                        string path = operation["path"].ToString().Substring(1);                    
                        path = path.Replace("/", ".");                    
                        tsiUpdate.Add(path, operation["value"]);
                    }
                }
                // Send an update if updates exist.
                if (tsiUpdate.Count>0){
                    tsiUpdate.Add("$dtId", myEventHubMessage.Properties["cloudEvents:subject"]);
                    await outputEvents.AddAsync(JsonConvert.SerializeObject(tsiUpdate));
                }
            }
        }
    }
    ```

1. In the Azure Functions Visual Studio Code extension, select **Deploy to Function App**:

    :::image type="content" source="../media/deploy-azure-function-visual-studio-code.png" alt-text="Screenshot that shows the Deploy to Function App button in Visual Studio Code.":::

   Provide the following information:

    - **Select subscription:** Select your subscription.
    - **Select Function App in Azure:** Select the function that ends in **twinupdatefunction**.
    - **If you get a message about overwriting a previous deployment:** Select **Deploy**:

    :::image type="content" source="../media/overwrite-azure-function-visual-studio-code.png" alt-text="Screenshot of a Visual Studio Code warning about overwriting the previous Azure function deployment.":::

1. When the deployment finishes, you'll be prompted to start streaming logs:

    :::image type="content" source="../media/azure-function-stream-logs-visual-studio-code.png" alt-text="Screenshot of a Visual Studio Code prompt to stream logs for the deployed Azure function.":::

    - Select **Stream logs** to see the twin update messages received by the Azure function.

    - Or, to stream logs at a later time, right-click the Azure function in Visual Studio Code and select **Start Streaming Logs**:

        :::image type="content" source="../media/azure-function-stream-logs-later-visual-studio-code.png" alt-text="Screenshot that shows how to stream logs for an Azure function in Visual Studio Code after the function is deployed.":::

## Send telemetry to an event hub

You'll now create a second event hub and configure your function to stream its output to that event hub. You'll then connect the event hub to Time Series Insights.

### Create an event hub

To create the second event hub, complete the following steps by using PowerShell:

1. Create a new event hub. Use the Event Hubs namespace and resource group name that you recorded earlier in this module.

    ```powershell
    # Create an event hub. Specify the name "tsi-event-hub" for the event hub. 
    az eventhubs eventhub create --name "tsi-event-hub" --resource-group $rgname --namespace-name $ehnamespace
    ```

1. Create an [authorization rule](https://docs.microsoft.com/cli/azure/eventhubs/eventhub/authorization-rule?view=azure-cli-latest#az-eventhubs-eventhub-authorization-rule-create) that has send and receive permissions:

    ```powershell
    # Create an authorization rule. Specify a name for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group $rgname --namespace-name $ehnamespace --eventhub-name "tsi-event-hub" --name EHPolicy
    ```

## Configure your function

Next, you'll need to set environment variables in your function app from earlier. The variables will contain the connection strings for the event hubs you've created.

### Set the twins event hub connection string

1. Get the twins [event hub connection string](https://docs.microsoft.com/azure/event-hubs/event-hubs-get-connection-string) by using the authorization rules you created in the previous section for the twins hub:

    ```powershell
    $adtehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name twins-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    ```

1. Use the returned connection string to create an app setting in your function app that contains your connection string:

    ```powershell
    az functionapp config appsettings set --settings "EventHubAppSetting-Twins=$adtehconnectionstring" -g $rgname -n $twinupdatefunctionname
    ```

### Set the Time Series Insights event hub connection string

1. Get the Time Series Insights [event hub connection string](https://docs.microsoft.com/azure/event-hubs/event-hubs-get-connection-string) by using the authorization rules you created earlier for the Time Series Insights hub:

    ```powershell
    $tsiehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name tsi-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    ```

1. In your function app, create an app setting that contains your connection string:

    ```powershell
    az functionapp config appsettings set --settings "EventHubAppSetting-tsi=$tsiehconnectionstring" -g $rgname -n $twinupdatefunctionname 
    ```

At this point, Azure Digital Twins should be sending the twin updates it receives to an event hub whose events are processed by the Azure function. The Azure function formats the events and publishes them to another event hub where they can be ingested by Time Series Insights.
