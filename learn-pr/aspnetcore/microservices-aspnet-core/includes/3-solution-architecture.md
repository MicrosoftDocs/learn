In this unit, you'll gain an understanding of the *eShopOnContainers* app and the microservices architecture used.

## Solution architecture

:::image type="content" source="../media/temp/eshop-architecture.png" alt-text="eShop application architecture" border="true" lightbox="../media/temp/eshop-architecture.png":::

The *eShopOnContainers* app is an online store that sells various products, including pins, T-shirts, and coffee mugs. The store includes the following features:

* Catalog management
* Shopping basket
* User management
* Order management
* Payments
* Coupon management (pictured in the diagram, but doesn't exist yet)

Each of the preceding features is managed with a distinct microservice. Each microservice is autonomous, independently deployable, and responsible for its own data. This architecture enables each microservice to implement the data store that is best optimized for its workload, storage needs, and read/write patterns. Data store choices include relational, document, key-value, and graph-based.

The *catalog* service stores its data in a SQL Server on Linux database. The *basket* service uses a Redis cache for storage, and so on. There's no single master data store with which all services interact. Instead, inter-service communication is performed on an as-needed basis, either via synchronous API calls or asynchronously through messaging. This data isolation gives every microservice the autonomy to independently perform data schema updates without breaking other services in the production environment.

### Identity

The *WebSPA* client app delegates authentication and authorization concerns to an *identity* service that also serves as a Security Token Service (STS). It's a containerized ASP.NET Core project that uses [IdentityServer 4](https://identityserver4.readthedocs.io), a popular OpenID Connect and OAuth 2.0 framework for ASP.NET Core. An alternative is to use [Azure Active Directory](https://azure.microsoft.com/services/active-directory/) (AAD). AAD offers identity and access management as a service.

The identity service in the diagram is configured to allow direct access. Consequently, the API gateway is bypassed. The full *eShopOnContainers* app, on which this sample is based, uses multiple API gateways separated by business areas. For this smaller implementation, however, another API gateway isn't required.

### Event bus

An event bus is used for asynchronous messaging and event-driven communication. The preceding architecture diagram depicts RabbitMQ in a Docker container deployed to AKS, but a service such as [Azure Service Bus](https://azure.microsoft.com/services/service-bus) would also be appropriate.

![Event bus illustration](../media/temp/eventbus-implementation.png)

The preceding diagram depicts the publish/subscribe (commonly shortened to *pub-sub*) pattern used with the event bus. Any service can publish an event to the event bus. Each service is responsible for subscribing to the messages relevant to its domain. The services each call an `AddEventBus` extension method in the `ConfigureServices` method of *Startup.cs*. This method establishes a connection to the event bus and registers the appropriate event handlers for that service's domain.

### API gateway

The microservices are accessible to clients via the API gateway. Among other advantages, API gateways enhance security and decouple back-end services from individual clients. The *WebSPA* storefront is an ASP.NET Core MVC and Angular app that is accessible via a public IP address. The HTTP requests from the *WebSPA* app to the microservices are routed through the API gateway, which is an implementation of the **B**ackends-**F**or-**F**rontends (BFF) pattern. Basic routing configurations are implemented using the NGINX reverse proxy. The Gateway Aggregation pattern is implemented using the ASP.NET Core web API named *Web.Shopping.HttpAggregator*. For real-world scenarios, use of managed API gateway services like [Azure API Management](https://azure.microsoft.com/services/api-management) is recommended.

### Coupon service

Microservices are small enough for a feature team to independently build, test, and deploy to production multiple times a day without affecting other systems. In this module, you'll create a new microservice named *Coupon.API* and deploy it to the existing *eShopOnContainers* app in production. While doing so, you'll also learn about:

* Designing microservices using **D**omain-**D**riven **D**esign (DDD).
* Containerizing services using Docker.
* Publishing container images to a container registry.
* Deploying containers to an existing Kubernetes cluster.

In the architecture diagram, the coupon service to be added is outlined with a dashed, blue box.

### Other services

There are a few services in the Kubernetes deployment that aren't represented in the preceding diagram. Services such as [Seq](https://datalust.co/seq) (for unified logging) and the *WebStatus* web app are also present in the deployment.

In the next unit, you'll investigate the code for the app and verify it running in AKS when it's done deploying.
