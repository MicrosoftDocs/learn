You've identified the development resources that are incorrectly placed in the production resource group and you've checked that they'll move successfully. Now, you want to move your development resources from the production resource group into the dedicated development resource group.

## Create a resource group for development resources

First you create the development resource group where you'll move your resources.

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal.
1. Select **Resource groups**.
1. Select **Add** at the top of the resource groups pane. The "Create a resource group" pane appears.
1. Enter "devgroup" in the resource group field. Select the appropriate region in the Region drop-down menu.
1. Add a tag to this resource group, by selecting  **Next : Tags** at the bottom of the form.
1. Enter "environment" in the name field and "development" in the value field as shown below:

    ![Set tags on your development group](../media/7-exercise-set-tags-on-rg.png)

1. Select **Next : Review + create** at the bottom of the form. You can now review your configuration, and then select **Create**.  

## Move development resources to the new group

Now you've created a devgroup resource group, you can move your development resources into it.

1. Select the **search box** at the top of the Azure portal.
1. Enter "tags" in the **search box**.
1. Select **Tags**.
1. You can now see the tags you created earlier.
1. Select the **environment:development** tag.
1. All your development resources are now listed here.
1. Select the resource you want to move, then select **Move > move to another resource group** as shown below.

    ![Move resource to another resource group](../media/7-exercise-move-resource.png)

1. The move resource pane appears. Select the resources you want to move. Then, in the drop-down at the bottom, select **devgroup** as the resource group where you want to move your resources.
1. Agree to the disclaimer reminding you to update the resource IDs in your tools and scripts, by selecting the **checkbox**.
1. Select **OK** at the bottom of the form. When your resources have been moved, you'll receive a notification in the top-right corner of the portal.
1. Go back to the devgroup resource group to confirm your resources have been moved. Select **Resource groups > devgroup**. You'll see that the development resources have been moved to the devgroup resource group as shown below:

    ![Resources have been moved](../media/7-exercise-resources-moved.png)

> [!NOTE]
> In a real environment, you would now update the resource IDs that reference your resources in any tools and scripts being used with your resources.
