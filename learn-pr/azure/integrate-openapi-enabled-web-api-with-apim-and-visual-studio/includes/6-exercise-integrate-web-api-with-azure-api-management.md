In this exercise, you will integrate your web API application running on [Azure App Service][az appsvc] with [Azure API Management][az apim] through Visual Studio.

> [!NOTE]
> In the previous exercise, you already have the ASP.NET Core Web API app with the OpenAPI feature enabled. You will use the app for this exercise.


## Integrate Web API Application with Azure API Management through Visual Studio ##

The web API application is ready to publish. In order to deploy the web API application, run the following steps.

1. In **Solution Explorer**, right-click the project and select the **Publish** menu.

   :::image type="content" source="../media/5-exercise-publish-web-api-to-azure-app-service-02.png" alt-text="Right-click Publish in Visual Studio.":::

1. In the **Publish** dialogue modal, select **Azure** and click the **Next** button.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-03.png" alt-text="Choose Publish Target.":::

1. Select **Azure App Service (Windows)** and click the **Next** button.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-04.png" alt-text="Choose Specific Target.":::

1. As you have already published your web API app to an **Azure App Service** instance in the previous unit, you can see it in the dialogue modal. Select the App Service instance and click the **Next** button.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-05.png" alt-text="Choose Existing App Service.":::

1. While you can use an existing **Azure API Management** instance, if you like, for this time, let's create a new one through Visual Studio. Click the `➕` button at the right-hand side of the dialogue modal to create a new **Azure API Management** instance.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-06.png" alt-text="Click Create New API Management.":::

1. When a new **API in API Management** dialogue modal pops up, all mandatory field values have already been automatically populated. You can use the pre-populated ones or change them. Fill in all the field values. However, there is no API Management instance yet. Click the **New...** button at the right-hand side of the dialogue modal.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-07.png" alt-text="Create New API in API Management.":::

1. Another pop-up dialogue modal appears to create a new **Azure API Management** instance. All fields values have already been populated. You can use or change them. Then click the **OK** button.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-08.png" alt-text="Create New API Management.":::

1. Once the **Azure API Management** dialogue modal closes, the **API in API Management** modal shows the API Management instance name. Click the **Create** button.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-09.png" alt-text="Create New API in API Management Filled.":::

1. The **Azure API Management** instance is ready to integrate the web API app on the **Azure App Service** instance. Click the **Finish** button.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-10.png" alt-text="Finish API Management Publish.":::

1. Your web API app is ready to deploy. Check the bottom of Visual Studio that the Azure API Management instance is also configured for integration. Click the **Publish** button at the right-top corner of Visual Studio.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-11.png" alt-text="Publish Web API.":::

1. Once the web API app is published, Visual Studio notifies you through a banner.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-12.png" alt-text="Web API Published.":::

As you also created the Azure API Management instance and integrate the web API app with it, you should be able to verify it on Azure portal.


## Verify Web API Integration on Azure API Management ##

1. To verify whether your web API has been integrated with Azure API Management, open a web browser and log-in to Azure portal. Then enter the keyword, `api management`, to the search bar at the top of the Azure portal. When the **API Management services** appears, click it.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-13.png" alt-text="Search API Management.":::

1. Your Azure API Management instance appears. Click it.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-14.png" alt-text="API Management Instances.":::

1. Go to the **APIs** blade and select the **Inventory Management** API. Choose the **/api/WarehouseLocations - GET** operation and click the **Test** tab in the middle of the page.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-15.png" alt-text="API Management - API.":::

1. Click the **Send** button to send a test request to web API.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-16.png" alt-text="API Management - API Test.":::

1. The response from the API request is shown.

   :::image type="content" source="../media/6-exercise-integrate-web-api-with-azure-api-management-17.png" alt-text="API Management - API Test Result.":::

Congratulations! You've now integrated your web API app with Azure API Management through Visual Studio!


[az appsvc]: /azure/app-service/overview
[az apim]: /azure/api-management/api-management-key-concepts