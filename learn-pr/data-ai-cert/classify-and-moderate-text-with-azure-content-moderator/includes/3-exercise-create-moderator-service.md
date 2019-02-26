Before you can begin to test content moderation or integrate it into your custom applications, you need to create a Content Moderator service on Microsoft Azure and get the API key for accessing the service. In this exercise, you will create a new Content Moderator service in the Azure portal.

## Create a Content Moderator Service

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal)
1. Click **Create a resource** in the left-hand sidebar.
1. Enter "Content Moderator" in the search box and press Enter.
1. Select **Content Moderator** from the results.
1. Click **Create**.
1. Enter a unique name for your service, choose a subscription, and select a location close to you.
1. Select the **F0** pricing tier for this service, then choose **S0**.
1. Create a new Resource Group called **LearnRG**
1. Click **Create**

    ![Fill in the details for the Content Moderator service](../media/3-create-content-moderator-service-create.png)

It will take a few minutes to deploy, once it does, navigate to the new resource.

## Copy the access key

To access the service, you will need a subscription key.

1. Select the **Keys** section under Resource Management.
1. Using the "Click to Copy" icon, copy one of the keys for later use.