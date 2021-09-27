You can enable Application Insights runtime instrumentation when you create an App Service web application or at any time afterwards.

To start gathering information as soon as possible, the developers of the video-sharing app want to enable Application Insights runtime instrumentation.

In this unit, we'll use the Azure portal to enable runtime instrumentation on a web app. We'll create the app without enabling Application Insights and view the limited performance that's collected by default. We'll then enable Application Insights and see the rich analysis that becomes available.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create an Azure web app

We'll start by creating a web app to monitor. Follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. On the Azure portal menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, enter *Web App*, and press <kbd>Enter</kbd>.

1. In the list of results, select **Web App**. The **Web App** from Microsoft appears.

1. On the **Web App** pane, select **Create**. The **Create Web App** pane appears.

## Configure the web app

You'll need to set up a name, a resource group, a location, and some other properties for your web app.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | select the Azure subscription you'd like to use for this exercise. |
    | Resource Group | Select the **Create new** link, and name the new resource group *mslearn-appinsights*, and select **OK**. |
    | **Instance Details** |
    | Name | Enter a unique name for your app. For example, you could use *\<yourname\>;svideoapp*. The name you choose must be unique within the .azurewebsites.net domain. |
    | Publish | Code |
    | Runtime stack | From the dropdown list, select **.NET Core 3.12 (LTS)**. |
    | Operating System | Windows |
    | Region | Choose a location close to you. |
    | **App Service Plan** |
    | Windows Plan | Accept default. |
    | Sku and size | Accept default. |

1. Select **Review + create**, and then select **Create**.

1. After deployment completes, select **Go to resource**. Your App Service pane appears. On its **Overview** page, notice that, even without Application Insights, some statistics appear, like the frequency of 500 errors and the rate of requests.

    > [!NOTE]
    > In this module, you'll enable Application Insights as a separate step, after the web app is created. If you were to enable it here, the end result would be the same.

## Enable Application Insights for the Web App

The limited set of statistics provided in the Azure portal isn't enough to help you diagnose the cause of slow performance in the video app. You want to enable Application Insights to obtain more detailed performance data.

To enable Application Insights on an app, follow these steps:

1. If the Web App's pane isn't already visible, in the Azure portal, search for and select the web app you created earlier in this unit.

1. In the left menu pane, under **Settings**, select **Application Insights**.

    ![Screenshot of web app navigation pane with callout highlighting the Application Insights option.](../media/3-web-app-nav-pane.png)

    The **Application Insights** pane appears.

1. Under **Application Insights**, make sure **Enable** is selected.

1. Expand **Change your resource**, and select **Create new resource**.

1. In the **New resource name** field, enter *videoappinsights*.

1. In the **Location** field, select a location.

1. Select **Apply**. If the **Apply monitoring settings** dialog box appears, select **Yes**.

1. After the changes are applied, in the Azure portal left menu pane, under **Settings**, select **Application Insights**, The **Application Insights** pane appears.

1. Under **Link to an Application Insights resource**, select **videoappinsights** (blue text). The **Application Insights** pane appears for *videoappinsights*.

1. In the top menu bar, select **Application Dashboard**. The **Shared dashboard** appears. Note the charts shown by default in the dashboard. If the charts don't appear within a few seconds, select <kbd>F5</kbd> to refresh the page.

## Inject the Application Insights JavaScript SDK into the web app

Because you can inject the Application Insights JavaScript SDK into the video web app without involving developers, and because this will generate more data for performance analysis, you want to enable client-side monitoring. To do this, follow these steps:

1. If the web app's pane isn't already visible, in the Azure portal, search for and select the App Service you created earlier. Your **App Service** pane appears.

1. In the left menu pane, under **Settings**, select **Configuration**. The **Configuration** pane appears for your *App Service*. You will be on the **Application settings** tab.

1. Under **Application settings**, select **New application setting**.

    ![Screenshot of the application settings tab with a callout highlighting the link to add a new application setting.](../media/3-enable-client-side-monitoring.png)

    The **Add/Edit application setting** pane appears.

1. In the **Name** field, enter *APPINSIGHTS_JAVASCRIPT_ENABLED*.

1. In the **Value** field, enter *true*.

1. Select **OK**.

1. On the **Configuration** pane, in the top menu bar, select **Save**, and in the **Save changes** dialog box that appears, select **Continue**.

1. In the left menu pane, select **Overview**. The **Overview** page appears for your App Service.

1. In the top menu bar, select **Restart**, and in the **Restart app** dialog box, select **Yes**.
