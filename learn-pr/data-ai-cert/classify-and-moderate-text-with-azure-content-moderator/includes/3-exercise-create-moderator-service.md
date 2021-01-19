Before you can begin to test content moderation or integrate it into your custom applications, you need to create and subscribe to a Content Moderator resource and get the subscription key for accessing the resource. 

In this exercise, you'll create a new Content Moderator resource in the Azure portal.

## Create and subscribe to a Content Moderator resource

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the left pane, select **Create a resource**.

1. In the search box, enter **Content Moderator**, and then press <kbd>Enter</kbd>.

1. From the search results, select **Content Moderator**.

1. Select **Create**.

1. Enter a unique name for your resource, select a subscription, and select a location close to you.

1. Select the pricing tier for this resource, and then select **F0**.

    >[!Note]
    >If your current subscription is already using a free tier, you will need to choose **S0** for the pricing tier or remove the existing **F0** option.

1. Create a new resource group named **LearnRG**.

1. Select **Create**.

The resource will take a few minutes to deploy. After it does, go to the new resource.

## Copy the subscription key

To access your Content Moderator resource, you'll need a subscription key:

1. In the left pane, under **RESOURCE MANAGEMENT**, select **Keys and Endpoints**.

1. Copy one of the subscription key values for later use.
