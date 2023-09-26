

You can add, edit, or remove a policy by using any of the following methods:

* Azure portal
* Azure PowerShell
* Azure CLI
* REST APIs

The following are the steps and some examples for the Portal and Azure CLI.

## Azure portal

There are two ways to add a policy through the Azure portal: Azure portal List view, and Azure portal Code view.

### Azure portal List view

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Select **All resources** and then select your storage account.

1. Under **Data management**, select **Lifecycle management** to view or change your rules.

1. Select the **List view** tab.

1. Select **Add rule** and then fill out the **Action set** form fields. In the following example, blobs are moved to cool storage if they haven't been modified for 30 days.

1. Select **Filter set** to add an optional filter. Then, select Browse to specify a container and folder by which to filter.

1. Select **Review + add** to review the policy settings.

1. Select **Add** to add the new policy.

### Azure portal Code view

1. Follow the first three steps in the **List view** section. 

1. Select the **Code view** tab. The following JSON is an example of a policy that  moves a block blob whose name begins with *log* to the cool tier if it has been more than 30 days since the blob was modified.

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

1. Select **Save**.

## Azure CLI

To add a lifecycle management policy with Azure CLI, write the policy to a JSON file, then call the `az storage account management-policy create` command to create the policy.

```azurecli
az storage account management-policy create \
    --account-name <storage-account> \
    --policy @policy.json \
    --resource-group <resource-group>
```

A lifecycle management policy must be read or written in full. Partial updates aren't supported.
