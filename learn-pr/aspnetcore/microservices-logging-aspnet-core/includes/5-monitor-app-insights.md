In this unit, you'll monitor your app from the Azure portal using Application Insights.

## Explore live metrics

Since you've instrumented four services for Application Insights, those services are sending telemetry to Application Insights whenever the app is running. To view the telemetry as it's ingested, complete the following steps:

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) using the same subscription used in previous units.
1. Use the search box to find and open the resource group `eshop-learn-rg`.
1. Select the *webshoppingagg* Application Insights resource.
1. Select the **Live Metrics** menu item on the left.

A view similar to the following appears:

:::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-live-metrics.png" alt-text="Azure portal showing the live metrics dashboard for the webshoppingagg-appinsights resource" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-live-metrics.png":::

In the preceding image, notice the following:

- Sample telemetry is displayed in the pane on the right as it is ingested in real-time. In the screenshot, you can see that the webshoppingagg service is experiencing failures as it calls services it's dependant on. This is expected behavior while the service is starting. Your telemetry may contain similar failures, depending on when you view the portal.
- Incoming and outgoing dependency requests are represented by real-time graphics. The graphics illustrate the rate, duration, and failure rate of the requests.
- The overall health of the service is displayed in charts representing memory and CPU usage as well as the rate of exceptions.
- The **Servers** pane lists the physical nodes used by the application. In this example, there is only one node. The data on this page can be filtered by node by  selecting the server name from the list.

## 

Application Insights starts tracing all calls between the services and their dependencies, but it needs some minutes to show more information, that's the reason for asking you to use the application.

If you click on the `Application map` option in the left sidebar, you should see something like this:

:::image type="content" source="../media/application-insights-application-map.png" alt-text="Application map" border="true" lightbox="../media/application-insights-application-map.png":::

In the graph, you can see that the services with Application Insights instrumentation are shown as green-circled nodes. The diagram shows the calls traced between the four microservices and other dependencies such as databases and other microservices that don't have Application Insights instrumentation, along with some information on the call volumes and response times.

You can also look at the log traces, with the Search option in the sidebar:

:::image type="content" source="../media/application-insights-search-log-traces.png" alt-text="Application Insights log traces search view" lightbox="../media/application-insights-search-log-traces.png":::

And can peek into the details of any trace:

:::image type="content" source="../media/application-insights-end-to-end-transaction-details.png" alt-text="TODO" border="true" lightbox="../media/application-insights-end-to-end-transaction-details.png":::

In the next unit, you'll implement a cluster-level monitoring solution using Azure Monitor for containers.