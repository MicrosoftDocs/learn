In this unit, you propagate data through the digital twin graph of your smart building. This process involves the resources shown in Flow B in this diagram:

:::image type="content" source="../media/2-3-4-building-scenario.png" alt-text="Graph showing data flowing from a device into Azure Digital Twins, then throughout Azure Digital Twins." border="true" lightbox="../media/2-3-4-building-scenario.png":::

Data flow follows this path:
1. The *Thermostat 67* twin produces a notification that its *Temperature* property changed. Azure Digital Twins routes this notification data to Event Grid.
1. Event Grid sends the notification data to another custom Azure function (*ADTToADT*).
1. The Azure function code uses the notification data to update connected twins as appropriate. In this case, it updates the *Temperature* property on the *Room21* twin, setting the value to match the *Temperature* value on the *Thermostat67* twin that the room contains.

## Create required resources

First, create the resources that are needed for this flow: the Event Grid topic and the Azure function.

### Create Event Grid topic

To create an Event Grid topic, return to the Cloud Shell and run the following Azure CLI command. Azure Digital Twins will route events to this Event Grid topic, and it will pass them along to the Azure function.

```azurecli
EVENT_GRID_TOPIC="event-grid-smart-building$RANDOM"
az eventgrid topic create --resource-group $RESOURCE_GROUP --name $EVENT_GRID_TOPIC --location $REGION
```

### Create Azure function

In this section, you create an Azure function that's notified when a twin is updated in Azure Digital Twins. The function uses that data to update other digital twins in the graph as needed.

Earlier in Unit 3, you created and configured a new function app, set up the function code project, and wrote one Azure function (which you then published to Azure). Now, as you prepare to write a second Azure function, you can reuse that same function app and code project. All you have to do is add the new function, and republish the project to the function app in Azure.

#### Write new function

Start by reopening your function app project from Unit 3, *DigitalTwinsTrainingApp.sln*, in Visual Studio.

Add a new function by selecting and holding (or right-clicking) **DigitalTwinsTrainingApp** in the Solution Explorer to open a list of options, expanding **Add**, and selecting **New Azure Function...**

:::image type="content" source="../media/4-add-function.png" alt-text="Screenshot of Visual Studio showing the New Azure Function option." lightbox="../media/4-add-function.png":::

Name your function **Function2** and select **Add**. Choose **Event Grid trigger**, and select **Add** again. This action opens a new template function file.

Next, fill in the code body of the function. 

Start by completing the following steps to set up the function and prepare it to work with Azure Digital Twins. These steps are the same as they were for the function in Unit 3.

1. Add these `using` statements to your file, so you can make the function asynchronous and access Azure functionality. (Other `using` statements will be added by Visual Studio automatically as you paste in code.)

    ```csharp
    using Azure;
    using System.Threading.Tasks;
    ```

1. Make these updates to the sample function that's been provided in the template. 
    1. The function has a default name of `Function2`. Rename it to `ADTToADT` to make it easier to recognize later.
    1. Remove `static` from the class declaration. 
    1. Make the function asynchronous, by changing the signature of the `Run` method from `public static void` to `public async Task`.

[!INCLUDE [Common Azure Digital Twins function setup steps](../../includes/azure-digital-twins-function.md)]

Next, add the unique functionality.

1. Still inside the `Run` method, set up an `if` statement to take action when the function receives an Event Grid event with data. This statement will be executed when Azure Digital Twins sends a twin update to the Azure function.

    ```csharp
    if (eventGridEvent != null && eventGridEvent.Data != null)
    {
        log.LogInformation(eventGridEvent.Data.ToString());
    }
    ```

1. In the body of the `if` statement, after the logger line, add the following code. This code snippet reads the incoming message from Azure Digital Twins to identify which twin has changed, and the data message describing *how* it changed.

    ```csharp
    string twinId = eventGridEvent.Subject.ToString();
    JObject message = (JObject)JsonConvert.DeserializeObject(eventGridEvent.Data.ToString());
    log.LogInformation($"Reading event from {twinId}: {eventGridEvent.EventType}: {message["data"]}");
    ```

    :::image type="content" source="../media/4-code-5.png" alt-text="Screenshot of code in Visual Studio, showing the reading additions to the if statement." lightbox="../media/4-code-5.png":::

1. Next inside the `if` statement, add some code to identify this twin's parent. This code uses the [GetIncomingRelationshipsAsync](/dotnet/api/azure.digitaltwins.core.digitaltwinsclient.getincomingrelationshipsasync) SDK method to list the relationships that target this twin, identify which one is of the *contains* type, and trace that relationship back to its source twin. 

    In the Azure Digital Twins graph that you set up in Unit 2 to represent the sample scenario, the *Thermostat67* twin's parent is *Room21*. This is represented by a *contains*-type relationship from *Room21* to *Thermostat67*.

    ```csharp
    // Find parent using incoming relationships
    AsyncPageable<IncomingRelationship> rels = client.GetIncomingRelationshipsAsync(twinId);

    string parentId = null;
    await foreach (IncomingRelationship ie in rels)
    {
        if (ie.RelationshipName == "contains")
            parentId = ie.SourceId;
    }
    ```

    :::image type="content" source="../media/4-code-6.png" alt-text="Screenshot of code in Visual Studio, showing the parent-finding additions to the if statement." lightbox="../media/4-code-6.png":::

1. Complete the `if` statement with the following code. If a parent twin was found, this code takes the operation from the incoming message about replacing the *Temperature* value of the child twin, and applies that operation to the parent, using the [UpdateDigitalTwinAsync](/dotnet/api/azure.digitaltwins.core.digitaltwinsclient.updatedigitaltwinasync) method.

    ```csharp
    if (parentId != null)
    {
        // Read properties whose values have been changed in each operation
        foreach (var operation in message["data"]["patch"])
        {
            string opValue = (string)operation["op"];
            //Restrict to "replace" operations
            if (opValue.Equals("replace"))
            {
                string propertyPath = ((string)operation["path"]);

                //Restrict to the "replace" operations that replaced Temperature
                if (propertyPath.Equals("/Temperature"))
                {
                    //Update parent
                    var updateTwinData = new JsonPatchDocument();
                    updateTwinData.AppendReplace(propertyPath, operation["value"].Value<float>());

                    log.LogInformation($"UpdateTwinPropertyAsync sending {updateTwinData}");
                    await client.UpdateDigitalTwinAsync(parentId, updateTwinData);
                }
            }
        }
    }
    ```

    :::image type="content" source="../media/4-code-7.png" alt-text="Screenshot of code in Visual Studio, showing the updating additions to the if statement." lightbox="../media/4-code-7.png":::

1. Save the completed function file.

>[!NOTE]
>You can see this full code sample in the same GitHub repository where you downloaded the device simulator: [ProcessDTRoutedData.cs (digital-twins-samples)](https://github.com/Azure-Samples/digital-twins-samples/blob/main/AdtSampleApp/SampleFunctionsApp/ProcessDTRoutedData.cs).

#### Publish Azure function

Follow these steps to publish your function to the Azure function app you created in Unit 3.

1. Select and hold (or right-click) **DigitalTwinsTrainingApp** in the Solution Explorer to open a list of options, and select **Publish...** This time, a tab opens to show the publish profile you've already created.
1. Select **Publish**.

    :::image type="content" source="../media/4-publish.png" alt-text="Screenshot of code in Visual Studio, showing the Publish button." lightbox="../media/4-publish.png":::

On a successful publish, Visual Studio indicates that the publish succeeded.

>[!TIP]
>If publish fails with an error that *The Publish URL ... is unreachable*, try re-running the following command in your Azure CLI to make sure Visual Studio is able to authenticate to carry out deployment. Then retry the publish.
> ```azurecli
> az resource update --resource-group $RESOURCE_GROUP --name scm --namespace Microsoft.Web --resource-type basicPublishingCredentialsPolicies --parent sites/$FUNCTION_APP_NAME --set properties.allow=true
> ```

## Connect resources

Now that your Event Grid and Azure function are created, you can set up the connections between these resources so that the Azure Digital Twins data can flow through them.

### Connect Azure Digital Twins to Event Grid

First, set up the data flow from Azure Digital Twins into Event Grid.

To create an Azure Digital Twins *endpoint*, run the following command in the Azure CLI. An endpoint is where a messaging resource (in this case, the Event Grid topic you created earlier in this unit) is registered with Azure Digital Twins.

```azurecli
ADT_ENDPOINT="eventgridendpoint"
az dt endpoint create eventgrid --dt-name $INSTANCE_NAME --eventgrid-resource-group $RESOURCE_GROUP --eventgrid-topic $EVENT_GRID_TOPIC --endpoint-name $ADT_ENDPOINT
```

Next, create an Azure Digital Twins *route* by running the following command. The route sends update events that happen in Azure Digital Twins to that endpoint.

```azurecli
ADT_ROUTE="eventgridroute"
az dt route create --dt-name $INSTANCE_NAME --endpoint-name $ADT_ENDPOINT --route-name $ADT_ROUTE --filter "type = 'Microsoft.DigitalTwins.Twin.Update'"
```

Now when a twin is updated in Azure Digital Twins, that update message is delivered to your Event Grid topic.

### Connect Event Grid to Azure function

Next, set up the data flow from Event Grid to the Azure function.

To subscribe your Azure function to your Event Grid topic, run the following Azure CLI command.

```azurecli
az eventgrid event-subscription create --name eventgridsmartbuildingsubscription --event-delivery-schema eventgridschema --source-resource-id /subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.EventGrid/topics/$EVENT_GRID_TOPIC --endpoint-type azurefunction --endpoint /subscriptions/$AZURE_SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Web/sites/$FUNCTION_APP_NAME/functions/ADTToADT
```

Now when twin update data arrives in your Event Grid topic, it gets sent along to your Azure function.

## Run simulation

Now it's time to run the data simulator and see the results!

On your machine, reopen a console window at the device simulator location (as a reminder, the device simulator is located in the sample folder you downloaded, at *digital-twins-samples-main\DeviceSimulator\DeviceSimulator*).

Start the device simulator project by running the following dotnet command in the console. Recall that in the sample scenario, this simulator represents a thermostat in the smart building that regularly emits temperature readings.

```cmd/sh
dotnet run
```

Like in Unit 3, the project starts running and sends simulated temperature telemetry messages every five seconds.

While this is running, query your Azure Digital Twins instance by returning to the Cloud Shell and running the following command. This is the same query from Unit 3 that returns the ID value and temperature of all twins in the instance.

```azurecli
az dt twin query -n $INSTANCE_NAME -q "select T.\$dtId, T.Temperature from digitaltwins T"
```

The results show that the *Room21* twin, which was originally created in Unit 2 with a *Temperature* value of 0.0, has an updated *Temperature* value that matches the temperature shown on the *Thermostat67* twin. The value is updating quickly, so repeat the query command a few more times to watch the value change.

:::image type="content" source="../media/4-twin-results.png" alt-text="Screenshot of Cloud Shell showing the output of the queries." lightbox="../media/4-twin-results.png":::

After you observe changing temperature values on both twins, you can stop the device simulator. These values show that the *Room21* twin is synchronized with the *Thermostat67* twin, updating its *Temperature* value whenever the thermostat's temperature is updated. 

>[!TIP]
>The Azure function you created will work this way for any number of child twins with changing *Temperature* values, updating their parent twins to match.

In the sample scenario, this means that your Azure Digital Twins building representation is fully connected, with device data from your thermostats propagating through the graph, keeping thermostat and room twins synchronized to the state of your real-world smart building.