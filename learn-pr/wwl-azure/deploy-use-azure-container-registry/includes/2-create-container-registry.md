
Azure Container Registry is a private registry service for building, storing, and managing container images and related artifacts. In this module, you create an Azure container registry instance with the Azure portal.

For this exercise, Docker commands are used to push a container image into the registry, and finally pull and run the image from your registry.

> [!NOTE]
> You must also have Docker installed locally and running. Docker provides packages that easily configure Docker on any [Mac](https://docs.docker.com/docker-for-mac/), [Windows](https://docs.docker.com/docker-for-windows/), or [Linux](https://docs.docker.com/engine/installation/#supported-platforms) system.

Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/).

Select **Create a resource &gt; Containers &gt; Container Registry**.:::image type="content" source="../media/create-new-container-registry-f12abbe3.png" alt-text="Displays a screenshot of the resource creation page.":::


In the **Basics** tab, enter values for **Resource group** and **Registry name**. The registry name must be unique within Azure, and contain 5-50 alphanumeric characters. Create a new resource group in the West US location. Select the **Standard** SKU.

:::image type="content" source="../media/configure-container-registry-new-8af7e07c.png" alt-text="Displays a screenshot of the container registry creation tab.":::


Accept default values for the remaining settings. Then select **Review + create**. After reviewing the settings, select **Create**.

When the **Deployment succeeded** message appears, select **Go to resource**.

:::image type="content" source="../media/deployment-complete-view-resource-4fbfe98c.png" alt-text="Displays a screenshot of the deployment for the container registry.":::


Make a note of the registry name and the value of the **Login server**, which is a fully qualified name ending with azurecr.io in the Azure cloud. You use these values in the following steps when you push and pull images with Docker.

:::image type="content" source="../media/new-container-registry-server-f0bfbeed.png" alt-text="Displays a screenshot of the process for push and pull of container images.":::
