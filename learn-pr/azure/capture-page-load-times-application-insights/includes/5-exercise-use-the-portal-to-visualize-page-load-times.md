Now that Application Insights has been enabled for your web app, you want to analyze the telemetry data that it generates. In this exercise, you use a custom chart to examine how long a page in your app takes to load from the user's perspective.

> [!NOTE]
> If you are using an ad blocker in your browser, you should disable it for this exercise, as it interferes with the client-side JavaScript used to capture Application Insights data.

## Generate and view usage date

In order to display some data in Application Insights, you must start by simulating some user activity. We'll do this manually:

1. In the Azure portal, in the navigation on the left, click **All resources** and then, in the list of resources, click the web app you created in the previous exercise.
1. In the top left of the **Overview** page, click **Browse**. The web app opens in a new browser tab.
1. Reload the web page ten times.
1. Switch back to the browser tab that displays the Azure portal and refresh the web app **Overview** page. The charts on this page should show some requests and responses.
1. In the **Overview** page, click **Application Insights** and then click **View Application Insights data**. The portal displays the Application Insights resource.
1. Examine the data displayed on the **Overview** page. It may be necessary to refresh the page to see data that relates to your page requests. 
1. To see the default dashboard for the Application Insights resource, in the top left of the **Overview** page, click **Application Dashboard**. Examine the data displayed in the default dashboard.
    ![Default Application Insights Dashboard](../media/5-default-app-insights-dashboard.png)

## Customize a chart in the Azure portal

You want to examine page load times for the last thirty minutes in a scatter chart to see how your web app's behavior varies over time. Take the following steps:

1. In the Application Insights dashboard, click **Application Insights**.
    ![Application Insights resource link](../media/5-return-to-app-insights-resource.png)
1. In the **Application Insights** blade, under **Investigate** click **Metrics**.
1. At the top of the **Metrics** page, click **Last 24 hours (Automatic)**.
1. Click **Last 30 minutes** and then click **Apply**.
1. In the **METRIC NAMESPACE** drop-down list, select **Standard metrics (preview)**. 
1. In the **METRIC** drop-down list, select **Browser page load time**.
1. Click **Line chart** and then click **Scatter chart**.

## Create more data and view the custom chart

Let's simulate some more user activity and view the results in our custom chart:

1. Switch back to the browser tab that displays the video web app.
1. Reload the web page ten times.
1. Switch back to the browser tab that displays the Azure portal.
1. To refresh the page, press F5.
1. To see your custom chart, scroll to the right of the dashboard. You should see a data point in the chart that relates to your recent requests.

    ![Custom page load time chart](../media/5-custom-page-load-chart.png)
