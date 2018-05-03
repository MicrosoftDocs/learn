Before we set up CI/CD pipeline processes, it's important to know the manual process for publishing to Azure Web Apps.

> [!NOTE] 
> Manual publishing is not recommended for production workloads. You typically use a review control process or CI/CD pipeline in production workloads. 
>
> In the rest of this tutorial, you'll build a CI/CD pipeline.

To manually publish to Web Apps from Visual Studio:
1. Select **Solution Explorer**.
2. Right-click your solution, such as *myWebApp*.
3. Select **Publish**, and then select *Microsoft Azure App Service* as the publish target.
4. If needed, select your subscription in the **Subscription** drop-down menu.
5. Select **New** to create an App Service. Enter a name, such as *myWebApp*. Select your subscription in the drop-down menu.
6. Select **New** to create a resource group. Enter a name for your resource group, such as *myResourceGroup*.
7. Select **New** to create an App Service Plan. Select a **Location**, such as *East US*, and then select a **Size**, such as *S1 Standard*.
8. Select **Create**.
9. When the App Service is created, the connection information is automatically populated in the Publish Web wizard. To publish your ASP.NET application to Web Apps, select **Publish**.
10. When the publish process is finished, the site automatically opens in your default web browser. Leave this website open in your browser.

    ![ASP.NET web app running in Web Apps](../media/running-web-app.png)

Congratulations! You have deployed your ASP.NET web app to Azure.