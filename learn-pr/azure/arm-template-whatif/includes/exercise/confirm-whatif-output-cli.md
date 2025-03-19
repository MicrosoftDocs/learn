---
author: mumian
ms.topic: include
ms.date: 02/04/2025
ms.author: jgao
---
Your output will look similar to the following:

# [Screenshot](#tab/screenshpt)

:::image type="content" source="../../media/4-confirm-cli.png" alt-text="Screenshot of the Azure CLI showing the output from the deployment confirm operation." :::

# [Text](#tab/textoutput)

```output
Note: The result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues

Resource and property changes are indicated with this symbol:
  - Delete

The deployment will update the following scope:

Scope: /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/learn-00000000-0000-0000-0000-000000000000

  - Microsoft.Network/virtualNetworks/vnet-001

      id:              "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/learn-00000000-0000-0000-0000-000000000000/providers/Microsoft.Network/virtualNetworks/vnet-001"
      location:        "westus"
      name:            "vnet-001"
      tags.CostCenter: "12345"
      tags.Owner:      "Team A"
      type:            "Microsoft.Network/virtualNetworks"

  - Microsoft.Storage/storageAccounts/cloudshell496089001

      id:                     "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/learn-00000000-0000-0000-0000-000000000000/providers/Microsoft.Storage/storageAccounts/cloudshell496089001"
      kind:                   "Storage"
      location:               "southcentralus"
      name:                   "cloudshell496089001"
      sku.name:               "Standard_GRS"
      sku.tier:               "Standard"
      tags.ms-resource-usage: "azure-cloud-shell"
      tags.x-created-by:      "productsandboxes"
      type:                   "Microsoft.Storage/storageAccounts"

Resource changes: 2 to delete.

Are you sure you want to execute the deployment? (y/n):
```

---

Note how the last line of the output is a confirmation. It's asking you to select **y** or **n** to proceed.
