You can add, edit, or remove a policy by using any of the following methods:

* Azure portal
* Azure PowerShell
* Azure CLI
* REST APIs

Below are the steps and some examples for the Portal and Azure CLI.

## Azure portal

There are two ways to add a policy through the Azure portal: Azure portal List view, and Azure portal Code view.

### Azure portal List view

1. Sign in to the [Azure portal](https://portal.azure.com).

2. Select **All resources** and then select your storage account.

3. Under **Blob Service**, select **Lifecycle management** to view or change your rules.

4. Select the **List view** tab.

5. Select **Add rule** and then fill out the **Action set** form fields. In the following example, blobs are moved to cool storage if they haven't been modified for 30 days.

6. Select **Filter set** to add an optional filter. Then, select Browse to specify a container and folder by which to filter.

7. Select **Review + add** to review the policy settings.

8. Select **Add** to add the new policy.

### Azure portal Code view

1. Follow the first three steps above in the **List view** section. 

2. Select the **Code view** tab. The following JSON is an example of a policy that can be pasted into the **Code view** tab.

    ```json
    {
    "rules": [
        {
        "name": "ruleFoo",
        "enabled": true,
        "type": "Lifecycle",
        "definition": {
            "filters": {
            "blobTypes": [ "blockBlob" ],
            "prefixMatch": [ "container1/foo" ]
            },
            "actions": {
            "baseBlob": {
                "tierToCool": { "daysAfterModificationGreaterThan": 30 },
                "tierToArchive": { "daysAfterModificationGreaterThan": 90 },
                "delete": { "daysAfterModificationGreaterThan": 2555 }
            },
            "snapshot": {
                "delete": { "daysAfterCreationGreaterThan": 90 }
            }
            }
        }
        }
    ]
    }
    ```

3. Select **Save**.

## Azure CLI

To add a lifecycle management policy with Azure CLI, write the policy to a JSON file, then call the `az storage account management-policy create` command to create the policy.

```azurecli
az storage account management-policy create \
    --account-name <storage-account> \
    --policy @policy.json \
    --resource-group <resource-group>
```

A lifecycle management policy must be read or written in full. Partial updates are not supported.
