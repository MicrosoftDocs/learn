This unit provides instructions on how to scale infrastructure and worker roles in Azure App Service on Azure Stack Hub. We'll cover all the steps necessary for creating additional worker roles to support apps of any size.

Azure App Service on Azure Stack Hub supports free and shared worker tiers by default. To add other worker tiers, you need to add more worker roles.

Azure App Service on Azure Stack Hub deploys all roles using Virtual Machine Scale Sets and as such takes advantage of the scaling capabilities of this workload. Therefore, all scaling of the worker tiers is done via the App Service Admin.

## Add additional workers with PowerShell

1.  Set up the Azure Stack Hub admin environment in PowerShell
2.  Use this example to scale out the scale set.

```PowerShell
##### Scale out the AppService Role instances ######
# Set context to AzureStack admin.
Login-AzAccount -EnvironmentName AzureStackAdmin

## Name of the Resource group where AppService is deployed.
$AppServiceResourceGroupName = "AppService.local"

## Name of the ScaleSet : e.g. FrontEndsScaleSet, ManagementServersScaleSet, PublishersScaleSet , LargeWorkerTierScaleSet, MediumWorkerTierScaleSet, SmallWorkerTierScaleSet, SharedWorkerTierScaleSet
$ScaleSetName = "SharedWorkerTierScaleSet"

## TotalCapacity is sum of the instances needed at the end of operation.
## e.g. if your VMSS has 1 instance(s) currently and you need 1 more the TotalCapacity should be set to 2
$TotalCapacity = 2

# Get current scale set
$vmss = Get-AzVmss -ResourceGroupName $AppServiceResourceGroupName -VMScaleSetName $ScaleSetName
# Set and update the capacity
$vmss.sku.capacity = $TotalCapacity
Update-AzVmss -ResourceGroupName $AppServiceResourceGroupName -Name $ScaleSetName -VirtualMachineScaleSet $vmss

```

3.  Monitor the status of the new role instances in the App Service administration. To check the status of an individual role instance, click the role type in the list.

## Add other workers using the administrator portal

1.  Sign in to the Azure Stack Hub administrator portal as the service admin.
2.  Browse to **App Services**.
    
    :::image type="content" source="../media/scale-roles-image-1-5dfdecad.png" alt-text="App Service in Azure Stack Hub administrator portal.":::
    
3.  Click **Roles**. Here you see the breakdown of all App Service roles deployed.
4.  Right click on the row of the type you want to scale and then click **ScaleSet**
    
    :::image type="content" source="../media/scale-roles-image-2-d3cffd36.png" alt-text="ScaleSet App Service roles in Azure Stack Hub administrator portal.":::
    
5.  Click **Scaling**, select the number of instances you want to scale to, and then click **Save**.
    
    :::image type="content" source="../media/scale-roles-image-3-24f416c3.png" alt-text="Set instances to scale to in App Service Roles in Azure Stack Hub administrator portal.":::
    

6.  Azure App Service on Azure Stack Hub will now add the other virtual machines, configure them, install all the required software, and mark them as ready when this process is complete. This process can take approximately 80 minutes.
7.  You can monitor the progress of the readiness of the new roles by viewing the workers in the **Roles** blade.

After they're fully deployed and ready, the workers become available for users to deploy their workload onto them. The following screenshot shows an example of the multiple pricing tiers available by default. If there are no available workers for a particular worker tier, the option to choose the corresponding pricing tier is unavailable.

:::image type="content" source="../media/scale-roles-image-4-bed81fb8.png" alt-text="Pricing tiers for new App Service plan in Azure Stack Hub administrator portal.":::
