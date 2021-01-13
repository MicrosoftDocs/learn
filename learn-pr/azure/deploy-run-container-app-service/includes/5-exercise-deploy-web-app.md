Azure App Service provides the hosting environment for an Azure-based web app. You can configure App Service to retrieve the image for the web app from a repository in Azure Container Registry. 

In the example scenario, the team has uploaded the image for the web app to Azure Container Registry and is now ready to deploy the web app.

In this unit, you'll create a new web app by using the Docker image stored in Azure Container Registry. You'll use App Service with a predefined App Service plan to host the web app.

## Enable Docker access to the Azure Container Registry (ACR)

You'll use Docker to login to the registry and pull the web image that you want to deploy. Docker needs a username and password to perform this action. The ACR allows you to enable the registry name as the username and admin access key as the password to allow Docker to login to your container registry.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), navigate to all resources.

1. Select the container registry you created earlier to navigate to the Overview page for the container registry.

1. Under **Settings**, select **Access keys**.

1. Set the **Admin user** option to **Enable**. This change saves automatically.

You're now ready to create your web app.

## Create a web app

1. Select **Create a resource** > **Web** > **Web App**.

    :::image type="content" source="../media/5-search-web-app-annotated.png" alt-text="Screenshot that shows the Azure Marketplace with Web App selected.":::

1. Specify these settings for each of the properties:

    | Property | Value |
    |---|---|
    | Subscription | Select your default Azure subscription in which you are allowed to create and manage resources. |
    | Resource Group | Reuse the existing resource group **learn-deploy-container-acr-rg**. |
    | Name | Enter a unique name and make a note of it for later. |
    | Publish | **Docker Container** |
    | OS | **Linux** |
    | App Service plan | Use the default. |

1. Click **Next:&nbsp;Docker&nbsp;&gt;**.

1. In the **Docker** tab, specify these settings for each of the properties:

    | Property | Value |
    |---|---|
    | Options | **Single Container** |
    | Image Source | **Azure Container Registry** |
    | Registry | Select your registry. |
    | Image | `webimage` |
    | Tag | `latest` |
    | Startup Command | Leave this empty. |

1. Select **Review and create**, and then click **Create**. Wait until the web app has been deployed before you continue.

## Test the web app

1. Use the **All resources** view in the Azure portal to go to the **Overview** page of the web app you just created.

2. Select the **Browse** button to open the site in a new browser tab.

::: zone pivot="csharp"

3. After the cold-start delay while your app's Docker image loads and starts, you'll see a page like this:

    ![Screenshot of the sample Docker image](../media/5-sample-web-app-dotnet.png)

::: zone-end

::: zone pivot="javascript"

3. After the cold-start delay while your app's Docker image loads and starts, you'll see a page like this:

    ![Screenshot of the sample Welcome to Express](../media/5-sample-web-app-node.png)

::: zone-end

App Service is now hosting the app from your Docker image.
