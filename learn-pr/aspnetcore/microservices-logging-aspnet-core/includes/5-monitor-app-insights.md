In this unit, you'll monitor your app from the Azure portal using Application Insights.

## Explore live metrics

The four services instrumented for Application Insights send telemetry to Application Insights whenever the app is running. To view the telemetry as it's ingested, complete the following steps:

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) using the same subscription used in previous units.
1. Use the search box to find and open the resource group *eshop-learn-rg*.
1. Select the *webshoppingagg* Application Insights resource.
1. Select **Live Metrics** from the **Investigate** section.

A view similar to the following appears:

:::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-live-metrics.png" alt-text="Azure portal showing the live metrics dashboard for the webshoppingagg-appinsights resource" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-live-metrics.png":::

In the preceding image, notice the following things:

- Sample telemetry is displayed in the pane on the right as it's ingested in real time. You can see that *webshoppingagg* is experiencing failures as it calls services on which it depends. This behavior is expected while the app is starting. Your telemetry may contain similar failures, depending on when you view the portal.
- Incoming and outgoing dependency requests are represented by real-time graphics. The graphics illustrate the rate, duration, and failure rate of the requests.
- The service's overall health is displayed in charts representing memory, CPU usage, and exceptions rate.
- The **Servers** pane lists the physical nodes used by the application. In this example, there's a single node. The data on this page can be filtered by node by selecting the server name from the list.

## Create some telemetry

Use the app to generate some telemetry data to examine. Open another browser tab to complete the following steps. While you're completing the steps, observe the results on the **Live Metrics** view.

1. If needed, run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/5-monitor-app-insights/health-check.png" alt-text="Health check page" border="true" lightbox="../media/5-monitor-app-insights/health-check.png":::

    > [!NOTE]
    > While the app is starting, you might initially receive an HTTP 503 or 502 response from the server. Retry after about one minute. The :::no-loc text="Seq"::: logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.
    1. Enter the code *:::no-loc text="GIVEMEFREESTUFF":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box and select **:::no-loc text="APPLY":::**. This code is invalid.
    1. Replace the code *:::no-loc text="GIVEMEFREESTUFF":::* with *:::no-loc text="DISC-10":::* for a 10 USD discount. Select **:::no-loc text="APPLY":::**.
    1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.

Application Insights will capture telemetry from each of the four instrumented services. The telemetry captured represents HTTP and SQL requests to/from the services. As the telemetry is captured, it's ingested by endpoints in Azure. The ingestion process takes a few minutes.

## Examine application map

A good place to view the overall health of your app in Application Insights is the application map. The application map:

- Shows a graphical representation of the service and its dependencies.
- Can be used to investigate failures and performance issues.

Investigate the earlier failed coupon service request with the following steps:

1. Select **Application map** from the **Investigate** section.

    :::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-initial-app-map.png" alt-text="The initial view of the webshoppingagg application map" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-initial-app-map.png":::

    A view similar to the preceding screenshot appears. The application map initially displays a simplified representation of the *webshoppingagg* app. This view doesn't list individual dependencies.

1. Select the **Update map components** button to load a detailed view of the entire *:::no-loc text="eShopOnContainers":::* solution.

    :::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-detail-app-map.png" alt-text="The detailed application map" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-detail-app-map.png":::

    A view similar to the preceding screenshot appears. The services that are instrumented in Application Insights are represented by green circles.

1. Select the green *webshoppingagg* circle.

    A **webshoppingagg** panel appears:

    :::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-request-summary.png" alt-text="A summary of failing requests and performance" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-request-summary.png":::

    A summary similar to the preceding image appears. The summary provides a quick view of the service's top failing requests and slowest requests. It also displays common properties that may help provide insights into the health of the service. For each category, more detailed information is available by selecting the button.

## Investigate an end-to-end transaction

The application map provides one way of exploring captured telemetry. You can also search for a request using known criteria. To search for a request and investigate the end-to-end transaction, complete the following steps:

1. Select **Search** from the **Investigate** section.
1. In the **Search** text box, enter *:::no-loc text="GIVEMEFREESTUFF":::* and press <kbd>Enter</kbd>.

    A variation of the following page appears:

    :::image type="content" source="../media/5-monitor-app-insights/givemefreestuff-search-results.png" alt-text="event search results matching the term 'GIVEMEFREESTUFF'" border="true" lightbox="../media/5-monitor-app-insights/givemefreestuff-search-results.png":::

1. Select the **Add filter** button.

    :::image type="content" source="../media/5-monitor-app-insights/add-filter-button.png" alt-text="Add filter button" border="true" lightbox="../media/5-monitor-app-insights/add-filter-button.png":::

1. In the **Filter** panel that appears, enter *Tele* in the **Properties** text box. Select the *trace* box, and select the **Done** button.

    The *webshoppingagg* search results page refreshes to only show *TRACE* events:

    :::image type="content" source="../media/5-monitor-app-insights/givemefreestuff-trace-search-results.png" alt-text="TRACE event search results matching the term 'GIVEMEFREESTUFF'" border="true" lightbox="../media/5-monitor-app-insights/givemefreestuff-trace-search-results.png":::

1. In the result set, select a **TRACE** item with the description `----- Coupon not found: 404 - Content: "ERROR: The coupon doesn't exist"`. An end-to-end transaction trace appears.

:::image type="content" source="../media/5-monitor-app-insights/end-to-end-transaction-details.png" alt-text="end-to-end transaction details for a TRACE event" border="true" lightbox="../media/5-monitor-app-insights/end-to-end-transaction-details.png":::

1. Notice the trace includes each step of the request.
    - The initial request is received by *webshoppingagg*.
        - An **INFORMATION** log entry with the text `----- Getting discount coupon: "GIVEMEFREESTUFF"` is logged.
        - An **INFORMATION** log entry with the text `----- WebAggregator --> Coupon-API: "GIVEMEFREESTUFF"` is logged.
    - *webshoppingagg* makes an HTTP request to the *coupon* service at the path `GET /api/v1/coupon/GIVEMEFREESTUFF`.
    - Since the preceding request fails, the overall request fails.
        - An **INFORMATION** log entry beginning with the text `----- WebAggregator <-- Coupon-API: HttpResponseMessage` is logged.
        - A **WARNING** log entry with the text `----- Coupon not found: 404 - Content: "ERROR: The coupon doesn't exist"` is logged.

    Each item in the list may be selected for additional information.

1. Select the **View timeline** button. A graphical representation of the request and dependency timing is displayed.

    :::image type="content" source="../media/5-monitor-app-insights/end-to-end-transaction-timeline.png" alt-text="end-to-end transaction timeline" border="true" lightbox="../media/5-monitor-app-insights/end-to-end-transaction-timeline.png":::

    In the preceding screenshot, notice that an HTTP GET request was sent to the coupon service's `Coupon` controller. 327.4 milliseconds elapsed before the controller's `GetCouponByCode` action method responded with an HTTP 404 status code.

Application Insights provides a powerful view into your related services in a microservices app. In this unit, you added Application Insights to a service and explored telemetry gathered from four services in the app. Next, you'll monitor the infrastructure health of your AKS cluster.
