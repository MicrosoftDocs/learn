Before we set up CI/CD pipeline processes, it is important to know the manual process for publishing to Azure Web Apps.

>[NOTE] Manual publishing is not recommended for production workloads where you should typically use a review control process or CI/CD pipeline. You will build a CI/CD pipeline in the rest of this tutorial.

To manually publish to Azure Web Apps from Visual Studio:
1. Select the **Solution Explorer**.
2. Right-click your solution, such as *myWebApp*, and choose **Publish**.
3. Choose **Microsoft Azure App Service** as the publish target.
4. If needed, select your *Subscription* from the drop-down menu, then choose to create **New** App Service.
5. Enter a name, such as *myWebApp*. Select your subscription from the drop-down menu, then choose to create a **New** resource group.
6. Enter a name for your resource group, such as *myResourceGroup*, then choose to create a **New** *App Service Plan*.
7. Choose a **Location**, such as *East US*, then a **Size**, such as *S1 Standard*.
8. When ready, select **Create**.
9. Once the App Service has been created, the connection information is automatically populated in the *Publish Web* dialog wizard. To publish your ASP.NET application to Azure Web Apps, select **Publish**.
10. When the publish process is complete, the site automatically opens in your default web browser. Leave this web site open in your browser.

    ![ASP.NET web app running on Azure Web App](../media/running-web-app.png)

Congratulations - You have just deployed your ASP.NET web app to Azure!