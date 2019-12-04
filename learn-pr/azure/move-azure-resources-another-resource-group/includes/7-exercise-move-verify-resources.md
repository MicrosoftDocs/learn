You've identified the development resources that are in the production resource group and you've checked that they'll move successfully. Now, you want to move your development resources from the production resource group into the dedicated development resource group by using the Azure portal.

## Create a resource group for development resources

First you create the development resource group where you'll move your resources.

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal.
1. Select **Resource groups** > **Add**.
1. Enter "devgroup" in the resource group field.
1. Select **Next : Tags**.
1. Enter the following values:

    ![Screenshot that shows how to assign a tag when you create a resource group](../media/7-exercise-set-tags-on-rg.png)

    |Field |Value  |
    |---------|---------|
    |NAME    |   environment     |
    |VALUE     |  development      |

1. Select **Review + create** > **Create**.  

## Move development resources to the new group

Now that you've created a devgroup resource group, you can move your development resources into it.

1. At the top of the Azure portal, search on **tags**.
1. Select the **environment:development** tag.
1. Select the storage account that you want to move.
1. Select **Move** > **Move to another resource group**.

    ![Screenshot that shows the move resource to another resource group option](../media/7-exercise-move-resource.png)

1. Under **Resource group**, select **devgroup**.
1. Select the reminder for you to update the resource IDs in your tools and scripts.
1. Select **OK**.
1. The move may take a few minutes. Wait for the notification that your resource has been moved. The notification will appear in the top-right hand of the portal.
1. Repeat this process again to move the other storage account.
1. On the Azure portal home page, select **Resource groups** > **devgroup**. 
1. You'll see that the development resources have been moved to the devgroup resource group.

    ![Screenshot that shows resources moved](../media/7-exercise-resources-moved.png)

In a real environment, you would now update the resource IDs in any tools and scripts that reference your resources.
