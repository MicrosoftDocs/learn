<!-- NOTE to REVIEWER - The code for this module can be found at https://github.com/justinyoo/inventory-management-demo-web-api, which will be transferred to the MicrosoftDocs org. -->

:::row:::
  :::column span="4":::
    Crystal is a full-stack developer and software architect specializing in C# and .NET. She has written and designed many of Green Leaf's applications but is getting stretched thin by all the new requests. Crystal is familiar with Power Apps at a high-level and is eager to learn how she can use her existing skills to empower Citizen Developers.
  :::column-end:::
  :::column:::
    ![Cartoon depiction of Crystal][meet crystal]
  :::column-end:::
:::row-end:::


Crystal and her development team have built Web APIs for inventory management. She wants to make sure the APIs are ready for [Azure API Management][az apim] to discover their endpoints through an Open API document easily.

In this exercise, you will integrate your Web API application running on Azure App Service with Azure API Management through Visual Studio.


## Prerequisites ##

In order to complete this unit, you need to have an Azure account. You can get a free account at [this page][az account].


## Download Web API Application to Visual Studio ##

Crystal has published the source code of the Web API application to GitHub. In order to open the Web API from Visual Studio, run the following steps.

1. Download the application from this [GitHub repository][gh zip].
1. Unzip the application to your local directory and open it from Visual Studio.

   ![Open Web API Project in Visual Studio][image-01]


## Integrate Web API Application with Azure API Management through Visual Studio ##

The downloaded Web API application is ready to publish. In order to deploy the Web API application, run the following steps.

1. In **Solution Explorer**, right-click the project and select the **Publish** menu.

   ![Right-click Publish in Visual Studio][image-02]

1. In the **Publish** dialogue modal, select **Azure** and click the **Next** button.

   ![Choose Publish Target][image-03]

1. Select **Azure App Service (Windows)** and click the **Next** button.

   ![Choose Specific Target][image-04]

1. As you have already published your Web API app to an **Azure App Service** instance in the previous unit, you can see it in the dialogue modal. Select the App Service instance and click the **Next** button.

   ![Choose Existing App Service][image-05]

1. While you can use an existing **Azure API Management** instance, if you like, for this time, let's create a new one through Visual Studio. Click the `➕` button at the right-hand side of the dialogue modal to create a new **Azure API Management** instance.

   ![Click Create New API Management][image-06]

1. When a new **API in API Management** dialogue modal pops up, all mandatory field values have already been automatically populated. You can use the pre-populated ones or change them. Fill in all the field values. However, there is no API Management instance yet. Click the **New...** button at the right-hand side of the dialogue modal.

   ![Create New API in API Management][image-07]

1. Another pop-up dialogue modal appears to create a new **Azure API Management** instance. All fields values have already been populated. You can use or change them. Then click the **OK** button.

   ![Create New API Management][image-08]

1. Once the **Azure API Management** dialogue modal closes, the **API in API Management** modal shows the API Management instance name. Click the **Create** button.

   ![Create New API in API Management Filled][image-09]

1. The **Azure API Management** instance is ready to integrate the Web API app on the **Azure App Service** instance. Click the **Finish** button.

   ![Finish API Management Publish][image-10]

1. Your Web API app is ready to deploy. Check the bottom of Visual Studio that the Azure API Management instance is also configured for integration. Click the **Publish** button at the right-top corner of Visual Studio.

   ![Publish Web API][image-11]

1. Once the Web API app is published, Visual Studio notifies you through a banner.

   ![Web API Published][image-12]

As you also created the Azure API Management instance and integrate the Web API app with it, you should be able to verify it on Azure Portal.


## Verify Web API Integration on Azure API Management ##

To verify whether your Web API has been integrated with Azure API Management, open a web browser and log-in to Azure Portal. Then enter the keyword, `api management`, to the search bar at the top of the Azure Portal. When the **API Management services** appears, click it.

![Search API Management][image-13]

Your Azure API Management instance appears. Click it.

![API Management Instances][image-14]

Go to the **APIs** blade and select the **Inventory Management** API. Choose the **/api/FactoryLocation - GET** operation and click the **Test** tab in the middle of the page.

![API Management - API][image-15]

Click the **Send** button to send a test request to Web API.

![API Management - API Test][image-16]

The response from the API request is shown.

![API Management - API Test Result][image-17]

Congratulations! You've now integrated your Web API app with Azure API Management through Visual Studio!


## Key Takeaways ##

After this unit, you are now able to:

* Open a Web API project on Visual Studio,
* Publish the Web API to Azure App Service through Visual Studio,
* Integrate the Web API with Azure API Management, and
* Verify the Web API through Azure API Management on Azure Portal.


[meet crystal]: ../media/meet-crystal.png

[image-01]: ../media/4-integrate-web-api-with-azure-api-management-01.png
[image-02]: ../media/4-integrate-web-api-with-azure-api-management-02.png
[image-03]: ../media/4-integrate-web-api-with-azure-api-management-03.png
[image-04]: ../media/4-integrate-web-api-with-azure-api-management-04.png
[image-05]: ../media/4-integrate-web-api-with-azure-api-management-05.png
[image-06]: ../media/4-integrate-web-api-with-azure-api-management-06.png
[image-07]: ../media/4-integrate-web-api-with-azure-api-management-07.png
[image-08]: ../media/4-integrate-web-api-with-azure-api-management-08.png
[image-09]: ../media/4-integrate-web-api-with-azure-api-management-09.png
[image-10]: ../media/4-integrate-web-api-with-azure-api-management-10.png
[image-11]: ../media/4-integrate-web-api-with-azure-api-management-11.png
[image-12]: ../media/4-integrate-web-api-with-azure-api-management-12.png
[image-13]: ../media/4-integrate-web-api-with-azure-api-management-13.png
[image-14]: ../media/4-integrate-web-api-with-azure-api-management-14.png
[image-15]: ../media/4-integrate-web-api-with-azure-api-management-15.png
[image-16]: ../media/4-integrate-web-api-with-azure-api-management-16.png
[image-17]: ../media/4-integrate-web-api-with-azure-api-management-17.png


<!-- NOTE to REVIEWER. REPLACE the repo URL with the MicrosoftDocs one once it's transferred. -->
[gh zip]: https://github.com/justinyoo/inventory-management-demo-web-api/archive/v1.0.0.zip

[az account]: https://azure.microsoft.com/free/
[az appsvc]: https://docs.microsoft.com/azure/app-service/overview
[az apim]: https://docs.microsoft.com/azure/api-management/api-management-key-concepts
