Soon after launching the setup script, the [Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor) opens the starter solution. The editor opens to the *:::no-loc text="~/clouddrive/aspnet-learn/src/":::* directory. You can investigate the solution while the script continues to deploy the Docker containers to Azure Kubernetes Service (AKS). While doing so, the script will continue to run.

[!INCLUDE[reconnect to Azure Cloud Shell](../../includes/microservices/reconnect-to-cloud-shell-note.md)]

## Review code

The following *:::no-loc text="src":::* subdirectories contain .NET Core projects, each of which is containerized and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *:::no-loc text="Aggregators/":::* | Services to aggregate across multiple microservices for certain cross-service operations. An HTTP aggregator is implemented in the *:::no-loc text="ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::* project. |
| *:::no-loc text="BuildingBlocks/":::* | Services that provide cross-cutting functionality, such as the app's event bus used for inter-service events. |
| *:::no-loc text="Services/":::* | These projects implement the business logic of the app. Each microservice is autonomous, with its own data store. They showcase different software patterns, including Create-Read-Update-Delete (CRUD), Domain-Driven Design (DDD), and Command and Query Responsibility Segregation (CQRS). The new *:::no-loc text="Coupon.API":::* project has been provided, but it's not resilient. |
| *:::no-loc text="Web/":::* | ASP.NET Core apps that implement user interfaces. *:::no-loc text="WebSPA":::* is a storefront UI built with Angular. *:::no-loc text="WebStatus":::* is the health checks dashboard for monitoring the operational status of each service. |

## Verify deployment to AKS

After the app has deployed to AKS, you'll see a variation of the following message in the command shell:

```console
The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

You can begin exploring these services (when ready):
- Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://203.0.113.55/webstatus/ (See overall service status)
- Web SPA application       : http://203.0.113.55/
```

> [!TIP]
> To display these URLs again, run the following command:
>
> ```bash
> cat ~/clouddrive/aspnet-learn/deployment-urls.txt
> ```

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. A green checkmark icon denotes a healthy service. The page refreshes automatically, every 10 seconds.

    :::image type="content" source="../media/4-verify-deployment/health-checks-status-page.png" alt-text="health checks status dashboard" border="true" lightbox="../media/4-verify-deployment/health-checks-status-page.png":::

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app" border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. The credentials are provided on the page. Select the **:::no-loc text="Remember me?":::** check box to avoid signing in again.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select **:::no-loc text="CHECKOUT":::**, and then select **:::no-loc text="PLACE ORDER":::** to complete the purchase.

    :::image type="content" source="../../media/microservices/eshop-spa-shopping-bag.png" alt-text="shopping cart with .NET Blue Hoodie" border="true" lightbox="../../media/microservices/eshop-spa-shopping-bag.png":::

You've successfully verified that the app was deployed to AKS and is working properly.

## Explore the response of a non-resilient app

Complete the following steps to see how the app responds without a resiliency solution in place.

### Configure simulated failure

The coupon service was designed to simulate failures on demand. Configuration of simulated failures is accomplished with a special syntax for coupon codes. To simulate a failure, you need at least one item in the basket. Complete the following steps:

1. Select the **:::no-loc text="CONTINUE SHOPPING":::** button.
1. Select the **:::no-loc text=".NET FOUNDATION PIN":::**.
1. Select the basket icon.
1. Select **:::no-loc text="CHECKOUT":::**.
1. In the **:::no-loc text="HAVE A DISCOUNT CODE?":::** text box at the bottom of the page, enter the code *:::no-loc text="FAIL 2 DISC-10":::*.

    This code causes the coupon service raise an exception twice, when validating the *:::no-loc text="DISC-10":::* discount code.
1. Select the **:::no-loc text="APPLY":::** button.

    You'll receive the following confirmation message with the number of failures configured for the code: **:::no-loc text="CONFIG: 2 failure(s) configured for code \"DISC-10\"!!":::**.

    :::image type="content" source="../media/4-verify-deployment/configure-coupon-failures.png" alt-text="configure coupon failures" border="true" lightbox="../media/4-verify-deployment/configure-coupon-failures.png" :::

This configuration causes the next two requests for the *:::no-loc text="DISC-10":::* code to throw an exception.

### Apply the failing discount coupon

1. Replace the existing discount code with *:::no-loc text="DISC-10":::*.
1. Select the **:::no-loc text="APPLY":::** button. You'll receive the message **:::no-loc text="ERROR: 500 - Internal Server Error!":::**.
1. Select the **:::no-loc text="APPLY":::** button again. You'll receive the same message once more.
1. Select the **:::no-loc text="APPLY":::** button for a third time. This time, the code validation succeeds and the 10 US dollar (USD) discount is applied to the order.
1. Select the **:::no-loc text="Centralized logging":::** link in the command shell to view the Seq logs.

In the two failed attempts to apply the *:::no-loc text="DISC-10":::* code, notice that you received the error message immediately. Check the log traces. You'll see a variation of the following output:

:::image type="content" source="../media/4-verify-deployment/non-resilient-failures.png" alt-text="non-resilient failures" border="true" lightbox="../media/4-verify-deployment/non-resilient-failures.png":::

In the preceding image, you can see that:

- The first two requests, labeled as ":::no-loc text="1":::" and ":::no-loc text="2":::", fail when getting the values.
- The third request, labeled as ":::no-loc text="3":::", succeeds and returns the expected value, labeled as ":::no-loc text="4":::".

In this unit, you've seen the *:::no-loc text="eShopOnContainers":::* app's existing checkout process. Next, you'll add code-based resiliency with Polly to the coupon service.
