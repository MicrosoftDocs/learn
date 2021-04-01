In this exercise, you will deploy your web API application to [Azure App Service][az appsvc] through Visual Studio.

> [!NOTE]
> In the previous exercise, you already have the ASP.NET Core Web API app with the OpenAPI feature enabled. You will use the app for this exercise.


## Deploy Web API Application to Azure App Service through Visual Studio ##

The web API application is ready to publish. In order to deploy the web API application, run the following steps.

1. In **Solution Explorer**, right-click the project and select the **Publish** menu.

   ![Right-click Publish in Visual Studio][image-02]

1. In the **Publish** dialogue modal, select **Azure** and click the **Next** button.

   ![Choose Publish Target][image-03]

1. Select **Azure App Service (Windows)** and click the **Next** button.

   ![Choose Specific Target][image-04]

1. While you can use an existing **Azure App Service** instance, if you like, for this time, let's create a new one through Visual Studio. Click the `➕` button at the right-hand side of the dialogue modal to create a new **Azure App Service** instance.

   ![Click Create New App Service][image-05]

1. When a new **App Service (Windows)** dialogue modal pops up, all field values have already been automatically populated. You can use the pre-populated ones or change them. Fill in all the field values and click the **Create** button.

   ![Create New App Service][image-06]

1. Your new **Azure App Service** instance has been created. Click the **Next** button.

   ![New App Service Created][image-07]

1. As you only publish the web API app to **Azure App Service** instance, you don't need this step for now. Check the **Skip this step** tick box and click the **Finish** button.

   ![Finish New App Service][image-08]

1. Your web API app is ready to deploy. Click the **Publish** button at the right-top corner of Visual Studio.

   ![Publish Web API][image-09]

1. Once the web API app is published, Visual Studio notifies you through a banner. Copy the website URL for later use.

   ![Web API Published][image-10]


## Verify Web API Application on Azure App Service ##

In order to make sure your web API app is appropriately deployed, open your web browser and enter the website URL copied from the previous step. You will see the **Page Not Found** error, which is expected.

![Page Not Found][image-11]

Change the URL to the following, and you will be able to see the Swagger UI page. If your copied website URL is `https://apiapp-inventorymanagement-kc.azurewebsites.net`, replace `<copied-website-url>` with it.

```text
<copied-website-url>/swagger
```

Then, you will see the Swagger UI page rendered. Click the **/api/WarehouseLocations** banner to expand.

![Swagger UI Page][image-12]

Click the **Try it out** button.

![Swagger UI Page - Try It Out][image-13]

Click the **Execute** button.

![Swagger UI Page - Execute][image-14]

Then, you will see the result.

![Swagger UI Page - Executed][image-15]

Congratulations! You've now published your ASP.NET Core Web API app to Azure App Service through Visual Studio!


[image-01]: ../media/5-exercise-publish-web-api-to-azure-app-service-01.png
[image-02]: ../media/5-exercise-publish-web-api-to-azure-app-service-02.png
[image-03]: ../media/5-exercise-publish-web-api-to-azure-app-service-03.png
[image-04]: ../media/5-exercise-publish-web-api-to-azure-app-service-04.png
[image-05]: ../media/5-exercise-publish-web-api-to-azure-app-service-05.png
[image-06]: ../media/5-exercise-publish-web-api-to-azure-app-service-06.png
[image-07]: ../media/5-exercise-publish-web-api-to-azure-app-service-07.png
[image-08]: ../media/5-exercise-publish-web-api-to-azure-app-service-08.png
[image-09]: ../media/5-exercise-publish-web-api-to-azure-app-service-09.png
[image-10]: ../media/5-exercise-publish-web-api-to-azure-app-service-10.png
[image-11]: ../media/5-exercise-publish-web-api-to-azure-app-service-11.png
[image-12]: ../media/5-exercise-publish-web-api-to-azure-app-service-12.png
[image-13]: ../media/5-exercise-publish-web-api-to-azure-app-service-13.png
[image-14]: ../media/5-exercise-publish-web-api-to-azure-app-service-14.png
[image-15]: ../media/5-exercise-publish-web-api-to-azure-app-service-15.png


[az appsvc]: https://docs.microsoft.com/azure/app-service/overview
[az apim]: https://docs.microsoft.com/azure/api-management/api-management-key-concepts
