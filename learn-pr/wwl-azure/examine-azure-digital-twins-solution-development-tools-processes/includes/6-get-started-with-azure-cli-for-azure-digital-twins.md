In addition to managing your Azure Digital Twins instance in the Azure portal, Azure Digital Twins has a command set for the Azure CLI that you can use to perform most major actions with the service, including:

 -  Managing an Azure Digital Twins instance.
 -  Managing models.
 -  Managing digital twins.
 -  Managing twin relationships.
 -  Configuring endpoints.
 -  Managing routes.
 -  Configuring security via Azure role-based access control (Azure RBAC).

The command set is called `az dt`, and is part of the Azure IoT extension for Azure CLI. You can view the full list of commands and their usage as part of the reference documentation for the `az iot` command set: [az dt command reference](/cli/azure/ext/azure-iot/dt).

> [!NOTE]
> The `az dt` extension for Azure CLI requires Azure CLI version 2.0.70 or higher. If you're using the Azure CLI with PowerShell, the extension package requires that your Azure CLI version to be 2.3.1 or above.

In addition to generally managing your instance, the CLI is also a useful tool for deployment and validation.

 -  The control plane commands can be used to make the deployment of a new instance repeatable or automated.
 -  The data plane commands can be used to quickly check values in your instance, and verify that operations completed as expected.

## Examine Azure CLI command examples

There are currently over 50 Azure CLI commands available for Azure Digital Twins (az dt) that enable you to manage the service instance, endpoints, models, network, role-assignments, routes, and twins (including queries, components, relationships, and telemetry).

The following sections take a closer look at specific Azure CLI commands that you may encounter.

### az dt create

The following command syntax can be used to create or update an Azure Digital Twins instance:

```
az dt create --dt-name
            --resource-group
            [--assign-identity {false, true}]
            [--location]
            [--pna {Disabled, Enabled}]
            [--role]
            [--scopes]
            [--tags]

```

For example:

 -  To create an Azure Digital Twins instance in a target resource group using the resource group location. `az dt create -n {instance_name} -g {resouce_group}`
 -  To create an Azure Digital Twins instance in the target resource group with a system managed identity. `az dt create -n {instance_name} -g {resouce_group} --assign-identity`
 -  To create an Azure Digital Twins instance in the target resource group with a system managed identity then assign the identity to one or more scopes (space-separated) with the role of Contributor. `az dt create -n {instance_name} -g {resouce_group} --assign-identity --scopes "/subscriptions/a12345ea-bb21-994d-2263-c716348e32a1/resourceGroups/ProResourceGroup/providers/Microsoft.EventHub/namespaces/myEventHubNamespace/eventhubs/myEventHub" "/subscriptions/a12345ea-bb21-994d-2263-c716348e32a1/resourceGroups/ProResourceGroup/providers/Microsoft.ServiceBus/namespaces/myServiceBusNamespace/topics/myTopic"`

### az dt twin create

The following command syntax can be used to create a digital twin on an instance.

```
az dt twin create --dt-name
                  --dtmi
                  --twin-id
                  [--if-none-match]
                  [--properties]
                  [--resource-group]

```

> [!NOTE]
> \`\`\`--properties\`\`\` can be inline JSON or file path. Also, \`\`\`--properties\`\`\` are required for twins that contain components.

For example:

 -  Create a digital twin from an existing (prior-created) model. `az dt twin create -n {instance_or_hostname} --dtmi "dtmi:com:example:Room;1" --twin-id {twin_id}`
 -  Create a digital twin from an existing (prior-created) model. Instantiate with property values. `az dt twin create -n {instance_or_hostname} --dtmi "dtmi:com:example:DeviceInformation;1" --twin-id {twin_id} --properties '{"manufacturer": "Microsoft"}'`

### az dt twin query

The following command syntax can be used to query the digital twins of an instance. Azure CLI queries support traversing relationships and filtering by property values.

```
az dt twin query --dt-name
                 --query-command
                 [--cost {false, true}]
                 [--resource-group]

```

For example:

 -  Query all digital twins in target instance and project all attributes. Also show cost in query units. `az dt twin query -n {instance_or_hostname} -q "select * from digitaltwins" --show-cost`
 -  Query by model and project all attributes. `az dt twin query -n {instance_or_hostname} -q "select * from digitaltwins T where IS_OF_MODEL(T, 'dtmi:com:example:Room;2')"`
