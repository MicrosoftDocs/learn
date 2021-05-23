Your output will look similar to the following text:

```output
Argument '--confirm-with-what-if' is in preview. It may be changed/removed in a future release.
Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with this symbol:
    - Delete

The deployment will update the following scope:

Scope: /subscriptions/11112222-3333-4444-5555-111122223333/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

    - Microsoft.Network/virtualNetworks/vnet-001

        id:              "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001"
        location:        "westus"
        name:            "vnet-001"
        tags.CostCenter: "12345"
        tags.Owner:      "Team A"
        type:            "Microsoft.Network/virtualNetworks"

Resource changes: 1 to delete.

Are you sure you want to execute the deployment? (y/n):
```
