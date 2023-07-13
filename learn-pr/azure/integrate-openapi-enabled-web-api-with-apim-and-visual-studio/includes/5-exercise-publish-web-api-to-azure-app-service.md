In this exercise, you deploy your web API application to [Azure App Service][az appsvc] through Visual Studio.

> [!NOTE]
> In the previous exercise, you already have the ASP.NET Core Web API app with the OpenAPI feature enabled. You will use the app for this exercise.
>
> You need an Azure subscription to complete this module. If you do not have one, you can [sign up for a free one here][az account free].

## Deploy Web API Application to Azure App Service through Visual Studio ##

After the previous exercise, the web API application is ready to publish. In order to deploy the web API application, run the following steps.

1. In **Solution Explorer**, right-click the project and select the **Publish** menu.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-02.png" alt-text="Right-click Publish in Visual Studio.":::

1. In the **Publish** dialogue modal, select **Azure** and select the **Next** button. *(You may need to sign in to your Azure subscription first.)*

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-03.png" alt-text="Choose Publish Target.":::

1. Select **Azure App Service (Windows)** and select the **Next** button.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-04.png" alt-text="Choose Specific Target.":::

1. Let's create a new **Azure App Service** instance through Visual Studio, for this exercise. In the future, you could use an existing one. Select the `➕` button at the right-hand side of the dialogue modal to create a new **Azure App Service** instance.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-05.png" alt-text="Select Create New App Service.":::

1. When a new **App Service (Windows)** dialogue modal pops up, all field values are automatically populated. You can use the prepopulated ones or change them. Fill in all the field values and select the **Create** button.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-06.png" alt-text="Create New App Service.":::

1. Your new **Azure App Service** instance has been created. Select the **Next** button.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-07.png" alt-text="New App Service Created.":::

1. For now, publish the web API app only to the **Azure App Service** instance. You can skip the deploying to API Management step for now. Check the **Skip this step** tick box and select the **Finish** button.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-08.png" alt-text="Finish New App Service.":::

1. Your web API app is ready to deploy. In **Settings**, in the main pane, confirm that the Target Framework references your version of Visual Studio. Select the **Publish** button at the right-top corner of Visual Studio.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-09.png" alt-text="Publish Web API.":::

1. Once the web API app is published, Visual Studio notifies you through a banner. Copy the website URL for later use.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-10.png" alt-text="Web API Published.":::

## Verify the web API application is running ##

1. Let's ensure your web API app is properly deployed. Open your web browser and enter the website URL you copied from the previous step. A **Page Not Found** error, like the one in the following image, is expected.

    :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-11.png" alt-text="Page Not Found.":::

1. Edit the URL. If the website URL you copied is `https://apiapp-inventorymanagement-kc.azurewebsites.net`, replace `<copied-website-url>` according to the following example.

   ```text
   <copied-website-url>/swagger
   ```

1. The Swagger UI page now renders correctly. Select the **/api/WarehouseLocations** banner to expand it.

    :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-12.png" alt-text="Swagger UI Page.":::

1. Select the **Try it out** button.

    :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-13.png" alt-text="Swagger UI Page - Try It Out.":::

1. Select the **Execute** button.

    :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-14.png" alt-text="Swagger UI Page - Execute.":::

1. View the result.

    :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-15.png" alt-text="Swagger UI Page - Executed.":::

Congratulations! You've now published your ASP.NET Core Web API app to Azure App Service through Visual Studio!

[az appsvc]: /azure/app-service/overview
[az apim]: /azure/api-management/api-management-key-concepts
[az account free]: https://azure.microsoft.com/free/