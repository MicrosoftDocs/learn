In this unit, you'll monitor your app from the Azure portal using Application Insights.

## Explore live metrics

The four services instrumented for Application Insights send telemetry to Application Insights whenever the app is running. To view the telemetry as it's ingested, complete the following steps:

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) using the same subscription used in previous units.
1. Use the search box to find and open the resource group *:::no-loc text="eshop-learn-rg":::*.
1. Select the *:::no-loc text="webshoppingagg":::* Application Insights resource.
1. Select **Live Metrics** from the **Investigate** section.

A view similar to the following appears:

:::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-live-metrics.png" alt-text="Azure portal showing the live metrics dashboard for the webshoppingagg-appinsights resource" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-live-metrics.png":::

In the preceding image, notice the following things:

- Telemetry data is displayed in the **Sample telemetry** panel as it's ingested in real time. You can see that the HTTP aggregator is experiencing failures when connecting to services on which it depends. This behavior is expected while the app is starting. Your telemetry may contain similar failures, depending on when you view the Azure portal.
- Incoming and outgoing dependency requests are represented by real-time graphics. The graphics illustrate the rate, duration, and failure rate of the requests.
- The service's overall health is displayed in charts representing memory, CPU usage, and exceptions rate.
- The **Servers** pane lists the physical nodes used by the app. In this example, there's a single node. The data on this page can be filtered by node by selecting the server name from the list.

> [!NOTE]
> Your **Sample telemetry** panel might be empty. The next section creates some telemetry to observe.

## Create some telemetry

Use the app to generate some telemetry data to examine. Open another browser tab to complete the following steps. While you're completing the steps, observe the results on the **Live Metrics** view.

1. If needed, run the following command in the Cloud Shell to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

1. Select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **:::no-loc text="CHECKOUT":::** button.
    1. Enter the code *:::no-loc text="GIVEMEFREESTUFF":::* in the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box and select **:::no-loc text="APPLY":::**.

        Because this code is invalid, the message **ERROR: The coupon doesn't exist!** appears. You'll see this error message when you examine the telemetry later in this unit.
    1. Replace the code *:::no-loc text="GIVEMEFREESTUFF":::* with *:::no-loc text="DISC-10":::* for a 10 USD discount. Select **:::no-loc text="APPLY":::**.
    1. Select **:::no-loc text="PLACE ORDER":::** to complete the purchase.

Application Insights will capture telemetry from each of the four instrumented services. The telemetry captured represents HTTP and SQL requests to/from the services. As the telemetry is captured, it's ingested by endpoints in Azure. The ingestion process takes a few minutes.

## Examine Application Map

A good place to view the overall health of your app in Application Insights is the Application Map. The Application Map:

- Shows a graphical representation of the service and its dependencies.
- Can be used to investigate failures and performance issues.

Investigate the earlier failed coupon service request with the following steps:

1. In the Azure portal, select **Application Map** from the **Investigate** section.

    :::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-initial-app-map.png" alt-text="The initial view of the webshoppingagg Application Map" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-initial-app-map.png":::

    A view similar to the preceding screenshot appears. The Application Map initially displays a simplified representation of the *:::no-loc text="webshoppingagg":::* app. This view doesn't list individual dependencies.

    > [!IMPORTANT]
    > Ingestion of Application Insights telemetry takes 1-5 minutes. If your results don't appear similar to the preceding image, wait a few minutes and try again.

1. Select the **Update map components** button to load a detailed view of the entire *:::no-loc text="eShopOnContainers":::* solution.

    :::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-detail-app-map.png" alt-text="The detailed Application Map" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-detail-app-map.png":::

    A view similar to the preceding screenshot appears. The services that are instrumented in Application Insights are represented by green circles.

1. Select the green *:::no-loc text="webshoppingagg":::* circle.

    A **:::no-loc text="webshoppingagg":::** panel appears. The panel provides a quick view of the service's top failing requests and slowest requests. It also displays common properties that may provide insights into the health of the service. For each category, more detailed information is available by selecting the button.

    :::image type="content" source="../media/5-monitor-app-insights/webshoppingagg-request-summary.png" alt-text="A summary of failing requests and performance" border="true" lightbox="../media/5-monitor-app-insights/webshoppingagg-request-summary.png":::

## Investigate an end-to-end transaction

The Application Map provides one way of exploring captured telemetry. You can also search for a request using known criteria. To search for a request and investigate the end-to-end transaction, complete the following steps:

1. Select **Search** from the **Investigate** section to open the transaction search panel.
1. In the **Search** text box, enter *:::no-loc text="GIVEMEFREESTUFF":::* and press <kbd>Enter</kbd>.

    A variation of the following page appears:

    :::image type="content" source="../media/5-monitor-app-insights/givemefreestuff-search-results.png" alt-text="event search results matching the term 'GIVEMEFREESTUFF'" border="true" lightbox="../media/5-monitor-app-insights/givemefreestuff-search-results.png":::

1. Select the **Event types** button. Unselect all options except for *Trace*.

    :::image type="content" source="../media/5-monitor-app-insights/event-types-trace.png" alt-text="Event types Trace option" border="true" lightbox="../media/5-monitor-app-insights/event-types-trace.png":::

    The *:::no-loc text="webshoppingagg":::* search results page refreshes to only show *TRACE* events:

    :::image type="content" source="../media/5-monitor-app-insights/givemefreestuff-trace-search-results.png" alt-text="TRACE event search results matching the term 'GIVEMEFREESTUFF'" border="true" lightbox="../media/5-monitor-app-insights/givemefreestuff-trace-search-results.png":::

1. In the result set, select a **TRACE** item with the description `----- Coupon not found: 404 - Content: "ERROR: The coupon doesn't exist"`. An end-to-end transaction trace appears.

    :::image type="content" source="../media/5-monitor-app-insights/end-to-end-transaction-details.png" alt-text="end-to-end transaction details for a TRACE event" border="true" lightbox="../media/5-monitor-app-insights/end-to-end-transaction-details.png":::

1. Notice the trace includes each step of the request:
    1. The initial request is received by the HTTP aggregator:
        - An **INFORMATION** log entry with the text `----- Getting discount coupon: "GIVEMEFREESTUFF"` is logged. That message is logged via a `LogInformation` call in the `CheckCouponAsync` action method of *:::no-loc text="src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Controllers/CouponController.cs":::*:

            :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/controllers/couponcontroller.cs" id="snippet_CheckCouponAsync" highlight="7":::

        - An **INFORMATION** log entry with the text `----- WebAggregator --> Coupon-API: "GIVEMEFREESTUFF"` is logged. That message is logged via a `LogInformation` call in the `CheckCouponByCodeNumberAsync` method of *:::no-loc text="src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Services/CouponService.cs":::*:

            :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/services/couponservice.cs" id="snippet_CheckCouponByCodeNumberAsync" highlight="3":::

    1. The HTTP aggregator makes a request to the coupon service at the path `GET /api/v1/coupon/GIVEMEFREESTUFF`.
    1. Since the preceding request fails, the overall request fails:
        - An **INFORMATION** log entry beginning with the text `----- WebAggregator <-- Coupon-API: HttpResponseMessage` is logged. That message is logged via a `LogInformation` call in the `CheckCouponByCodeNumberAsync` method of *:::no-loc text="src/ApiGateways/Aggregators/Web.Shopping.HttpAggregator/Services/CouponService.cs":::*:

            :::code language="csharp" source="../code/src/apigateways/aggregators/web.shopping.httpaggregator/services/couponservice.cs" id="snippet_CheckCouponByCodeNumberAsync2" highlight="3":::

        - A **WARNING** log entry with the text `----- Coupon not found: 404 - Content: "ERROR: The coupon doesn't exist"` is logged. That message is logged because of the following code in the `GetCouponByCodeAsync` action method of *:::no-loc text="src/Services/Catalog/Catalog.API/Controllers/CouponController.cs":::*:

            :::code language="csharp" source="../code/src/services/catalog/catalog.api/controllers/couponcontroller.cs" id="snippet_GetCouponByCodeAsync" highlight="13-15":::

    Each item in the list may be selected for additional information.

1. Select the **View timeline** button. A graphical representation of the request and dependency timing is displayed.

    :::image type="content" source="../media/5-monitor-app-insights/end-to-end-transaction-timeline.png" alt-text="end-to-end transaction timeline" border="true" lightbox="../media/5-monitor-app-insights/end-to-end-transaction-timeline.png":::

    In the preceding screenshot, notice the following details:

    - The initial HTTP request was received by the HTTP aggregator.
    - Two requests were sent to the identity service for token authentication. Those requests were successful, as seen by their HTTP 200 status codes.
    - An HTTP GET request was sent to the coupon service's `CouponController` class.
    - The coupon service made similar identity service requests, which were also successful.
    - After roughly another 200 milliseconds, the controller's `GetCouponByCode` action method responded with an HTTP 404 status code.
    - The elapsed time for the entire operation is 788 milliseconds. 374 milliseconds of that time is the HTTP aggregator waiting on the coupon service's response.

Application Insights provides a powerful view into your related services in a microservices app. In this unit, you added Application Insights to a service and explored telemetry gathered from four services in the app. Next, you'll monitor the infrastructure health of your AKS cluster.
