Data about a web app captured by Application Insights can be viewed using many different kinds of visualizations in the Azure portal.

In the video-sharing app scenario, data captured about the app needs to be analyzed to determine the cause of poor performance.

In this unit, you will learn how to navigate the data in the Application Insights resource and dashboards and how to drill into a specific aspect of the web app's behavior, by creating a custom chart.

## Tools to visualize data

Now that you have enabled an Application Insights resource to gather metrics from the web app, you can view and analyze that data to diagnose issues if they arise. There are several tools you can use to display that data:

- **The Azure portal.** Navigating to the Application Insights resource in the portal reveals a variety of tools, including a set of common performance charts on the **Overview** page, an **Application map**, and **Performance** and **Failures** pages. You also have an Application Insights dashboard with a common set of charts. You can use the **Metrics** page to design new charts and add them to dashboards.
- **Microsoft PowerBI.** This tool is often used by business analysts to investigate business values such as sales and profit margins. However, you can connect Power BI to an Application Insights resource and use it to display web app telemetry data.
- **Microsoft Visual Studio.** Developers can connect the Visual Studio to Application Insights and view the same charts and displays that are shown in the Azure portal. It is very convenient to see code and performance data in the same tool.
- **Custom tools.** Application Insights includes a comprehensive API for accessing telemetry and analytics. Custom tools and applications can use the API to power their own displays. For example, if you have a custom mobile app that your business decision makers use to view sales data, you could add a display of web site performance statistics to that app.

In this module, we'll view data in the Azure portal.

## Custom charts

While there are many useful charts and displays in both the Application Insights resource and in the dashboard, sometimes you will need to create a custom display. In the Application Insights resource blade you can create your own displays on the the Metrics page. For example, you can:

- Specify a time period for the chart. This could be the last 30 minutes to 30 days or you could specify a start and end time for the period that interests you.
- Specify the type of chart: line, area, bar, or scatter.
- Specify a metric to display. This metric will be shown on the vertical axis.
- Specify an aggregation method. This choice specifies whether the chart will show the average, minimum, maximum, sum, or count for the chosen metric at each plotted point.
- Specify a filter. Data that does not satisfy the filter will not be displayed. Use filters when you need to focus on a very specific data set.

![Creating a custom chart in Application Insights](../media/4-custom-chart-creation.png)

Once you have created the chart you need, you can pin it to an Application Insights dashboard to save it and then publish the dashboard to share it with other users and stakeholders.

## Navigate to the Application Insights resource and dashboard

The Application Insights resource is separate from the App Service resource that contains the instrumented web app. In the Azure portal, you can see both resources on the **All resources** blade and click on them to see their details or make configuration changes.

Enabling runtime instrumentation in a Web App creates a link in the Azure portal from the web app resource to the Application Insights resource that receives the data. From the web app, you can navigate to the **Application Insights** page and click **View Application Insights data** to navigate to that Application Insights resource and make configuration changes. From there, click **Application Dashboard** on the **Overview** page to see the dashboard for that resource.

Another way to view the Application Insights dashboard is to click **Dashboard** in the main Azure portal navigation on the left. If there is more than one dashboard stored for your user account, you may need to switch to the right Application Insights dashboard by selecting it in the top left drop-down list.

![Selecting a dashboard](../media/4-selecting-a-dashboard.png)