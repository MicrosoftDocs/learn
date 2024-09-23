Visualizations such as charts and graphs can help you analyze your monitoring data to drill down on issues and identify patterns. Depending on the tool you use, you might also be able to share these visualizations with other users inside and outside of your organization.

In this unit, you explore some of the ways you can build a monitoring and status dashboard for your application. You'll look at:

* Azure dashboards
* Azure Monitor workbooks
* Application Insights workbooks
* Power BI
* Grafana
* Building your own custom application

## What are Azure dashboards?

[Dashboards](/azure/azure-portal/azure-portal-dashboards?azure-portal=true) allow you to create a focused and organized view in the Azure portal of your cloud resources. They provide a "single pane of glass" over your Azure infrastructure and services, helping you to identify important issues more quickly.

Here's an example dashboard:

:::image type="content" source="../media/3-azure-dashboards.png" alt-text="A screenshot of an example Monitoring and Analytics dashboard.":::

### Advantages of Azure dashboards

Azure dashboards provide:

* Integration with Azure services. You can pin visualizations to your dashboard from multiple Azure pages including metrics analytics, log analytics, and Application Insights.
* Support for both metrics and log data.
* A way to combine data from multiple sources, including output from:
  * [Metrics Explorer](/azure/azure-monitor/platform/metrics-charts?azure-portal=true)
  * [Log queries](/azure/azure-monitor/log-query/log-query-overview?azure-portal=true)
  * [Application Map](/azure/azure-monitor/app/app-map?azure-portal=true)
* An option for personal or shared dashboards. Dashboards are integrated with Azure [role based authentication](/azure/role-based-access-control/overview?azure-portal=true) (RBAC).
* Automatic refresh.
* Parametrized metrics dashboards with timestamp and custom parameters.
* Flexible layout options.
* Full screen mode.

### Limitations of Azure dashboards

Azure dashboards don't provide:

* Full control over log visualizations.
* Custom parameters support for log charts.
* Log charts data older than 30 days.
* Interactivity with dashboard data.
* Full contextual drill-down.

## What are Azure Monitor workbooks?

[Views in Azure Monitor](/azure/azure-monitor/visualize/view-designer?azure-portal=true) enable you to create custom visualizations with log data. Monitoring solutions use them to present the data they collect.

:::image type="content" source="../media/3-azure-monitor-views.png" alt-text="A screenshot showing Azure Monitor workbooks.":::

### Advantages of Azure Monitor workbooks

Azure Monitor workbooks provide:

* Rich visualizations for log data.
* Export and import views to transfer them to other resource groups and subscriptions.
* Integration with Log Analytic management model with workspaces and monitoring solutions.
* [Filters](/azure/azure-monitor/visualize/view-designer-filters?azure-portal=true) for custom parameters.
* Interactive views that can drill down into other views.

### Limitations of Azure Monitor workbooks

Azure Monitor workbooks don't:

* Support metrics data.
* Provide personal views; rather, views are available to all users with access to the workspace.
* Refresh data automatically.
* Provide full layout options.
* Provide support for querying across multiple workspaces or Application Insights applications.
* Allow response sizes to exceed 8 MB or query execution time to exceed 110 seconds.

## What are Application Insights workbooks?

[Workbooks](/azure/azure-monitor/visualize/workbooks-overview?azure-portal=true) are interactive documents that provide deep insights into your data, investigation, and collaboration inside the team. Workbooks can serve as a troubleshooting guide or to capture details from an incident postmortem.

Here's a diagram to give you a sense of what a workbook looks like:

:::image type="content" source="../media/3-application-insights-workbooks.png" alt-text="A composite screenshot of an example Workbook showing pages for Analysis of Page Views, Usage, and Time Spent on Page.":::

### Advantages of Application Insights workbooks

Application Insights workbooks:

* Support both metrics and logs.
* Support parameters that allow you to build interactive reports.

    For example, you might select an element in a table to dynamically update other charts and visualizations.
* Provide a document-like flow.
* Provide options for personal or shared workbooks.
* Provide templates that support public GitHub template galleries.

### Limitations of Application Insights workbooks

Application Insights workbooks don't:

* Refresh data automatically.
* Provide a dense layout like dashboards provide. This makes workbooks less useful as a "single pane of glass."

## What is Power BI?

[Power BI](/power-bi/fundamentals/service-get-started) allows you to create business-centric dashboards and reports, as well as reports analyzing long-term KPI trends. You can [import the results of a log query](/azure/azure-monitor/logs/log-powerbi?azure-portal=true) into a Power BI dataset so you can combine data from different sources and share reports on the web and on mobile devices.

Here's what Power BI looks like:

:::image type="content" source="../media/3-power-bi.png" alt-text="A screenshot of an example Power BI dashboard showing monitoring for IT Operations.":::

### Advantages of Power BI

Power BI provides:

* Rich visualizations.
* Extensive interactivity including zoom and cross-filtering.
* An easy way to share reports with your organization.
* Integration with multiple data sources.
* High performance with results cached in a cube.

### Limitations of Power BI

Power BI doesn't:

* Support log data.
* Integrate with Azure services; for example, you can't manage dashboards or models through Azure Resource Manager.
* Refresh data more than eight times per day.

## Grafana

[Grafana](https://grafana.com/?azure-portal=true) is an open platform that provides operational dashboards. It helps you detect, isolate, and triage operational incidents. You can add the [Grafana Azure Monitor data source plugin](/azure/azure-monitor/visualize/grafana-plugin?azure-portal=true) to your Azure subscription to visualize your Azure metrics data.

Here's what Grafana looks like:

:::image type="content" source="../media/3-graphana.png" alt-text="A screenshot showing Grafana.":::

### Advantages of Grafana

Grafana provides:

* Rich visualizations.
* A rich ecosystem of data sources.
* Data interactivity, including zoom.

### Limitations of Grafana

Grafana doesn't:

* Support metrics data.
* Integrate with Azure services; for example, you can't manage dashboards or models through Azure Resource Manager.

## Build your own custom application

You can access log and metric data in Azure Monitor through its API by using REST calls. This feature lets you build your own custom websites and applications.

### Advantages of building your own custom application

With a custom application, you have:

* Complete flexibility in the presentation (UI), visualization, interactivity, and features.
* Control over which metrics and log data you combine with other data sources.

### Limitations of building your own custom application

With a custom application, it's up to you to build the functionality that you need. Significant engineering effort may be required.
