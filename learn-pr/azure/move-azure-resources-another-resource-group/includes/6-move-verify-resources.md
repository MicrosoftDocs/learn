You want to create a development resource group where you'll move development resources that are currently in the incorrect production resource group.

In this unit, you'll learn how to create resource groups and move your resources to other resource groups.

## Create a resource group

First you create the resource group where you're moving your resources.  This resource group will hold all of your resources. When you create the resource group, you'll provide a location. Your resource group can hold resources that are in different regions, but your chosen location is where the resource group metadata is held. You may need to choose a specific region for your resource groups to stay compliant with regulations, depending on where you are in the world.

You can't update your resources if the region where the resource group is hosted isn't available.
You create a resource group using the Azure portal, Azure PowerShell, Azure Resource Templates, or Azure CLI.
Below is an example showing how to create  your resource group using PowerShell.

Use the following command to create a resource group in PowerShell:

```powershell
PS> New-AzureRmResourceGroup -Name DevResourceGroup -Location "West US"
```
The above command will create a resource group in the West US region.

## Move resources

You can move your resources between subscriptions or between resource groups within the same subscription. When you start a move operation, the resource group holding your resources and the new destination resource group are locked. You can't do write or delete operations on the resource groups until the move operation ends. Your resources aren't affected but you can't add, delete, or update any resources in these resource groups. Also, your moved resources don't change location. For example, if you have a storage account in the East US region, and you move it to another resource group, it keeps its East US region location.

Use the Azure portal, Azure CLI, PowerShell, or Azure REST API to move your resources.

```powershell
# fetch your resource
$yourResource = Get-AzResource -ResourceGroupName ProductionResourceGroup -ResourceName DevelopmentVM
```

The above command will fetch the resource you want to move.

```powershell
# Move your resource
Move-AzResource -DestinationResourceGroupName DevResourceGroup -ResourceId $yourResource.ResourceId
```

The above command will move the resource to another resource group using the resource ID.

When the move operation finishes, you verify whether the resources have been moved to the new resource group. You can view the resource group, either through the Azure portal, or other tools like Azure PowerShell.

```powerShell
Get-AzureRmResource -ResourceGroupName DevResourceGroup | ft
```

The above Azure PowerShell command will get all the resources in your resource group. You'll see your moved resources in the returned list when the move completes successfully.

After the resources have been moved, you must update all the resource IDs you're using in any scripts and tools associated with your resources.
