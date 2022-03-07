
> [!IMPORTANT]
> The web application is developed using jQuery. However, the language selected will be the language you need to use for the rest of module for the Azure Functions, so choose wisely!

Azure Static Web Apps are great for deploying static content with associated serverless APIs via Azure Functions.

Recall in the bus-catching scenario, a webpage to monitor where buses are with respect to a monitored geofence is desired. This application will allow users to view how close buses on their route are to arriving, before they enter the geofence.

Here, you'll deploy a jQuery app with Azure Static Web Apps using the Azure portal and your GitHub repository.

## Deploy an Azure Static Web App using the Azure portal

The main goal is to deploy an Azure Static Web App using the Azure portal.

1. Navigate to the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

2. In the search bar, type **static web app** and select **Static Web App** under *Marketplace*. This will take you to the create page.

3. Select the default subscription and your Resource Group (it will be the only Resource Group in the drop-down).

4. Enter **bus-app** for *Name*.

5. Select the region where your other resources are deployed. If that region isn't available, select the closest region to where you are.

6. At the bottom, select **Sign in with GitHub**.

7. Log in with your GitHub account and select **Authorize Azure-App-Service-Static-Web-Apps**. You may also need to enter your password.

8. Fill in the *Organization*, *Repository*, and *Branch* drop-downs with the corresponding information for the GitHub repository you've been using for this module.

9. Select **Custom** in the *Build Presets* drop-down.

::: zone pivot="csharp"

10. For *App location*, enter **azure-static-web-app/client**.

11. For *Api location*, enter **azure-static-web-app/api/dotnet**.

::: zone-end

::: zone pivot="python"

10. For *App location*, enter **azure-static-web-app/client**.

11. For *Api location*, enter **azure-static-web-app/api/python**.

::: zone-end

::: zone pivot="node"

10. For *App location*, enter **azure-static-web-app/client/**.

11. For *Api location*, enter **azure-static-web-app/api/node**.

::: zone-end

12. Select **Review + Create**.

13. Select **Create**.

14. Once it finishes creating, select **Go to resource**.

> [!TIP]
> If you click on the Azure Static Web App and don't see the map with a geofence and buses, that's OK for now. In the next exercise, you'll configure the application.
