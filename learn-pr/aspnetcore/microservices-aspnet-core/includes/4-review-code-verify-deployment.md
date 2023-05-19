In this unit, you verify that the app deployed and is working correctly.

## Verify the deployment to AKS

After the app deploys to AKS, the terminal displays a variation of the following message showing the URLs for the app UI, logging service, and web status pages:

```console
The eShop-Learn application has been deployed to "http://000.0.000.00" (IP: 000.0.000.00).

You can begin exploring these services (when ready):
- Centralized logging       : http://000.0.000.00/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://000.0.000.00/webstatus/ (See overall service status)
- Web SPA application       : http://000.0.000.00/
```

> [!TIP]
> You can also find the URLs in *modules/microservices-aspnet-core/deployment-urls.txt*.

Even though the app has deployed, it might take a few minutes to come online. While the app is starting up, you might initially receive an HTTP 503 or 502 response from the server. Retry after about one minute. The :::no-loc text="Seq"::: logs, which you can see at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

While you wait for the app to come online, you can review the [Coupon service design](#coupon-service-design) section to understand the design and implementation of the new coupon feature. Once the URLs are available, take the following steps to verify that the app is deployed, online, and working correctly.

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically every 10 seconds.

   :::image type="content" source="../media/4-review-code-verify-deployment/health-check.png" alt-text="Health check page." border="true" lightbox="../media/4-review-code-verify-deployment/health-check.png":::

1. After all the services are healthy, select the **Web SPA application** link to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="eShop single page app." border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **LOGIN** link in the upper right to sign into the app. The page provides demo credentials.
    1. Select the **.NET BLUE HOODIE** to add it to the shopping bag.
    1. Select the shopping bag icon at upper right.
    1. Select **CHECKOUT**, and then select **PLACE ORDER** to complete the purchase.

    :::image type="content" source="../../media/microservices/eshop-spa-shopping-bag.png" alt-text="shopping cart with .NET Blue Hoodie." border="true" lightbox="../../media/microservices/eshop-spa-shopping-bag.png":::

You've verified the *:::no-loc text="eShopOnContainers":::* app's existing checkout process. In the next unit, you review the design of the new coupon service.

