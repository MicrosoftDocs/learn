In this module, you'll gain an understanding of the *eShopOnContainers* app and the microservices architecture used.

## eShopOnContainers architecture

![eShop application architecture](../media/temp/eshop-architecture.png)

%TODO% - AKS logo in image.

The *eShopOnContainers* app is an online store that sells various physical products like pins, T-shirts, and coffee mugs. The store includes the following features:

* Catalog management
* Shopping basket
* User management
* Order management
* Payments

Each of the preceding features is managed with a distinct microservice. Each microservice is autonomous, independently deployable, and responsible for its own data. This architecture enables each microservice to implement the data store that is best optimized for its workload, storage needs, and read/write patterns. Data store options include relational, document, key-value, and graph-based. As shown in the preceding figure, the *catalog* microservice stores its data in a SQL Server on Linux database, the *basket* microservice uses a Redis cache for storage, and so on. There's no single master data store with which all services interact. Instead, inter-service communication is performed on an as-needed basis, either via synchronous API calls or asynchronously through messaging. This data isolation gives every microservice the autonomy to independently perform data schema updates without breaking any other service in production.

### Identity

%TODO% - Auth discussion here. E.g., why no API gateway for auth? Define STS because it's in diagram. Why Identity Server instead of AAD?

### Event bus

The event bus is used for asynchronous messaging and event-driven communication. The above implementation uses RabbitMQ in a container deployed in AKS, but a service such as [Azure Service Bus](https://azure.microsoft.com/services/service-bus) would also be appropriate.

### API gateway

These microservices are accessible to clients via the API gateway. API gateways offer several advantages, such as decoupling back-end services from individual front-end clients and providing enhanced security. The eShopOnContainers storefront *WebSPA* is an ASP.NET Core app that is accessible via a public IP address. The requests from the *WebSPA* app to the microservices are routed through the API gateway, which is an implemention of the **B**ackends-**F**or-**F**rontends pattern. Basic routing configurations are implemented using the NGINX reverse proxy and the Gateway Aggregation pattern is implemented using the ASP.NET Core web API called *Web.Shopping.HttpAggregator*. For real-world scenarios, use of managed API gateway services like [Azure API Management](https://azure.microsoft.com/services/api-management) is recommended.

### Coupon service

Microservices are small enough for a feature team to independently build, test, and deploy to production multiple times a day without affecting other systems. In this module, you'll create a new microservice called *Coupon.API* and deploy it to the existing *eShopOnContainers* application in production. While doing so, you'll also learn about designing microservices using Domain Driven Design, containerizing them using Docker, publishing them to a container registry, and deploying them to an existing Kubernetes cluster. The new coupon microservice is shown in the preceding diagram's blue box.

### Other services

There are a few services in the Kubernetes deployment that aren't represented in the preceding diagram. Services such as Seq (for unified logging) and the *WebStatus* web app are also present in the deployment.

In the next unit, you'll investigate the code for the app and verify it running in AKS when it's done deploying.
