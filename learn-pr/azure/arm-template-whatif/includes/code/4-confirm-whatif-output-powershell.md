The output will be similar to the following text:

```output
Resource and property changes are indicated with this symbol:
    - Delete

The deployment will update the following scope:

Scope: /subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

    - Microsoft.Network/virtualNetworks/vnet-001

        id:              "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001"
        location:        "westus"
        name:            "vnet-001"
        tags.CostCenter: "12345"
        tags.Owner:      "Team A"
        type:            "Microsoft.Network/virtualNetworks"

    - Microsoft.Storage/storageAccounts/cloudshell666004860

        id:
"/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Storage/storageAccounts/cloudshell666004860"
        kind:                   "Storage"
        location:               "eastus"
        name:                   "cloudshell666004860"
        sku.name:               "Standard_GRS"
        sku.tier:               "Standard"
        tags.ms-resource-usage: "azure-cloud-shell"
        tags.x-created-by:      "freelearning"
        type:                   "Microsoft.Storage/storageAccounts"

Resource changes: 2 to delete.

Are you sure you want to execute the deployment?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```
