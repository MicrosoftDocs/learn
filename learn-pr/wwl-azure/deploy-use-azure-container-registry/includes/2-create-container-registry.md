Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

Azure Container Registry is a private registry service for building, storing, and managing container images and related artifacts. In this module, you create an Azure container registry instance with the Azure portal.

> [!NOTE]
> To complete this procedure, you need an [Azure subscription](https://azure.microsoft.com/free/).

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).
2.  Select **Create a resource &gt; Containers &gt; Container Registry**.:::image type="content" source="../media/create-new-container-registry-f12abbe3.png" alt-text="Displays a screenshot of the resource creation page.":::
    
3.  In the **Basics** tab, enter values for **Resource group** and **Registry name**. The registry name must be unique within Azure, and contain 5-50 alphanumeric characters. Create a new resource group in the West US location. Select the **Standard** SKU.
    
    :::image type="content" source="../media/configure-container-registry-new-8af7e07c.png" alt-text="Displays a screenshot of the container registry creation tab.":::
    

4.  Accept default values for the remaining settings. Then select **Review + create**. After reviewing the settings, select **Create**.
5.  When the **Deployment succeeded** message appears, select **Go to resource**.
    
    :::image type="content" source="../media/deployment-complete-view-resource-4fbfe98c.png" alt-text="Displays a screenshot of the deployment for the container registry.":::
    

6.  Make a note of the registry name and the value of the **Login server**, which is a fully qualified name ending with azurecr.io in the Azure cloud. You use these values in the following steps when you push and pull images with Docker.
    
    :::image type="content" source="../media/new-container-registry-server-f0bfbeed.png" alt-text="Displays a screenshot of the process for push and pull of container images.":::
    
