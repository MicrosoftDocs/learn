In this unit, you will:

- Verify the newly deployed app.
- Review code.
- Explore the deployed services.

## Verify deployment to AKS

After the app deploys to AKS, you'll see a variation of the following message in the terminal:

```console
The eShop-Learn application has been deployed.

You can begin exploring these services (when available):
- Centralized logging       : http://13.83.97.100/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://13.83.97.100/webstatus/ (See overall service status)
- Web SPA application       : http://13.83.97.100/
```

> [!TIP]
> You can find this output in *modules/microservices-data-aspnet-core/deployment-urls.txt*.

Even though the app has been deployed, it might take a few minutes to come online. Verify that the app is deployed and online with the following steps:

1. Select the **General application status** link in the terminal to view the *:::no-loc text="WebStatus":::* health checks dashboard. The resulting page displays the status of each microservice in the deployment. The page is designed to refresh automatically every 10 seconds.

    > [!IMPORTANT]
    > If the WebStatus isn't automatically refreshing, it's due to an issue with the container image used for WebStatus. To work around the issue, manually refresh the WebStatus page periodically.

    :::image type="content" source="../media/health-checks-status-page.png" alt-text="Screenshot of the health check page." border="true" lightbox="../media/health-checks-status-page.png":::

    > [!NOTE]
    > While the app is starting up, you might initially receive an HTTP 503 response from the server. Retry after a few seconds. The Seq logs, which you can view at the **Centralized logging** URL, are available before the other endpoints.

1. After all the services are healthy, select the **Web SPA application** link in the terminal to test the *:::no-loc text="eShopOnContainers":::* web app. The following page appears:

    :::image type="content" source="../../media/microservices/eshop-spa.png" alt-text="Screenshot of the eShop single page app." border="true" lightbox="../../media/microservices/eshop-spa.png":::

1. Complete a purchase as follows:
    1. Select the **LOGIN** link in the upper right to sign into the app. The credentials are provided on the page.
    1. Add the **.NET BLUE HOODIE** to the shopping bag by selecting the image.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**, then select **PLACE ORDER** to complete the purchase.

    :::image type="content" source="../../media/microservices/eshop-spa-shopping-bag.png" alt-text="shopping cart with .NET Blue Hoodie." border="true" lightbox="../../media/microservices/eshop-spa-shopping-bag.png":::

## Review code

Review the directories in the explorer pane in the IDE. Relative to the workspace root, the files for this module are located in *modules/microservices-data-aspnet-core*.

> [!IMPORTANT]
> For brevity, all directory paths described in this module are relative to the *modules/microservices-data-aspnet-core* directory.

The following subdirectories located in *src* contain .NET projects, each of which is containerized and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *:::no-loc text="Aggregators/":::* | Services to aggregate across multiple microservices for certain cross-service operations. An HTTP aggregator is implemented in the *:::no-loc text="ApiGateways/Aggregators/Web.Shopping.HttpAggregator":::* project. |
| *:::no-loc text="BuildingBlocks/":::* | Services that provide cross-cutting functionality, such as the app's event bus used for inter-service events. |
| *:::no-loc text="Services/":::* | These projects implement the business logic of the app. Each microservice is autonomous, with its own data store. They showcase different software patterns, including Create-Read-Update-Delete (CRUD), Domain-Driven Design (DDD), and Command and Query Responsibility Segregation (CQRS). |
| *:::no-loc text="Web/":::* | ASP.NET Core apps that implement user interfaces. *:::no-loc text="WebSPA":::* is a storefront UI built with Angular. *:::no-loc text="WebStatus":::* is the health checks dashboard for monitoring the operational status of each service. |

## Explore the deployed services

All the services of *:::no-loc text="eShopOnContainers":::* app are deployed as [pods](https://kubernetes.io/docs/concepts/workloads/pods/) in the AKS cluster.

Run the following command terminal.

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

Different microservices use the following pods for the datastores:

- `sqldata-<random-guid>` pod as SQL instance.
- `nosqldata-<random-guid>` pod as MongoDB instance.
- `basketdata-<random-guid>` pod as Redis instance.

This is an appropriate configuration for a development scenario, because all the services are in a single cluster. However, in a production scenario, we recommend using managed data services instead of running databases as containers within your Kubernetes cluster.

In the next unit, you'll implement Azure Cache for Redis for the basket service.
