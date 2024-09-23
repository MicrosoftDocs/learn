You can add, edit, or remove a policy by using any of the following methods:

* Azure portal
* Azure PowerShell
* Azure CLI
* REST APIs

The following are the steps and some examples for the Portal and Azure CLI.

## Azure portal

There are two ways to add a policy through the Azure portal: Azure portal List view, and Azure portal Code view. Following is an example of how to add a policy in the Azure portal Code view.

### Azure portal Code view

1. In the Azure portal, navigate to your storage account.
1. Under **Data management**, select **Lifecycle Management** to view or change lifecycle management policies.
1. Select the **Code View** tab. On this tab, you can define a lifecycle management policy in JSON.

The following JSON is an example of a policy that  moves a block blob whose name begins with *log* to the cool tier if it has been more than 30 days since the blob was modified.

```json
{
  "rules": [
    {
      "enabled": true,
      "name": "move-to-cool",
      "type": "Lifecycle",
      "definition": {
        "actions": {
          "baseBlob": {
            "tierToCool": {
              "daysAfterModificationGreaterThan": 30
            }
          }
        },
        "filters": {
          "blobTypes": [
            "blockBlob"
          ],
          "prefixMatch": [
            "sample-container/log"
          ]
        }
      }
    }
  ]
}
```

## Azure CLI

To add a lifecycle management policy with Azure CLI, write the policy to a JSON file, then call the `az storage account management-policy create` command to create the policy.

```azurecli
az storage account management-policy create \
    --account-name <storage-account> \
    --policy @policy.json \
    --resource-group <resource-group>
```

A lifecycle management policy must be read or written in full. Partial updates aren't supported.
