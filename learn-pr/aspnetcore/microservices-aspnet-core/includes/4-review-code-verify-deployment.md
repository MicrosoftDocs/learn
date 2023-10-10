In this unit, you verify that the :::no-loc text="eShopOnContainers"::: app deployed and is working correctly.

## Verify the deployment

After the app deploys to AKS, the terminal displays a variation of the following message that shows the URLs for the app UI, logging service, and web status pages. You can select the URLs to go to the pages.

```console
The eShop-Learn application has been deployed to "http://203.0.113.12" (IP: 203.0.113.12).

You can begin exploring these services (when ready):
- Centralized logging       : http://203.0.113.12/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://203.0.113.12/webstatus/ (See overall service status)
- Web SPA application       : http://203.0.113.12/
```

> [!TIP]
> You can also find the URLs in the *modules/microservices-aspnet-core/deployment-urls.txt* file in **Explorer**.

Even though the app has deployed, it might take a few minutes to come online. While the app is starting up, you might initially receive an HTTP 503 or 502 response from the server. Retry after about one minute. The :::no-loc text="Seq"::: logs, which you can see at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

Once the URLs are available, select the **:::no-loc text="General application status":::** URL to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page refreshes automatically every 10 seconds.

:::image type="content" source="../media/4-review-code-verify-deployment/health-check.png" alt-text="Screenshot of the Health check page." lightbox="../media/4-review-code-verify-deployment/health-check.png":::

After all the services are healthy, select the **Web SPA application** link to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

:::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="Screenshot of the eShop single page app." lightbox="../../media/microservices/eshop-spa.png":::

Complete a purchase as follows:

1. Select the **LOGIN** link in the upper right to sign into the app. The page provides demo credentials.
1. Select the **.NET BLUE HOODIE** to add it to the shopping bag.
1. Select the shopping bag icon at upper right.
1. Select **CHECKOUT**, and then select **PLACE ORDER** to complete the purchase.

   :::image type="content" source="../../media/microservices/eshop-spa-shopping-bag.png" alt-text="Screenshot of the shopping cart with an order." lightbox="../../media/microservices/eshop-spa-shopping-bag.png":::

You've verified the *:::no-loc text="eShopOnContainers":::* app's existing checkout process. In the next unit, you review the design of the new coupon service.

