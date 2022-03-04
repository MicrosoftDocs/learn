Sometimes you may need to move resources to either a new subscription or a new resource group in the same subscription.

:::image type="content" source="../media/move-resources-1ce2912e.png" alt-text="Two subscriptions.":::


When moving resources, both the source group and the target group are locked during the operation. Write and delete operations are blocked on the resource groups until the move completes. This lock means you can't add, update, or delete resources in the resource groups. Locks don't mean the resources aren't available. For example, if you move a virtual machine to a new resource group, an application can still access the virtual machine.

## Limitations

Before beginning this process be sure to read the [Move operation support for resources](/azure/azure-resource-manager/management/move-support-resources) page. This page details what resources can be moved between resources group, subscriptions, and regions.

## Implementation

To move resources, select the resource group containing those resources, and then select the **Move** button. Select the resources to move and the destination resource group. Acknowledge that you need to update scripts.

:::image type="content" source="../media/move-resource-groups-aae58bce.png" alt-text="Screenshot of the move a resource page.":::


> [!NOTE]
> Just because a service can be moved doesn’t mean there aren’t restrictions. For example, you can move a virtual network, but you must also move its dependent resources, like gateways.
