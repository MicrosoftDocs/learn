In this exercise, you’ll use the Azure portal to create a resource. The focus of the exercise is observing how Azure resource groups populate with created resources.

> [!IMPORTANT]
> You have the opportunity to create a resource group when you create the virtual machine. If you name the resource group the same as the recommended name, it makes clean-up easier at the end of the exercise.

## Task 1: Create a virtual machine

In this task, you’ll create a virtual machine using the Azure portal.

1.  Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
2.  Select Create a resource &gt; Compute &gt; Virtual Machine &gt; Create.
3.  The Create a virtual machine pane opens to the basics tab.
4.  Verify or enter the following values for each setting. If a setting isn’t specified, leave the default value.
    
    **Basics tab**
    
    | **Setting**                  | **Value**                                                  |
    | ---------------------------- | ---------------------------------------------------------- |
    | Subscription                 | Select the subscription you want to use for the exercise.  |
    | Resource group               | Select Create new and enter `IntroAzureRG` and select OK   |
    | Virtual machine name         | `my-VM`                                                    |
    | Region                       | Leave default                                              |
    | Availability options         | Leave default                                              |
    | Zone Options                 | Self-selected zone                                         |
    | Availability zone            | Leave default                                              |
    | Security type                | Leave default                                              |
    | Image                        | Leave default                                              |
    | VM architecture              | Leave default                                              |
    | Run with Azure Spot discount | Unchecked                                                  |
    | Size                         | Leave default                                              |
    | Authentication type          | Password                                                   |
    | Username                     | `azureuser`                                                |
    | Password                     | Enter a custom password                                    |
    | Confirm password             | Reenter the custom password                                |
    | Public inbound ports         | None                                                       |
5.  Select Review and Create.

> [!IMPORTANT]
> Product details will include a cost associated with creating the virtual machine. This is a system function. If you’re creating the VM in the Learn sandbox, you won’t actually incur any costs.

6.  Select Create

Wait while the VM is provisioned. Deployment is in progress will change to Deployment is complete when the VM is ready.

## Task 2: Verify resources created

Once the deployment is created, you can verify that Azure created not only a VM, but all of the associated resources the VM needs.

1.  Select Home.
2.  Under Azure services, select Resource groups.
3.  Select the **IntroAzureRG** resource group.

You should see a list of resources in the resource group. The resources were created when you created the virtual machine. By default, Azure gave them all a similar name to help with association and grouped them in the same resource group.

Congratulations! You've created a resource in Azure and had a chance to see how resources get grouped on creation.

## Clean up

To clean up the assets created in this exercise and avoid unnecessary costs, delete the resource group (and all associated resources).
1. From the Azure home page, under Azure servces, select **Resource groups**.
1. Select the **IntroAzureRG** resource group.
1. Select **Delete resource group**.
1. Enter `IntroAzureRG` to confirm deletion of the resource group and select delete.
