In a previous exercise, you created a dynamic web application using Eclipse. you tested the web app locally using an Apache Tomcat server that was running on your computer.

In this exercise, you'll use the Azure Toolkit for Eclipse to create a new Azure App Service, deploy your web app to Azure, and then test your web app. This exercise uses Eclipse on your desktop computer. However, the Azure Toolkit will create the App Service and App Service plan in an Azure sandbox account, so the results should be the same as if you were running the web app locally.

## Sign in to Azure from Eclipse

1. Start Eclipse if it isn't already running, and open the **SampleWebApp** project.

1. In the Azure Toolkit for Eclipse toolbar, click **Show Azure Explorer**.

    :::image type="content" source="../media/5-start-azure-explorer.png" alt-text="Screenshot of the Azure Toolkit for Eclipse toolbar. The Show Azure Explorer button is highlighted." loc-scope="third-party":::

1. In the **Azure Explorer** window, right-click the **Azure** icon, and then click **Sign in**.

    :::image type="content" source="../media/5-azure-sign-in.png" alt-text="Screenshot of the Azure Explorer window. The user isn't currently signed in." loc-scope="third-party":::

1. On the **Azure Sign In** page, click **Device Login**, and then click **Sign in**.

    :::image type="content" source="../media/5-device-login.png" alt-text="Screenshot of the **Azure Sign In** page. The user has selected Device Login." loc-scope="third-party":::

1. On the **Azure Device Login** window, click **Copy&Open**. This action copies the device code displayed in the window to the clipboard.

    :::image type="content" source="../media/5-device-login-2.png" alt-text="Screenshot of the Azure Device Login window. The user has selected Copy&Open." loc-scope="third-party":::

1. A web browser window will open. At the **Enter code** prompt, paste the device code you copied to the clipboard, and then click **Next**

    :::image type="content" source="../media/5-enter-code.png" alt-text="Screenshot of a browser window, prompting the user to Enter code from the Azure Device Login window.":::

1. When prompted, sign in to Azure with the same account that you used to create the Azure sandbox.

1. In the **Your Subscriptions** page, select the **Concierge Subscription**. This is a subscription created specifically for the sandbox.

    :::image type="content" source="../media/5-subscriptions.png" alt-text="Screenshot of the Your Subscriptions page. The user has selected the Concierge Subscription." loc-scope="third-party":::

## Deploy the web app to your Azure subscription

1. In the **Project Explorer** pane, right-click **SampleWebApp**, select **Azure**, and then click **Publish as Azure Web App**.

    :::image type="content" source="../media/5-publish-web-app-menu.png" alt-text="Screenshot of the Azure menu in Eclipse. The user has selected the Publish as Azure Web App command." loc-scope="third-party":::

1. In the **Deploy Web App** window, click **Create** to create a new Azure App Service.

    :::image type="content" source="../media/5-deploy-web-app.png" alt-text="creenshot of the Deploy Web App window in Eclipse." loc-scope="third-party":::

1. In the **Create App Service** window, specify the following values, and then click **Create**:

    > [!NOTE]
    > The web app must have a unique name. We suggest using something like **[*your name or initials*]samplewebapp**. Use this name wherever you see *[your-webapp-name]* in this exercise.

    | Property | Value |
    |---|---|
    | Name | *[your-webapp-name]* |
    | Subscription | *Concierge Subscription* |
    | Runtime | *Linux* |
    | Linux Runtime | *TOMCAT 8.5-java-11* |
    | App service plan | Select **Create new** and accept the default name and location, but change the **Pricing Tier** to **Free_F1** for this exercise. |
    | Resource Group | *<rgn>[sandbox resource group name]</rgn>* |
    | App Settings | Leave empty |

    :::image type="content" source="../media/5-create-app-service.png" alt-text="Screenshot of the Create App Service window in Eclipse." loc-scope="third-party":::

1. In the **Deploy Web App** window, verify that your new app service is selected, and then click **Deploy** to deploy your web app to Azure.

    :::image type="content" source="../media/5-deploy-to-app-service.png" alt-text="Screenshot of the Deploy Web App window in Eclipse. The web app will be deployed to the newly created app service." loc-scope="third-party":::

    The **Azure Activity Log** window will appear, showing the status of the deployment operation.

    :::image type="content" source="../media/5-azure-activity-log.png" alt-text="Screenshot of the Azure Activity Log window in Eclipse. The web app is being deployed." loc-scope="third-party":::

    Wait until the message in the **Progress** column changes to **Published** before continuing.

## Test the web app in Azure

1. In the **Azure Explorer** window, right-click **Web Apps**, and then click **Refresh**.

2. Expand **Web Apps**. Verify that your new web app is listed.

    :::image type="content" source="../media/5-azure-explorer-web-app.png" alt-text="Screenshot of the Azure Explorer window in Eclipse, showing the new web app." loc-scope="third-party":::

3. Right-click the web app, and then click **Open In Browser**.

    :::image type="content" source="../media/5-web-app-open.png" alt-text="Screenshot of the context menu for the web app in the Azure Explorer window." loc-scope="third-party":::

4. In the web browser, verify that the web app displays similar results to when it ran locally. The main difference will be the IP address, which will be the real IP address of your computer rather than 127.0.0.1 (localhost).

    :::image type="content" source="../media/5-web-app-running.png" alt-text="Screenshot of the web app running in a browser." loc-scope="third-party":::

5. Click the refresh button in the web browser, and verify that the time updates.

6. Close the web browser and return to Eclipse.

Congratulations! You've used the Azure Toolkit for Eclipse to create an App Service in Azure, deploy a web app to your app service, and tested your web app.
