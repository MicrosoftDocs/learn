In this section, you'll be creating an Azure Digital Twins event route that will direct these update events to Azure Event Hubs for further processing through an Azure Function.

1. Create an event hub namespace, which will receive events from your Azure Digital Twins instance:

    ```powershell
    #Create an Event Hubs namespace leveraging the pre-defined variables.
    $ehnamespace = $dtname + "ehnamespace"

    az eventhubs namespace create --name $ehnamespace --resource-group $rgname -l $location
    ```

1. Create an event hub within the namespace:

    ```powershell
    # Create an event hub to receive twin change events. Specify a name "twins-event-hub" for the event hub.
    az eventhubs eventhub create --name "twins-event-hub" --resource-group $rgname --namespace-name $ehnamespace 
    ```

1. Create an [authorization rule](https://docs.microsoft.com/en-us/cli/azure/eventhubs/eventhub/authorization-rule?view=azure-cli-latest#az-eventhubs-eventhub-authorization-rule-create) with send and receive permissions:

    ```powershell
    # Create an authorization rule. Specify a name "twins-event-hub" for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group $rgname --namespace-name $ehnamespace --eventhub-name "twins-event-hub" --name EHPolicy 
    ```

1. Create an Azure Digital Twins endpoint that links your event hub to your Azure Digital Twins instance:

    ```powershell
    az dt endpoint create eventhub --endpoint-name EHEndpoint --eventhub-resource-group $rgname --eventhub-namespace $ehnamespace --eventhub "twins-event-hub" --eventhub-policy EHPolicy -n $dtname
    ```

1. Create a [route](https://docs.microsoft.com/en-us/azure/digital-twins/concepts-route-events#create-an-event-route) in Azure Digital Twins to send twin update events to your endpoint. The filter in this route will only allow twin update messages to be passed to your endpoint:

    ```powershell
    az dt route create -n $dtname --endpoint-name EHEndpoint --route-name EHRoute --filter "type = 'Microsoft.DigitalTwins.Twin.Update'"
    ```

    > [!NOTE]
    > There is currently a **known issue** in Cloud Shell affecting these command groups: `az dt route`, `az dt model`, `az dt twin`.
    >
    > To resolve, either run `az login` in Cloud Shell prior to running the command, or use the [local CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&preserve-view=true) instead of Cloud Shell. For more information on this issue, see the [article for troubleshooting known issues in Azure Digital Twins](https://docs.microsoft.com/azure/digital-twins/troubleshoot-known-issues#400-client-error-bad-request-in-cloud-shell).

1. Before moving on, take note of your Event Hubs namespace and resource group, as you'll use them again to create another event hub later in this module.
