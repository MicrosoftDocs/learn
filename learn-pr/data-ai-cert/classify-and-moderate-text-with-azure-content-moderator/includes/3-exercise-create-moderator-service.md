Before you can begin to test content moderation or integrate it into your custom applications, you need to create and subscribe to a Content Moderator resource and get the subscription key for accessing the resource. 

In this exercise, you'll create a new Content Moderator resource in the Azure portal.

## Create and subscribe to a Content Moderator resource

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the left pane, select **Create a resource**.
1. In the search box, enter **Content Moderator**, and then press Enter.
1. From the search results, select **Content Moderator**.
1. Select **Create**.
1. Enter a unique name for your resource, choose a subscription, and select a location close to you.
1. Select the pricing tier for this resource, then choose **S0**.
1. Create a new resource group named **LearnRG**.
1. Select **Create**.

    ![Specify the settings for the Content Moderator resource](../media/3-create-content-moderator-service-create.png)

The resource will take a few minutes to deploy. After it does, go to the new resource.

## Copy the subscription key

To access your Content Moderator resource, you'll need a subscription key:

1. In the left pane, under **RESOURCE MANAGEMENT**, select **Keys**.
1. Copy one of the subscription key values for later use.
