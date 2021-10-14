You can enable Application Insights runtime instrumentation when you create an App Service web application or at any time afterwards.

To start gathering information as soon as possible, the developers of the video-sharing app want to enable Application Insights runtime instrumentation.

In this unit, we'll use the Azure portal to enable runtime instrumentation on a web app. We'll create the app without enabling Application Insights and view the limited performance that's collected by default. We'll then enable Application Insights and see the rich analysis that becomes available.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Create an Azure web app

We'll start by creating a web app to monitor. 

1. Sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).

1. In the resource menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, enter *Web App*, and press <kbd>Enter</kbd>.

1. In the results, select **Web App** by Microsoft, Azure Service. The **Web App**  pane appears.

1. On the **Web App** pane, select **Create**. The **Create Web App** pane appears.

## Configure the web app

Each web app needs a subscription, resource group, name, operating system, region (geographical location), and run time.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | select the subscription you want to use. |
    | Resource Group | Select **Create new**, name the new resource group *mslearn-appinsights*, and then select **OK**. |
    | **Instance Details** |
    | Name | Enter a unique name for your app. For example, you could use *\<yourname\>videoapp*. The name you choose must be unique within the .azurewebsites.net domain. |
    | Publish | Code |
    | Runtime stack | From the dropdown list, select **.NET Core 3.1 (LTS)**. |
    | Operating System | Windows |
    | Region | Select a location close to you. |
    | **App Service Plan** |
    | Windows Plan | Azure creates a unique plan ID; accept the default. |
    | Sku and size | Accept the Azure default, Standard S1. |

1. Select **Review + create**, and then select **Create**. The system displays the resources it creates, and notifies you when deployment is complete.

1. After deployment completes, select **Go to resource**. The App Service pane for your web app appears. Select **Essentials** to minimize the details.

    > [!NOTE]
    > On the top row are 3 services you can select. In this module, the next procedure will show you how to enable Application Insights after the web app is created. You can choose to enable it here, and the end result would be the same.
 
1. Notice that, even without Application Insights, several statistics appear as charts, such as the frequency of HTTP 500 errors, request frequency, and response time.

## Enable Application Insights for the Web App

The limited set of statistics provided in the Azure portal isn't enough to help you diagnose the cause of slow performance in the video app. You want to enable Application Insights to obtain more detailed performance data.

1. You should be on the App Service page for the web app you created. If not, in the Azure portal, search for recent resources, and select the web app (App Service) that you created earlier in this unit.

1. In the App Service menu, under **Settings**, select **Application Insights**. The **Application Insights** pane appears.

    ![Screenshot of web app menu with Application Insights highlighted.](../media/3-web-app-nav-pane.png)

1. Under **Application Insights**, make sure *Collect application monitoring data using Application Insights* is set to **Enable**.

1. Select **Change your resource** to expand that section, and then select **Create new resource** and verify the input fields:

    | Field | Value |
    |---|---|
    | New resource name | Azure assigns a unique resource name based on your app service. Accept default or replace with *videoappinsights*.  |
    |Location | Accept the default, using the location from when you created the web app resource. |
    |Log Analytics Workspace | Accept the default created by Azure. |


1. Select **Apply**. If the **Apply monitoring settings** dialog box appears, select **Yes**.

1. After the changes are applied, in the Azure portal left menu pane, under **Settings**, select **Application Insights**, The **Application Insights** pane appears.

1. Under **Link to an Application Insights resource**, select **videoappinsights** (blue text). The **Application Insights** pane appears for *videoappinsights*.

1. In the command bar, select **Application Dashboard**. The *Shared dashboard* for videoappinsights appears. Note the default charts on this dashboard. If the charts don't appear within a few seconds, select <kbd>F5</kbd> to refresh the page.

## Inject the Application Insights JavaScript SDK into the web app

Because you can inject the Application Insights JavaScript SDK into the video web app without involving developers, and because this will generate more data for performance analysis, you want to enable client-side monitoring. To do this, follow these steps:

1. In the Azure portal, search for and select the App Service resource you created earlier. The *App Service* pane for your web app appears.

1. In the resource menu, under **Settings**, select **Configuration**. The **Configuration** pane appears with the **Application settings** tab active.

1. Under **Application settings**, select **New application setting**.   The **Add/Edit application setting** pane appears.

    ![Screenshot of the application settings tab with a callout highlighting the link to add a new application setting.](../media/3-enable-client-side-monitoring.png)

 1. In the **Name** field, enter *APPINSIGHTS_JAVASCRIPT_ENABLED*.

1. In the **Value** field, enter *true*.

1. Select **OK**.

1. On the **Configuration** pane, in the command bar, select **Save**, and then on **Save changes**, select **Continue**.

1. When the settings have been updated, in the resource menu, select **Overview**. The **Overview** page for your App Service appears.

1. In the command bar, select **Restart**, and when prompted to **Restart app**, select **Yes**.
