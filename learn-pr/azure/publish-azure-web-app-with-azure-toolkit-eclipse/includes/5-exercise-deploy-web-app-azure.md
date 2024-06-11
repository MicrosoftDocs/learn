In a previous exercise, you created a dynamic web application using Eclipse. You tested the web app locally using an Apache Tomcat server that runs on your computer.

In this exercise, you use the Azure Toolkit for Eclipse to create a new Azure App Service, deploy your web app to Azure, and then test your web app. This exercise uses Eclipse on your desktop computer. However, the Azure Toolkit creates the App Service and App Service plan in an Azure sandbox account. The results should be the same as if you run the web app locally.

## Sign in to Azure from Eclipse

1. Start Eclipse if it isn't already running, and open the **SampleWebApp** project.

1. In the Azure Toolkit for Eclipse toolbar, select **Show Azure Explorer**.

   :::image type="content" source="../media/5-start-azure-explorer.png" alt-text="Screenshot of the Azure Toolkit for Eclipse toolbar with the Show Azure Explorer button highlighted." loc-scope="third-party":::

1. In the **Azure Explorer** window, right-click the **Azure** icon, and then select **Sign in**.

   :::image type="content" source="../media/5-azure-sign-in.png" alt-text="Screenshot of the Azure Explorer window where the user isn't currently signed in." loc-scope="third-party":::

1. On the **Azure Sign In** page, select **Device Login**, and then select **Sign in**.

   :::image type="content" source="../media/5-device-login.png" alt-text="Screenshot of the Azure Sign In page with Device Login selected." loc-scope="third-party":::

1. On the **Azure Device Login** window, select **Copy&Open**. This action copies the device code displayed in the window to the clipboard.

   :::image type="content" source="../media/5-device-login-2.png" alt-text="Screenshot of the Azure Device Login window where the user selected Copy&Open." loc-scope="third-party":::

1. A web browser window opens. At the **Enter code** prompt, paste the device code you copied to the clipboard, and then select **Next**.

   :::image type="content" source="../media/5-enter-code.png" alt-text="Screenshot of a browser window, prompting the user to Enter code from the Azure Device Login window.":::

1. When prompted, sign in to Azure with the same account that you used to create the Azure sandbox.

1. In **Your Subscriptions**, select the **Concierge Subscription**. This subscription is created specifically for the sandbox.

   :::image type="content" source="../media/5-subscriptions.png" alt-text="Screenshot of the Your Subscriptions page, with the Concierge Subscription selected." loc-scope="third-party":::

## Deploy the web app to your Azure subscription

1. In the **Project Explorer** pane, right-click **SampleWebApp**, select **Azure**, and then select **Publish as Azure Web App**.

   :::image type="content" source="../media/5-publish-web-app-menu.png" alt-text="Screenshot of the Azure menu in Eclipse with Publish as Azure Web App selected." loc-scope="third-party":::

1. In the **Deploy Web App** window, select **Create** to create a new Azure App Service.

   :::image type="content" source="../media/5-deploy-web-app.png" alt-text="Screenshot of the Deploy Web App window in Eclipse." loc-scope="third-party":::

1. In the **Create App Service** window, specify the following values, and then select **Create**:

   > [!NOTE]
   > The web app must have a unique name. Consider using something like **[*your name or initials*]samplewebapp**. Use this name wherever you see *[your-webapp-name]* in this exercise.

   | Property | Value |
   |:---------|:------|
   | Name | *[your-webapp-name]* |
   | Subscription | *Concierge Subscription* |
   | Runtime | *Linux* |
   | Linux Runtime | *TOMCAT 10.1-java-17* |
   | App service plan | Select **Create new** and accept the default name and location, but change the **Pricing Tier** to **Free_F1** for this exercise. |
   | Resource Group | *<rgn>[sandbox resource group name]</rgn>* |
   | App Settings | Leave empty |

   :::image type="content" source="../media/5-create-app-service.png" alt-text="Screenshot of the Create App Service window in Eclipse." loc-scope="third-party":::

1. In the **Deploy Web App** window, verify that your new app service is selected, and then select **Deploy** to deploy your web app to Azure.

   :::image type="content" source="../media/5-deploy-to-app-service.png" alt-text="Screenshot of the Deploy Web App window in Eclipse where the web app will be deployed to the newly created app service." loc-scope="third-party":::

   The **Azure Activity Log** window appears, which shows the status of the deployment operation.

   :::image type="content" source="../media/5-azure-activity-log.png" alt-text="Screenshot of the Azure Activity Log window in Eclipse while the web app is being deployed." loc-scope="third-party":::

   Wait until the message in the **Progress** column changes to **Published** before continuing.

## Test the web app in Azure

1. In the **Azure Explorer** window, right-click **Web Apps**, and then select **Refresh**.

1. Expand **Web Apps**. Verify that your new web app is listed.

   :::image type="content" source="../media/5-azure-explorer-web-app.png" alt-text="Screenshot of the Azure Explorer window in Eclipse, showing the new web app." loc-scope="third-party":::

1. Right-click the web app, and then select **Open In Browser**.

   :::image type="content" source="../media/5-web-app-open.png" alt-text="Screenshot of the context menu for the web app in the Azure Explorer window." loc-scope="third-party":::

1. In the web browser, verify that the web app displays similar results to when it ran locally. The main difference is the IP address, which is the real IP address of your computer rather than 127.0.0.1 (localhost).

   :::image type="content" source="../media/5-web-app-running.png" alt-text="Screenshot of the web app running in a browser." loc-scope="third-party":::

1. Select the refresh button in the web browser, and verify that the time updates.

1. Close the web browser and return to Eclipse.

Congratulations! You used the Azure Toolkit for Eclipse to create an App Service in Azure, deploy a web app to your app service, and tested your web app.
