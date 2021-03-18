<!-- NOTE to REVIEWER - The code for this module can be found at https://github.com/justinyoo/inventory-management-demo-web-api which will be transferred to the MicrosoftDocs org. -->

:::row:::
  :::column span="4":::
    Crystal is a full-stack developer and software architect specializing in C# and .NET. She has written and designed many of Green Leaf's applications but is getting stretched thin by all the new requests. Crystal is familiar with Power Apps at a high-level and is eager to learn how she can use her existing skills to empower Citizen Developers.
  :::column-end:::
  :::column:::
    ![Cartoon depiction of Crystal][meet crystal]
  :::column-end:::
:::row-end:::


Crystal and her development team have built Web APIs for inventory management. She wants to make sure the APIs are ready for [Azure API Management][az apim] to easily discover their endpoints through an Open API document.

In this exercise, you will deploy your Web API application to [Azure App Service][az appsvc], through Visual Studio.


## Prerequisites ##

In order to complete this unit, you need to have Azure account. You can get a free account at [this page][az account].


## Download Web API Application to Visual Studio ##

Crystal has published the source code of the Web API application to GitHub. In order to open the Web API from Visual Studio, run the following steps.

1. Download the application from this [GitHub repository][gh zip].
1. Unzip the application to your local directory and open it from Visual Studio.

   ![Open Web API Project in Visual Studio][image-01]


## Deploy Web API Application to Azure App Service through Visual Studio ##

The downloaded Web API application is ready for publish. In order to deploy the Web API application, run the following steps.

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

1. You new **Azure App Service** instance has been created. Click the **Next** button.

   ![New App Service Created][image-07]

1. As you only publish the Web API app to **Azure App Service** instance, you don't need this step for now. Check the **Skip this step** tick box and click the **Finish** button.

   ![Finish New App Service][image-08]

1. Your Web API app is ready for deploy. Click the **Publish** button at the right-top corner of Visual Studio.

   ![Publish Web API][image-09]

1. Once the Web API app is published, Visual Studio notifies you through a banner. Copy the website URL for later use.

   ![Web API Published][image-10]


## Verify Web API Application on Azure App Service ##

In order to make sure your Web API app is properly deployed, open your web browser and enter the website URL copied from the previous step. You will see the **Page Not Found** error, which is expected.

![Page Not Found][image-11]

Change the URL to the following, and you will be able to see the Swagger UI page. If your copied website URL is `https://apiapp-inventorymanagement-kc.azurewebsites.net`, replace `<copied-website-url>` with it.

```text
<copied-website-url>/swagger
```

Then, you will see the Swagger UI page rendered. Click the **/api/FactoryLocation** banner to expand.

![Swagger UI Page][image-12]

Click the **Try it out** button.

![Swagger UI Page - Try It Out][image-13]

Click the **Execute** button.

![Swagger UI Page - Execute][image-14]

Then, you will see the result.

![Swagger UI Page - Executed][image-15]

Congratulations! You've now published your Web API app to Azure App Service, through Visual Studio!


## Key Takeaways ##

After this unit, you are now able to:

* Open a Web API project on Visual Studio,
* Publish the Web API to Azure App Service through Visual Studio, and
* Verify the Web API on your web browser.


[meet crystal]: ../media/meet-crystal.png

[image-01]: ../media/3-publish-web-api-to-azure-app-service-01.png
[image-02]: ../media/3-publish-web-api-to-azure-app-service-02.png
[image-03]: ../media/3-publish-web-api-to-azure-app-service-03.png
[image-04]: ../media/3-publish-web-api-to-azure-app-service-04.png
[image-05]: ../media/3-publish-web-api-to-azure-app-service-05.png
[image-06]: ../media/3-publish-web-api-to-azure-app-service-06.png
[image-07]: ../media/3-publish-web-api-to-azure-app-service-07.png
[image-08]: ../media/3-publish-web-api-to-azure-app-service-08.png
[image-09]: ../media/3-publish-web-api-to-azure-app-service-09.png
[image-10]: ../media/3-publish-web-api-to-azure-app-service-10.png
[image-11]: ../media/3-publish-web-api-to-azure-app-service-11.png
[image-12]: ../media/3-publish-web-api-to-azure-app-service-12.png
[image-13]: ../media/3-publish-web-api-to-azure-app-service-13.png
[image-14]: ../media/3-publish-web-api-to-azure-app-service-14.png
[image-15]: ../media/3-publish-web-api-to-azure-app-service-15.png


<!-- NOTE to REVIEWER. REPLACE the repo URL with the MicrosoftDocs one, once it's transferred. -->
[gh zip]: https://github.com/justinyoo/inventory-management-demo-web-api/archive/v1.0.0.zip

[az account]: https://azure.microsoft.com/free/
[az appsvc]: https://docs.microsoft.com/azure/app-service/overview
[az apim]: https://docs.microsoft.com/azure/api-management/api-management-key-concepts
