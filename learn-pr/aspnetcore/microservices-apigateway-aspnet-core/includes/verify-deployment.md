In this unit, you will:

- Verify the newly deployed app.
- Review code.
- Explore the deployed services.

[!INCLUDE[reconnect to Azure Cloud Shell](../../includes/microservices/reconnect-to-cloud-shell-note.md)]

## Verify the deployment to AKS

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Run the following command to display the various app URLs:

    ```bash
    cat ~/clouddrive/aspnet-learn/deployment-urls.txt
    ```

    A variation of the following output appears:

    ```console
    The eShop-Learn application has been deployed to "http://203.0.113.55" (IP: 203.0.113.55).

    You can begin exploring these services (when ready):
    - Centralized logging       : http://203.0.113.55/seq/#/events?autorefresh (See transient failures during startup)
    - General application status: http://203.0.113.55/webstatus/ (See overall service status)
    - Web SPA application       : http://203.0.113.55/
    ```

1. Select the **:::no-loc text="General application status":::** link in the command shell to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. A green checkmark icon denotes a healthy service. The page refreshes automatically, every 10 seconds.

    ![WebSPA](media/health-checks-status-page.png)

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which are viewable at the **:::no-loc text="Centralized logging":::** URL, are available before the other endpoints.

1. After all the services are healthy, select the **:::no-loc text="Web SPA application":::** link in the command shell to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    ![WebSPA](media/eshop-spa.png)

1. Navigate to the checkout page as follows:
    1. Select the **:::no-loc text="LOGIN":::** link in the upper right to sign into the app. Sign in using the credentials provided on the page.
    1. Add the **:::no-loc text=".NET BLUE HOODIE":::** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select the **CHECKOUT** button.

1. Observe **:::no-loc text=".NET BLUE HOODIE":::** is in the shopping bag.

    ![WebSPA shopping bag](media/eshop-spa-shopping-bag.png)

You've successfully verified the app was deployed to AKS. Additionally, you've seen the discount coupon feature that you're going to make configurable.

## Discount Coupon features

- The user can apply a discount coupon code during the checkout (**DISC-##**, where ## is the discount amount to the order total. For $5, $10, $15, $20, $25, and $30).
- The coupon service must confirm that the coupon is available and return the discount amount (REST API).
- The ordering microservice will request validation for the coupon, during the order process (Asynchronous messaging).
- Upon validation, the coupon will be assigned to the order and won't be available for any other order. However the coupon can be initially "used" by more than one order, until it's actually "consumed" during the order process.
- If the coupon validation is rejected for another order it'll be cancelled.
- If an order is cancelled because of payment rejection (will happen if the order total exceeds $100, configurable), the assigned coupon, if there was one, should be released for any other order to use.

The discount coupon feature adds the following element to the checkout view:

![WebSPA checkout page view, highlighting the discount coupon input.](media/discount-coupon-feature.png)

## Review code

The following *:::no-loc text="src":::* subdirectories contain .NET Core projects, each of which is containerized and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *:::no-loc text="Aggregators/":::* | Services to aggregate across multiple microservices for certain cross-service operations. An HTTP aggregator is implemented in the *:::no-loc text="ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::* project. |
| *:::no-loc text="BuildingBlocks/":::* | Services that provide cross-cutting functionality, such as the app's event bus used for inter-service events. |
| *:::no-loc text="Services/":::* | These projects implement the business logic of the app. Each microservice is autonomous, with its own data store. They showcase different software patterns, including Create-Read-Update-Delete (CRUD), Domain-Driven Design (DDD), and Command and Query Responsibility Segregation (CQRS). The new *:::no-loc text="Coupon.API":::* project has been provided, but it's not resilient. |
| *:::no-loc text="Web/":::* | ASP.NET Core apps that implement user interfaces. *:::no-loc text="WebSPA":::* is a storefront UI built with Angular. *:::no-loc text="WebStatus":::* is the health checks dashboard for monitoring the operational status of each service. |

## Explore the deployed services

All the services of *:::no-loc text="eShopOnContainers":::* app gets deployed as [pods](https://kubernetes.io/docs/concepts/workloads/pods/) in the AKS cluster.

Run the following command in the Azure Cloud Shell.

```bash
kubectl get pods
```

The preceding command lists all the running pods in the Kubernetes cluster as shown in the output below.

```console
NAME                               READY   STATUS    RESTARTS   AGE
backgroundtasks-7dccfd66f5-9qd4n   1/1     Running   2          6m45s
basket-9d5694b46-jd4bl             1/1     Running   2          6m37s
basketdata-8486757fc9-lqzsh        1/1     Running   0          6m28s
catalog-55f58b8f44-rz6pr           1/1     Running   3          6m20s
coupon-86b5766658-z76ms            1/1     Running   2          6m11s
identity-676645fcf5-bw9j2          1/1     Running   2          6m3s
nosqldata-5744b5fb58-kr8ml         1/1     Running   0          5m57s
ordering-5f585b57fd-kdxpq          1/1     Running   3          5m48s
payment-7f675f974-jxsk4            1/1     Running   1          5m39s
rabbitmq-74467d98f6-qwbrg          1/1     Running   0          5m31s
seq-845485cf5f-thjws               1/1     Running   0          5m21s
signalr-5486795b4f-lsvlw           1/1     Running   0          5m10s
sqldata-57cdcf76dd-w6vt5           1/1     Running   0          5m1s
webshoppingagg-7f55677f98-9pbg9    1/1     Running   0          4m52s
webspa-67588b748-9kqf7             1/1     Running   0          4m43s
webstatus-579d55c59d-tthv9         1/1     Running   0          4m34s
```

| [TOC](../README.md) | [NEXT >](review-api-gateway-and-bff.md) |