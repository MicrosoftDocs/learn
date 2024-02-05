---
author: mumian
ms.topic: include
ms.date: 05/22/2021
ms.author: jgao
---
# [Screenshot](#tab/screenshpt)

:::image type="content" source="../../media/4-whatif-powershell.png" alt-text="Screenshot of Azure PowerShell showing the output from the what-if operation." :::

# [Text](#tab/textoutput)

```output
Note: The result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify
  * Ignore

The deployment will update the following scope:

Scope: /subscriptions/b4219936-de68-4fe4-8393-4bd7d7f7fe99/resourceGroups/learn-31a62588-9867-48a4-9e6b-666a7bdbefff

  ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
    - tags.Owner:                    "Team A"
    + properties.enableVmProtection: false
    ~ properties.addressSpace.addressPrefixes: [
      - 0: "10.0.0.0/16"
      + 0: "10.0.0.0/15"
      ]
    ~ properties.subnets: [
      - 0:

          name:                     "subnet001"
          properties.addressPrefix: "10.0.0.0/24"

      ]

  * Microsoft.Storage/storageAccounts/cloudshell843483168

Resource changes: 1 to modify, 1 to ignore.
```

---
