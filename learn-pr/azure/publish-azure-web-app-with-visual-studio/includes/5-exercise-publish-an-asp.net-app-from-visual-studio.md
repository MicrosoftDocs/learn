You now have an ASP.NET Core web application running locally. In this part, you'll publish your application to Azure App Service.

1. In Solution Explorer, right-click your project and select **Publish**.

1. Click **Start**.

1. In the dialog box that appears, on the left, choose **App Service** as your publish target.  On the right, select **Create New** to create an App Service app.

1. Click **Publish**.

### Configure your new Azure App Service

1. In the **Create App Service** dialog box, click **Add an account**, and sign in to your Azure subscription. If you're already signed in, select the account containing the desired subscription from the drop-down menu.

1. Enter the required information about your App Service plan.

    ![Create App Service](../media/5-CreateAppService.png)

    In the **Create App Service** dialog box, you will provide the following information:

    - **App Name**: This is the name of your application.  This will determine the URL of the published application, which will be https://<AppName>.azurewebsites.net.  It must be a unique value. Therefore, you will have to try out some different names to find one that is not reserved.

    - **Subscription**: The Azure subscription you wish to deploy the app to. Choose **Concierge Subscription**, which we provide to you through the sandbox.

    - **Resource Group:** Select the existing <rgn>[sandbox resource group name]</rgn> resource group.

    - **Hosting Plan:** The hosting plan specifies the location, size, and features of the web server farm that hosts your app. You can select an existing hosting plan or create one. For this exercise, you will create one.

        Click the **New...** button next to the hosting plan.

        ![New Hosting Plan](../media/5-NewHostingPlan.png)

    - **Application Insights:** Specifies if you want to use Application Insights for your application. For this exercise, we recommend that you choose **None.**


1. Click the **Create** button to start provisioning your app. You will see progress as it deploys:

    ![Deploy Progress](../media/5-DeployProgress.png)

1. Congratulations, your ASP.NET Core web application is now published and live. You will be able to see the final URL for your site in the build output and also on the publishing page in Visual Studio.

    ![Publish Result](../media/5-PublishPage.png)


1. To test your website, go to the URL indicated.

    ![Live Site](../media/5-WebPageLive.png)

    > [!NOTE]
    > If you can't locate the URL from the output, navigate to https://<AppName>.azurewebsites.net, where <AppName> is the name you provided earlier. For example, **https://alpineskihouse123.azurewebsites.net/**.

You now have a live web app! Your Azure App Service plan has been provisioned, and the app is running, and ready to accept updates.
  
