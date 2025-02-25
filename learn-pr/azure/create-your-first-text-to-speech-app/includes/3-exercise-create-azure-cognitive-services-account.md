In the previous unit, you learned how to use the Azure portal to create an Azure AI services resource.

In this exercise, you'll create an Azure AI services resource using the Azure CLI.

The applications that you'll create in the upcoming exercises use this resource to perform the text to speech operations.

<a name='create-an-azure-ai-services-resource'></a>

## Create an Azure AI services resource

1. In the Cloud Shell on the right, create a variable to hold the name of the resource group that was created for you when you activated the Learn sandbox:

    ```bash
    RESOURCEGROUP=<rgn>[sandbox resource group name]</rgn>
    ```

1. Create another variable to hold the region where your resource group is located:

    ```bash
    LOCATION=$(az group show --name $RESOURCEGROUP | jq -r '.location')
    ```

1. You'll need the location when you create your application, so use the following command to list the contents of the `$LOCATION` variable, then copy that value for later:

    ```bash
    echo $LOCATION
    ```

1. Create another variable to contain your resource name:

    ```bash
    ACCOUNT=learn-account-$RANDOM
    ```

1. Create your Azure AI services resource:

    ```azurecli
    az cognitiveservices account create \
        --name $ACCOUNT \
        --resource-group $RESOURCEGROUP \
        --kind AIServices \
        --sku S0 \
        --location $LOCATION \
        --yes
    ```

    In the preceding code:

    | Value | Description |
    | --- | --- |
    | **name** | Specifies the unique name for your Azure AI services resource. |
    | **resource-group** | Specifies the name of your resource group. |
    | **kind** | Specifies the resource type, which is *AIServices* for this exercise because we'll be creating a multi-service resource.<br/><br/>See `az cognitiveservices account list-kinds` for a list of account types. |
    | **sku** | Specifies the SKU for the resource.<br/><br/>See `az cognitiveservices account list-skus` for a list of resource SKUs.  |
    | **location** | Specifies the location for the resource. |
    | **yes** | Suppresses the prompt for terms confirmation. |

    This command should take a few seconds to complete, and you'll see a JSON response from Azure like the following example when the command finishes:

    ```json
    {
      "etag": "\"00000000-0000-0000-0000-000000000000\"",
      "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/learn-bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f/providers/Microsoft.CognitiveServices/accounts/learn-account-33333",
      "identity": null,
      "kind": "AIServices",
      "location": "westus",
      "name": "learn-account-33333",
      "properties": {
         ...
      },
      "resourceGroup": "learn-bbbb1b1b-cc2c-dd3d-ee4e-ffffff5f5f5f",
      "sku": {
        "capacity": null,
        "family": null,
        "name": "S0",
        "size": null,
        "tier": null
      },
      "tags": null,
      "type": "Microsoft.CognitiveServices/accounts"
    }
    ```

<a name='retrieve-the-keys-for-your-azure-ai-services-resource'></a>

## Retrieve the keys for your Azure AI services resource

When your Azure AI services resource has been created, use the following command to list the keys:

```azurecli
az cognitiveservices account keys list \
   --name $ACCOUNT \
   --resource-group $RESOURCEGROUP
```

You should see a JSON response like the following example:

```json
{
   "key1": "YourKey1",
   "key2": "YourKey2"
}
```

Copy the value for either key; you'll use that key when you create your application in a later exercise.
