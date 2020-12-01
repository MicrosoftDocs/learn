---
metadata:
  title: Create, configure, and deploy an Azure Function
  description: This unit guides you on creating, configuring, and deploying an Azure function to receive data from Azure Digital Twins to Time Series Insights 
  ms.date: 11/30/2020
  author: raniabayoumy
  ms.author: rabayoum
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: Create, configure, and deploy an Azure Function
durationInMinutes: 12
---

Next, you'll create an Event Hubs-triggered function inside a function app.
This function will convert those twin update events from their original form as JSON Patch documents to JSON objects, containing only updated and added values from your twins.

1. Create an Azure Function by running the following command in PowerShell:

    ```powershell-interactive
    az functionapp create --resource-group $rgname --consumption-plan-location $location --runtime dotnet --functions-version 3 --name $twinupdatefunctionname --storage-account  $functionstorage
    ```

1. Add application configuration that stores the connection strings needed by the Azure Function:

    ```powershell-interactive
    $adtehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name twins-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    az functionapp config appsettings set --settings "EventHubAppSetting-Twins=$adtehconnectionstring" -g $rgname -n $twinupdatefunctionname
    ```

## Create an Azure Functions app in Visual Studio Code for Event Hub

Use Visual Studio Code to create a local Azure Functions project. Later in this unit, you'll publish your function code to Azure.

1. Choose the Azure icon in the Activity bar, then in the Azure: Functions area, select the Create new project icon.

    :::image type="content" source="../media/adt-create-azure-function-vsc.png" alt-text="Screenshot showing how to create a new Azure function project in Visual Studio Code":::

    When prompted, provide the following information:

    - **Select a language for your function project:** Choose C#
    - **Select a template for your project's first function:** Choose "EventHubTrigger"
    - **Provide a function name:** Type "TSIFunction"
    - **Provide a namespace:** Type "TSIFunctionsApp"
    - **Select setting from local.settings.json:** Hit Enter
    - **Select subscription:** Select the subscription you're using
    - **Select an event hub namespace:** Choose the event hub namespace that begins with "adthol"
    - **Select an event hub:** Choose "twins-event-hub"
    - **Select an event hub policy:** Choose "EHPolicy"
    - **When prompted for a storage account choose:** Skip for now
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

1. In the VSCode function extension, click on on **Deploy to Function App...**

    :::image type="content" source="../media/adt-deploy-azure-function-vsc.png" alt-text="Screenshot showing how to deploy an Azure function app in Visual Studio Code":::

    - **Select subscription:** Choose your subscription

    - **Select Function App in Azure:** Choose the function that ends in "twinupdatefunction"

    - If prompted to overwrite a previous deployment, click "Deploy"

    :::image type="content" source="../media/adt-overwrite-azure-function-vsc.png" alt-text="Screenshot of a Visual Studio Code prompt to overwrite the previous Azure function deployment":::

1. When the deployment finishes, you'll be prompted to Start Streaming Logs:

    :::image type="content" source="../media/adt-azure-function-stream-logs-vsc.png" alt-text="Screenshot of a Visual Studio Code prompt to stream logs for the deployed Azure function":::

    - Click on Stream Logs to see the Twin Update messages received by the Azure Function

        - Alternatively, you can Stream Logs at a later time by right-clicking on the Azure Function in VS Code and choosing "Start Streaming Logs"

        :::image type="content" source="../media/adt-azure-function-stream-logs-later-vsc.png" alt-text="Screenshot showing how to stream logs for an Azure function after it's been deployed in Visual Studio Code":::

At this point, Azure Digital Twins should be sending the Twin Updates it receives to an Event Hub whose events are processed by the Azure Function. The Azure Function formats the events and publishes them to another Event Hub where they can be ingested by Time Series Insights.

## Send telemetry to an event hub

You'll now create a second event hub and configure your function to stream its output to that event hub. This event hub will then be connected to Time Series Insights.

### Create an event hub

To create the second event hub, use the following PowerShell instructions:

1. Prepare your Event Hubs namespace and resource group name from ear-lier in this module

1. Create a new event hub:

    ```powershell-interactive
    # Create an event hub. Specify a name "tsi-event-hub" for the event hub. 
    az eventhubs eventhub create --name "tsi-event-hub" --resource-group $rgname --namespace-name $ehnamespace
    ```

1. Create an [authorization rule](https://docs.microsoft.com/en-us/cli/azure/eventhubs/eventhub/authorization-rule?view=azure-cli-latest#az-eventhubs-eventhub-authorization-rule-create) with send and receive permissions:

    ```powershell-interactive
    # Create an authorization rule. Specify a name for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group $rgname --namespace-name $ehnamespace --eventhub-name "tsi-event-hub" --name EHPolicy
    ```

## Configure your function

Next, you'll need to set environment variables in your function app from earlier, containing the connection strings for the event hubs you've created:

1. Get the Twins [event hub connection string](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-get-connection-string), using the authorization rules you [created previously](#create-an-event-hub) for the Twins hub:

    ```powershell-interactive
    $adtehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name twins-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    ```

1. Use the connection string you get as a result to create an app setting in your function app that contains your connection string:

    ```powershell-interactive
    az functionapp config appsettings set --settings "EventHubAppSetting-Twins=$adtehconnectionstring" -g $rgname -n $twinupdatefunctionname
    ```

### Set the Time Series Insights event hub connection string

1. Get the TSI [event hub connection string](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-get-connection-string), using the authorization rules you [created previously](#create-an-event-hub) for the Time Series Insights hub:

    ```powershell-interactive
    $tsiehconnectionstring=$(az eventhubs eventhub authorization-rule keys list --resource-group $rgname --namespace-name $ehnamespace --eventhub-name tsi-event-hub --name EHPolicy --query primaryConnectionString -o tsv)
    ```

1. In your function app, create an app setting containing your connection string:

    ```powershell-interactive
    az functionapp config appsettings set --settings "EventHubAppSetting-TSI=$tsiehconnectionstring" -g $rgname -n $twinupdatefunctionname 
    ```

At this point, Azure Digital Twins should be sending the Twin Updates it receives to an Event Hub whose events are processed by the Azure Function. The Azure Function formats the events and published them to another Event Hub where they can be ingested by Time Series Insights.
