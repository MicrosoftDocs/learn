In this section, you'll be creating an Azure Digital Twins event route that will direct these update events to Azure Event Hubs for further processing.

1. First, create an event hub namespace, which will receive events from your Azure Digital Twins instance.

    ```cli
    # Create an Event Hubs namespace. Specify a name for the Event Hubs namespace.
    az eventhubs namespace create --name <name for your Event Hubs namespace> --resource-group <resource group name> -l <region, for example: East US>
    ```

1. Create an event hub within the namespace.

    ```cli
    # Create an event hub to receive twin change events. Specify a name for the event hub.
    az eventhubs eventhub create --name <name for your Twins event hub> --resource-group <resource group name> --namespace-name <Event Hubs namespace from above>
    ```

1. Create an [authorization rule](https://docs.microsoft.com/cli/azure/eventhubs/eventhub/authorization-rule?view=azure-cli-latest#az-eventhubs-eventhub-authorization-rule-create) with send and receive permissions.

    ```cli
    # Create an authorization rule. Specify a name for the rule.
    az eventhubs eventhub authorization-rule create --rights Listen Send --resource-group <resource group name> --namespace-name <Event Hubs namespace from above> --eventhub-name <Twins event hub name from above> --name <name for your Twins auth rule>
    ```

1. Create an Azure Digital Twins endpoint that links your event hub to your Azure Digital Twins instance.

    ```cli
    az dt endpoint create eventhub --endpoint-name <name for your Event Hubs endpoint> --eventhub-resource-group <resource group name> --eventhub-namespace <Event Hubs namespace from above> --eventhub <Twins event hub name from above> --eventhub-policy <Twins auth rule from above> -n <your Azure Digital Twins instance name>
    ```

1. Create a route in Azure Digital Twins to send twin update events to your endpoint. The filter in this route will only allow twin update messages to be passed to your endpoint.

    > [!Note]
    > There is currently a known issue in Cloud Shell affecting these command groups: az dt route, az dt model, az dt twin.
    > To resolve, either run az login in Cloud Shell prior to running the command, or use the local CLI instead of Cloud Shell. For more detail on this, see Troubleshooting: Known issues in Azure Digital Twins.

    ```cli
    az dt route create -n <your Azure Digital Twins instance name> --endpoint-name <Event Hub endpoint from above> --route-name <name for your route> --filter "type = 'Microsoft.DigitalTwins.Twin.Update'"
    ```

Before moving on, take note of your Event Hubs namespace and resource group, as you'll use them later in this unit.