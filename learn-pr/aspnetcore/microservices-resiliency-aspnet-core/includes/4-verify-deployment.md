
You can continue investigating this solution while the script finishes deploying Docker containers to Azure Kubernetes Service (AKS).

## Review code

Review the directories in the explorer pane in the IDE. Relative to the workspace root, the files for this module are located in the directory *modules/microservices-resiliency-aspnet-core*.

> [!IMPORTANT]
> For brevity, all directory paths described in this module are relative to the *modules/microservices-resiliency-aspnet-core* directory.

The following subdirectories located in *src* contain .NET projects, each of which is containerized and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *:::no-loc text="ApiGateways/":::* | Services to aggregate across multiple microservices for certain cross-service operations. An HTTP aggregator is implemented in the *:::no-loc text="ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::* project. |
| *:::no-loc text="BuildingBlocks/":::* | Services that provide cross-cutting functionality, such as the app's event bus used for interservice events. |
| *:::no-loc text="Services/":::* | These projects implement the business logic of the app. Each microservice is autonomous, with its own data store. They showcase different software patterns, including Create-Read-Update-Delete (CRUD), Domain-Driven Design (DDD), and Command and Query Responsibility Segregation (CQRS). The new *:::no-loc text="Coupon.API":::* project has been provided, but it's not resilient. |
| *:::no-loc text="Web/":::* | ASP.NET Core apps that implement user interfaces. *:::no-loc text="WebSPA":::* is a storefront UI built with Angular. *:::no-loc text="WebStatus":::* is the health checks dashboard for monitoring the operational status of each service. |

## Verify deployment to AKS

After the app has deployed to AKS, a variation of the following message appears in the terminal:

```console
The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

You can begin exploring these services (when ready):
- Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://203.0.113.55/webstatus/ (See overall service status)
- Web SPA application       : http://203.0.113.55/
```

> [!TIP]
> This output can be found in *modules/microservices-resiliency-aspnet-core/deployment-urls.txt*.

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Select the **General application status** link in the terminal to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page is designed to refresh automatically, every 10 seconds.

    > [!IMPORTANT]
    > If the WebStatus isn't automatically refreshing, it's due to an issue with the container image used for WebStatus. To work around the issue, manually refresh the WebStatus page periodically.

    :::image type="content" source="../media/4-verify-deployment/health-checks-status-page.png" alt-text="Screenshot of health checks status dashboard." border="true" lightbox="../media/4-verify-deployment/health-checks-status-page.png":::

    > [!NOTE]
    > While the app starts up, you might initially receive an *HTTP 503* response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **Centralized logging** URL, are available before the other endpoints.

1. After all the services are healthy, select the **Web SPA application** link in the terminal to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="Screenshot of the eShop single page app." border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **LOGIN** link in the upper right to sign into the app. The credentials are provided on the page. Select the **:::no-loc text="Remember me?":::** check box to avoid signing in again.
    1. Add the **.NET BLUE HOODIE** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**, and then select **PLACE ORDER** to complete the purchase.

    :::image type="content" source="../../media/microservices/eshop-spa-shopping-bag.png" alt-text="Screenshot of the shopping cart with .NET blue hoodie." border="true" lightbox="../../media/microservices/eshop-spa-shopping-bag.png":::

You successfully verified that the app was deployed to AKS and is working properly.

## Explore the response of a non-resilient app

Complete the following steps to see how the app responds without a resiliency solution in place.

### Configure simulated failure

The coupon service was designed to simulate failures on demand. You can configure simulated failures by using special syntax for coupon codes. To simulate a failure, you need at least one item in the basket. Complete the following steps:

1. Select the **:::no-loc text="CONTINUE SHOPPING":::** button.
1. Select the **:::no-loc text=".NET FOUNDATION PIN":::**.
1. Select the basket icon.
1. Select **:::no-loc text="CHECKOUT":::**.
1. In the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box at the bottom of the page, enter the code *:::no-loc text="FAIL 2 DISC-10":::*.

    This code causes the coupon service raise an exception twice, when validating the *:::no-loc text="DISC-10":::* discount code.
1. Select the **:::no-loc text="APPLY":::** button.

    You'll receive the following confirmation message with the number of failures configured for the code: **:::no-loc text="CONFIG: 2 failure(s) configured for code \"DISC-10\"!!":::**.

    :::image type="content" source="../media/4-verify-deployment/configure-coupon-failures.png" alt-text="Screenshot of the discount code field with coupon failures displayed." border="true" lightbox="../media/4-verify-deployment/configure-coupon-failures.png" :::

This configuration causes the next two requests for the *:::no-loc text="DISC-10":::* code to throw an exception.

### Apply the failing discount coupon

1. Replace the existing discount code with *:::no-loc text="DISC-10":::*.
1. Select the **:::no-loc text="APPLY":::** button. The message **:::no-loc text="ERROR: 500 - Internal Server Error!":::** appears.
1. Select the **:::no-loc text="APPLY":::** button again. The same message appears again.
1. Select the **:::no-loc text="APPLY":::** button for a third time. This time, the code validation succeeds and the 10 US dollar (USD) discount is applied to the order.
1. Select the **:::no-loc text="Centralized logging":::** link in the terminal, or find the URL in *deployment-urls.txt* to view the Seq logs.

In the two failed attempts to apply the *:::no-loc text="DISC-10":::* code, notice that you received the error message immediately. Check the log traces. A variation of the following output appears:

:::image type="content" source="../media/4-verify-deployment/non-resilient-failures.png" alt-text="Screenshot of the output list of non-resilient failures." border="true" lightbox="../media/4-verify-deployment/non-resilient-failures.png":::

In the preceding image, you can see that:

- The first two requests, labeled as "1" and "2", fail when getting the values.
- The third request, labeled as "3", succeeds and returns the expected value, labeled as "4".

In this unit, you saw the *:::no-loc text="eShopOnContainers":::* app's existing checkout process. The next step is to add code-based resiliency to the coupon service by using Polly.
