---
author: mumian
ms.topic: include
ms.date: 02/04/2025
ms.author: jgao
---
# [Screenshot](#tab/screenshpt)

:::image type="content" source="../../media/4-whatif-cli.png" alt-text="Screenshot of the Azure CLI showing the output from the what-if operation." :::

# [Text](#tab/textoutput)

```output
Note: The result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify
  * Ignore

The deployment will update the following scope:

Scope: /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/learn-00000000-0000-0000-0000-000000000000

  ~ Microsoft.Network/virtualNetworks/vnet-001 [2024-05-01]
    - properties.privateEndpointVNetPolicies: "Disabled"
    - tags.Owner:                             "Team A"
    + properties.enableVmProtection:          false
    ~ properties.addressSpace.addressPrefixes: [
      - 0: "10.0.0.0/16"
      + 0: "10.0.0.0/15"
      ]
    ~ properties.subnets: [
      - 0:

          name:                                         "subnet001"
          properties.addressPrefix:                     "10.0.0.0/24"
          properties.privateEndpointNetworkPolicies:    "Disabled"
          properties.privateLinkServiceNetworkPolicies: "Enabled"

      ]

  * Microsoft.Storage/storageAccounts/cloudshell496089001

Resource changes: 1 to modify, 1 to ignore.
```

---
