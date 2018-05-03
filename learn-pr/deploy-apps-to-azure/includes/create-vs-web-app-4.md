Before we set up CI/CD pipeline processes, it is important to know the manual process for publishing to Azure Web Apps.

> [!NOTE] 
> Manual publishing is not recommended for production workloads, which is where you typically use a review control process or CI/CD pipeline. You will build a CI/CD pipeline in the rest of this tutorial.

To manually publish to Web Apps from Visual Studio:
1. Select **Solution Explorer**.
2. Right-click your solution, such as **myWebApp**, and then select **Publish**.
3. Select **Microsoft Azure App Service** as the publish target.
4. If needed, select your subscription in the **Subscription** drop-down menu. Then, select **New** to create an App Service.
5. Enter a name, such as **myWebApp**. Select your subscription in the drop-down menu. Then, select **New** to create a resource group.
6. Enter a name for your resource group, such as **myResourceGroup**. Then, select **New** to create an App Service Plan.
7. Select a **Location**, such as **East US**, then select a **Size**, such as **S1 Standard**.
8. When ready, select **Create**.
9. When the App Service has been created, the connection information is automatically populated in the Publish Web wizard. To publish your ASP.NET application to Web Apps, select **Publish**.
10. When the publish process is finished, the site automatically opens in your default web browser. Leave this website open in your browser.

    ![ASP.NET web app running in Web Apps](../media/running-web-app.png)

Congratulations! You have deployed your ASP.NET web app to Azure!