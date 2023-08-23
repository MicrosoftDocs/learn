
You install a small instrumentation package in your application and set up an Application Insights resource in the Microsoft Azure portal.

The instrumentation monitors your app and sends telemetry data to the portal. (The application can run anywhere - it doesn't have to be hosted in Azure.)

You can instrument the web service application, background components, and JavaScript in the web pages.

:::image type="content" source="../media/application-insights-a2f02f4e.png" alt-text="Diagram showing the Application Insights and telemetry for alerts, Power BI, Visual Studio, Rest API and Continuous Export.":::


Also, you can pull in telemetry from the host environments such as performance counters, Azure diagnostics, or Docker logs.

You can also set up web tests periodically, sending synthetic requests to your web service.

All these telemetry streams are integrated into the Azure portal, where you can apply powerful analytic and search tools to the raw data.

## What's the overhead?

The impact on your app's performance is minimal. Tracking calls are non-blocking and are batched and sent in a separate thread.

## What do Application Insights monitor?

Application Insights is aimed at the development team to help you understand how your app is doing and being used. It monitors:

 -  Request rates, response times, and failure rates - Find out which pages are most popular, at what times of day, and where your users are. See which pages do best. If your response times and failure rates increase with more requests, perhaps you have a resourcing problem.
 -  Dependency rates, response times, and failure rates - Find out whether external services are slowing you down.
 -  Exceptions - Analyze the aggregated statistics, pick specific instances, and drill into the stack trace and related requests. Both server and browser exceptions are reported.
 -  Pageviews and load performance - reported by your users' browsers.
 -  AJAX calls from web pages - rates, response times, and failure rates.
 -  User and session count.
 -  Performance counters from your Windows or Linux server machines include CPU, memory, and network usage.
 -  Host diagnostics from Docker or Azure.
 -  Diagnostic trace logs from your app - so you can correlate trace events with requests.
 -  Custom events and metrics that you write yourself in the client or server code to track business events such as items sold or games won.

## Where do I see my telemetry?

There are plenty of ways to explore your data. Check out this article for more information - [Smart detection and manual alerts](/azure/application-insights/app-insights-proactive-diagnostics).

Automatic alerts adapt to your app's usual patterns of telemetry and trigger when there's something outside the usual pattern. You can also [set alerts](/azure/azure-monitor/app/alerts) on levels of custom or standard metrics.

:::image type="content" source="../media/set-alerts-52c42e8d.png" alt-text="Screenshot of set alerts showing an abnormal rise in failed request rate in the app fabrikamprod.":::


## Application map

The components of your app, with key metrics and alerts.

:::image type="content" source="../media/application-map-2e670a1b.png" alt-text="Screenshot of the application map with the components of the app, key metrics, and alerts.":::


## Profiler

Inspect the execution profiles of sampled requests.

:::image type="content" source="../media/profiler-3aa6ca54.png" alt-text="Screenshot of the Profiler. Inspect the execution profiles of sampled requests.":::


## Usage analysis

Analyze user segmentation and retention.

:::image type="content" source="../media/usage-analysis-f7bcbb7e.png" alt-text="Screenshot of usage analysis with user segmentation and retention.":::


## Diagnostic search, for instance, data.

Search and filter events such as requests, exceptions, dependency calls, log traces, and page views.

:::image type="content" source="../media/search-filter-7cc4a795.png" alt-text="Screenshot of the search and filter events such as requests, exceptions, dependency calls, log traces, and page views.":::


## Metrics Explorer for aggregated data

Explore, filter, and segment aggregated data such as rates of requests, failures, exceptions, response times, and page load times.

:::image type="content" source="../media/metrics-24659a11.png" alt-text="Screenshot of the metrics and segment aggregated data such as rates of requests, failures, and exceptions, response times, and page load times.":::


## Dashboards

Mash up data from multiple resources and share it with others. Great for multi-component applications and continuous display in the team room.

:::image type="content" source="../media/dashboards-e8b9e1b6.png" alt-text="Screenshot of Dashboards from multiple resources great for multi-component applications and continuous display in the team room.":::


## Live Metrics Stream

When you deploy a new build, watch these near-real-time performance indicators to ensure everything works as expected.

:::image type="content" source="../media/live-metrics-stream-3e84bf0a.png" alt-text="Screenshot of Live Metrics Stream with near-real-time performance indicators.":::


## Analytics

Answer challenging questions about your app's performance and usage by using this powerful query language.

:::image type="content" source="../media/analytics-3ad60c81.png" alt-text="Screenshot of Analytics showing the answer challenging questions about app's performance and usage by using this powerful query language.":::


## Visual Studio

See performance data in the code. Go to code from stack traces.

:::image type="content" source="../media/visual-studio-ff251df7.png" alt-text="Screenshot of Visual Studio showing the performance data in the code.":::


## Snapshot debugger

Debug snapshots sampled from live operations, with parameter values.

:::image type="content" source="../media/snapshot-debugger-59ccb22c.png" alt-text="Screenshot of Snapshot debugger. Debug snapshots sampled from live operations, with parameter values.":::


## Power BI

Integrate usage metrics with other business intelligence.

:::image type="content" source="../media/power-bi-2f24e61f.png" alt-text="Screenshot of Power BI. Integrate usage metrics with other business intelligence.":::


## REST API

Write code to run queries over your metrics and raw data.

:::image type="content" source="../media/rest-api-93d6f73b.png" alt-text="Screenshot of REST API. Write code to run queries over your metrics and raw data.":::


## Continuous export

Bulk export of raw data to storage as soon as it arrives.

:::image type="content" source="../media/bulk-export-ae4fafd3.png" alt-text="Screenshot of Bulk export. Bulk export of raw data to storage as soon as it arrives.":::
