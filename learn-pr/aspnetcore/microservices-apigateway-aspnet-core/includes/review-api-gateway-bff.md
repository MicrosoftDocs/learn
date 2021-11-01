## Why use API gateways?

In microservices apps, client apps commonly interact with many services. When you're architecting a microservices app, you must decide how that interaction occurs. One possible approach is a direct client-to-microservice communication architecture. In this approach, a client app makes requests directly to services, as shown in the following image.

:::image type="content" source="../media/direct-client-microservice-communication.png" alt-text="Diagram that shows client-to-services communication." lightbox="../media/direct-client-microservice-communication.png":::

As illustrated, both mobile and web apps connect to each of the three services. Each service has a public endpoint. Service endpoints can vary by IP address or TCP port. This approach introduces overhead, such as:

- Needing to issue multiple requests for one operation.
- Aggregating data from different microservices.
- Dealing with aggregated latency across requests.
- Handling multiple authorizations.
- Creating public IP addresses for each service.
- Managing API versioning across multiple services.

## Introducing API gateways

An API gateway addresses many of the concerns in the previous section, as shown in the following image:

:::image type="content" source="../media/simple-api-gateway.png" alt-text="Diagram that shows the A P I gateway pattern." lightbox="../media/simple-api-gateway.png":::

The preceding image shows how client apps communicate with a single entry point, the API gateway. This configuration has important advantages, like:

- A single DNS name.
- Decoupling of front-end apps and back-end services.
- A single metering point.

The decoupling aspect also makes it easy to route request versions to different microservice instances. Decoupling is useful for progressive deployments and implementing scenarios like [A/B testing](https://en.wikipedia.org/wiki/A/B_testing).

## Backend for Frontend pattern

An API gateway solves several problems, but there's still more to be done. Each client app might have a context that imposes some specific constraints. For example, a mobile phone has a more constrained internet connection than a desktop computer. The phone also has a much smaller screen size. It might be desirable to have a streamlined, low-bandwidth API for mobile use, and a full-featured API for desktop use.

This problem is where the Backend for Frontend (BFF) pattern can help. The BFF pattern supplies a per-device-type API customized for the specific context, as shown in the following image.

:::image type="content" source="../media/bff-api-gateways.png" alt-text="Diagram that shows the Backend for Frontend pattern." lightbox="../media/bff-api-gateways.png":::

In the preceding image, you can see that the mobile app accesses a mobile-specific API gateway. The client single-page application (SPA) and model-view-controller (MVC) web apps use a desktop-specific API gateway.

## Web aggregators

The BFF is much more than an application gateway. BFFs usually require custom logic to achieve the required results. The web aggregator is the part of the BFF pattern that addresses that problem. 

The web aggregator works as a broker, and it has a central role in the BFF pattern. It gets a request from the client, makes further requests to some back-end services, and then assembles an aggregated response to send back to the client.

### Explore an aggregator implementation in eShopOnContainers

In the *eShop* app, the *Web.Shopping.HttpAggregator* project is a web aggregator. The BFF takes care of all the shopping-related activities for the web client. For example, the `AddBasketItemAsync()` method in the `BasketController` class:

- Fetches an item from *Catalog.API*.
- Gets current basket details from *Basket.API*.
- Updates the current basket status with the new catalog item.
- Updates the basket of *Basket.API*.

Merging these operations into a single method hides the complexity from the client SPA. You can review the detailed implementation in the *src\ApiGateways\Aggregators\Web.Shopping.HttpAggregator* folder.

### Implement an aggregator in eShopOnContainers

Let's assume you're an admin for the *eShop* app. At the end of each day, you want to see the aggregated sales data per brand. To implement the new feature, you need information on the brand and orders for each product. Your aggregator needs to retrieve:

- Catalog items and brand-related information from *Catalog.API*.
- Sales of each product from *Ordering.API*.

The aggregator will merge this information into a single response to the client. 

The following diagram illustrates the *eShop* app with the aggregator implemented as *Web.Sales.HttpAggregator*.

:::image type="content" source="../media/api-gateway-bff-nginx-ingress.png" alt-text="Diagram that shows the eShopOnContainers architecture with WebSalesAgg." lightbox="../media/api-gateway-bff-nginx-ingress.png":::

> [!NOTE]
> In this implementation, there isn't a UI to consume the Web Sales aggregator. You'll use the Swagger UI as a client for testing.

The *Web.Sales.HttpAggregator* Web API project has the following components:

- Class `SalesController` annotated with the authorized attribute, requiring the `Admin` role
- Method `SalesController.GetSalesOfTodayByBrand()`, which fetches catalog brand information from *Catalog.API* and sales data from *Ordering.API*
- Method `SalesController.GetSalesData()`, which aggregates the sales based on the brand names

In the next unit, you'll configure and deploy *Web.Sales.HttpAggregator* to the existing Kubernetes cluster.
