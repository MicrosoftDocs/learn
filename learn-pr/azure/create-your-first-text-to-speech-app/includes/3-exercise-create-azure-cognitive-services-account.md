In the previous unit, you learned how to use the Azure portal to create an Azure Cognitive Services account.

In this exercise, you'll create an Azure Cognitive Services account using the Azure Command Line Interface (CLI).

The applications that you'll create in the upcoming exercises use this account to perform the text-to-speech operations.

## Create an Azure Cognitive Services account

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

1. Create another variable to contain your account name:

    ```bash
    ACCOUNT=learn-account-$RANDOM
    ```

1. Create your Azure Cognitive Services account:

    ```azurecli
    az cognitiveservices account create \
        --name $ACCOUNT \
        --resource-group $RESOURCEGROUP \
        --kind SpeechServices \
        --sku F0 \
        --location $LOCATION \
        --yes
    ```

    In the preceding code:

    | Value | Description |
    | --- | --- |
    | **name** | Specifies the unique name for your Azure Cognitive Services account. |
    | <nobr>**resource-group**</nobr> | Specifies the name of your resource group. |
    | **kind** | Specifies the account type, which is _SpeechServices_ for this exercise because we'll be creating a text-to-speech application.<br /><br />See `az cognitiveservices account list-kinds` for a list of account types. |
    | **sku** | Specifies the SKU for the account, which is the free _F0_ tier for this exercise.<br /><br />See `az cognitiveservices account list-skus` for a list of account SKUs.  |
    | **location** | Specifies the location for the account. |
    | **yes** | Suppresses the prompt for terms confirmation. |

    This command should take a few seconds to complete, and you'll see a JSON response from Azure like the following example when the command finishes:

    ```json
    {
      "etag": "\"00000000-0000-0000-0000-000000000000\"",
      "id": "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/learn-22222222-2222-2222-2222-222222222222/providers/Microsoft.CognitiveServices/accounts/learn-account-33333",
      "identity": null,
      "kind": "SpeechServices",
      "location": "westus",
      "name": "learn-account-33333",
      "properties": {
         ...
      },
      "resourceGroup": "learn-22222222-2222-2222-2222-222222222222",
      "sku": {
        "capacity": null,
        "family": null,
        "name": "F0",
        "size": null,
        "tier": null
      },
      "tags": null,
      "type": "Microsoft.CognitiveServices/accounts"
    }
    ```

## Retrieve the keys for your Azure Cognitive Services account

When your Azure Cognitive Services account has been created, use the following command to list the keys:

```azurecli
az cognitiveservices account keys list \
   --name $ACCOUNT \
   --resource-group $RESOURCEGROUP
```

You should see a JSON response like the following example:

```json
{
   "key1": "0123456789abcdef0123456789abcdef",
   "key2": "fedcba9876543210fedcba9876543210"
}
```

Copy the value for either key; you'll use that key when you create your application in a later exercise.
