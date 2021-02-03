In this unit, you'll create an Azure Digital Twins event route that will direct the update events to Azure Event Hubs for further processing via an Azure function.

1. Create an event hub namespace, which will receive events from your Azure Digital Twins instance:

    ```powershell
    # Create an event hub namespace leveraging the predefined variables.
    $ehnamespace = $dtname + "ehnamespace"

    az eventhubs namespace create --name $ehnamespace --resource-group $rgname -l $location
    ```

1. Create an event hub within the namespace:

    ```powershell
    # Create an event hub to receive twin change events. Specify the name "twins-event-hub" for the event hub.
    az eventhubs eventhub create --name "twins-event-hub" --resource-group $rgname --namespace-name $ehnamespace 
    ```

1. Create an [authorization rule](https://docs.microsoft.com/cli/azure/eventhubs/eventhub/authorization-rule?view=azure-cli-latest#az-eventhubs-eventhub-authorization-rule-create) that has send and receive permissions:

    ```powershell
    # Create an authorization rule. Specify the name "twins-event-hub" for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group $rgname --namespace-name $ehnamespace --eventhub-name "twins-event-hub" --name EHPolicy 
    ```

1. Create an Azure Digital Twins endpoint that links your event hub to your Azure Digital Twins instance:

    ```powershell
    az dt endpoint create eventhub --endpoint-name EHEndpoint --eventhub-resource-group $rgname --eventhub-namespace $ehnamespace --eventhub "twins-event-hub" --eventhub-policy EHPolicy -n $dtname
    ```

1. Create a [route](https://docs.microsoft.com/azure/digital-twins/concepts-route-events#create-an-event-route) in Azure Digital Twins to send twin update events to your endpoint. The filter in this route will allow only twin update messages to be passed to your endpoint:

    ```powershell
    az dt route create -n $dtname --endpoint-name EHEndpoint --route-name EHRoute --filter "type = 'Microsoft.DigitalTwins.Twin.Update'"
    ```

    > [!NOTE]
    > There's a known issue in Azure Cloud Shell that affects these command groups: `az dt route`, `az dt model`, `az dt twin`.
    >
    > To resolve this issue, either run `az login` in Cloud Shell before you run the command or use the [local CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&preserve-view=true) instead of Cloud Shell. For more information, see [Known issues in Azure Digital Twins](https://docs.microsoft.com/azure/digital-twins/troubleshoot-known-issues#400-client-error-bad-request-in-cloud-shell).

1. Before moving on, note your Event Hubs namespace and resource group. You'll use them again to create another event hub later in this module.
