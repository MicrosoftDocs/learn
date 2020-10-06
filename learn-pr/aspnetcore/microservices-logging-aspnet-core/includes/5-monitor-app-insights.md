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

- Sample telemetry is displayed in the pane on the right as it's ingested in real-time. You can see that *webshoppingagg* is experiencing failures as it calls services it's dependant on. This is expected behavior while the app is starting. Your telemetry may contain similar failures, depending on when you view the portal.
- Incoming and outgoing dependency requests are represented by real-time graphics. The graphics illustrate the rate, duration, and failure rate of the requests.
- The overall health of the service is displayed in charts representing memory and CPU usage as well as the rate of exceptions.
- The **Servers** pane lists the physical nodes used by the application. In this example, there is only one node. The data on this page can be filtered by node by  selecting the server name from the list.

## Create some telemetry

You must now use the app to generate some telemetry data to examine. Open another browser tab to complete the following steps. While you are completing the steps, observe the results on the the **Live Metrics** view.

1. If needed, run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/3-permissions-secrets/health-check.png" alt-text="Health check page" border="true" lightbox="../media/3-permissions-secrets/health-check.png":::

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 or 502 response from the server. Retry after about one minute. The :::no-loc text="Seq"::: logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. The credentials are provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.
    1. Enter the code *:::no-loc text="GIVEMEFREESTUFF":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box and select **:::no-loc text="APPLY":::**. Note that this is not a valid code.
    1. Enter the code *:::no-loc text="DISC-10":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box for a 10 USD discount, and select **:::no-loc text="APPLY":::**.
    1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.

Application Insights starts tracing all HTTP requests between the services and their dependencies. but it needs some minutes to show more information, that's the reason for asking you to use the application.

If you click on the `Application map` option in the left sidebar, you should see something like this:

:::image type="content" source="../media/application-insights-application-map.png" alt-text="Application map" border="true" lightbox="../media/application-insights-application-map.png":::

In the graph, you can see that the services with Application Insights instrumentation are shown as green-circled nodes. The diagram shows the calls traced between the four microservices and other dependencies such as databases and other microservices that don't have Application Insights instrumentation, along with some information on the call volumes and response times.

You can also look at the log traces, with the Search option in the sidebar:

:::image type="content" source="../media/application-insights-search-log-traces.png" alt-text="Application Insights log traces search view" lightbox="../media/application-insights-search-log-traces.png":::

And can peek into the details of any trace:

:::image type="content" source="../media/application-insights-end-to-end-transaction-details.png" alt-text="TODO" border="true" lightbox="../media/application-insights-end-to-end-transaction-details.png":::

In the next unit, you'll implement a cluster-level monitoring solution using Azure Monitor for containers.