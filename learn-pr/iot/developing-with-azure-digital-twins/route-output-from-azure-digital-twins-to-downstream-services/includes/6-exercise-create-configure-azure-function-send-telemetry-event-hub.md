In this unit, you create an Azure Function, send telemetry to an IoT hub, and configure your function.

## Create an Azure Function

Next, you'll create an Event Hubs-triggered function inside a function app.

This function will convert those twin update events from their original form as JSON Patch documents to JSON objects, containing only updated and added values from your twins.

For more information about using Event Hubs with Azure functions, see [Azure Event Hubs trigger for Azure Functions](/azure/azure-functions/functions-bindings-event-hubs-trigger?tabs=csharp).

1. Inside your published function app, replace the function code with the following code.

    ```cs
    using Microsoft.Azure.EventHubs;
    using Microsoft.Azure.WebJobs;
    using Microsoft.Extensions.Logging;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using System.Threading.Tasks;
    using System.Text;
    using System.Collections.Generic;

    namespace SampleFunctionsApp
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

From here, the function will then send the JSON objects it creates to a second event hub, which you will connect to Time Series Insights.

Later, you'll also set some environment variables that this function will use to connect to your own event hubs.

## Send telemetry to an event hub

You will now create a second event hub, and configure your function to stream its output to that event hub. This event hub will then be connected to Time Series Insights.

### Create an event hub

To create the second event hub, you can either use the Azure CLI instructions below, or use the Azure portal: [Quickstart: Create an event hub using Azure portal](/azure/event-hubs/event-hubs-create).

1. Prepare your Event Hubs namespace and resource group name from earlier in this article

1. Create a new event hub

    ```cli
    # Create an event hub. Specify a name for the event hub. 
    az eventhubs eventhub create --name <name for your TSI event hub> --resource-group <resource group name from earlier> 
    --namespace-name <Event Hubs namespace from earlier>
    ```

1. Create an authorization rule with send and receive permissions

    ```cli
    # Create an authorization rule. Specify a name for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group <resource group name> --namespace-name <Event Hubs namespace from earlier> --eventhub-name <TSI event hub name from above> --name <name for your TSI auth rule>
    ```

### Configure your function

Next, you'll need to set environment variables in your function app from earlier, containing the connection strings for the event hubs you've created.

To set the Twins event hub connection string:

1. Get the Twins [event hub connection string](https://docs.microsoft.com/azure/event-hubs/event-hubs-get-connection-string), using the authorization rules you created above for the Twins hub.

    ```cli
    az eventhubs eventhub authorization-rule keys list --resource-group <resource group name> --namespace-name <Event Hubs namespace> --eventhub-name <Twins event hub name from earlier> --name <Twins auth rule from earlier>
    ```

1. Use the connection string you get as a result to create an app setting in your function app that contains your connection string:

    ```cli
    az functionapp config appsettings set --settings "EventHubAppSetting-Twins=<Twins event hub connection string>" -g <resource group> -n <your App Service (function app) name>
    ```

To set the Time Series Insights event hub connection string:

1. Get the TSI event hub connection string, using the authorization rules you created above for the Time Series Insights hub:

    ```cli
    az eventhubs eventhub authorization-rule keys list --resource-group <resource group name> --namespace-name <Event Hubs namespace> --eventhub-name <TSI event hub name> --name <TSI auth rule>
    ```

1. In your function app, create an app setting containing your connection string:

    ```cli
    az functionapp config appsettings set --settings "EventHubAppSetting-TSI=<TSI event hub connection string>" -g <resource group> -n <your App Service (function app) name>
    ```

Before moving on, let's take a short knowledge check.