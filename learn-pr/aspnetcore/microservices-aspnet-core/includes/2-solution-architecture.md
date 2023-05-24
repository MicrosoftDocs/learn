In this unit, you learn about microservices architecture and the :::no-loc text="eShopOnContainers"::: app while your dev environment loads.

## Prepare the development environment

Make sure you're set up to use dev containers with [GitHub Codespaces](https://github.com/features/codespaces) (costs may apply), or with [Visual Studio Code and a supported Docker environment on your local machine](/training/modules/use-docker-container-dev-env-vs-code).

Load the *mslearn-aspnet-core* dev environment by using one of the following procedures:

- For GitHub Codespaces, go to the codespace for the [MicrosoftDocs/mslearn-aspnet-core repository](https://github.com/MicrosoftDocs/mslearn-aspnet-core/codespaces) and create a new codespace using the `main` branch.

- For local Visual Studio Code:

  1. From a new Visual Studio Code window, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette, and then search for and select **Dev Containers: Clone Repository in Container Volume**.
  1. Provide the following repository URL: `https://github.com/MicrosoftDocs/mslearn-aspnet-core`.

While your dev environment loads, read the following section to learn about microservices architecture and the :::no-loc text="eShopOnContainers"::: app.

## Solution architecture

The app that powers the :::no-loc text="eShopOnContainers"::: online store currently includes the following features:

- Catalog management
- Shopping basket
- User management
- Order management
- Payments

The following diagram shows the app architecture, including the new **Coupon microservice** that you add in this module. Each feature is a distinct microservice that is autonomous, independently deployable, and responsible for its own data. Interservice communication occurs as needed, via synchronous API calls or asynchronously through messaging.

:::image type="content" source="../../media/microservices/eshop-architecture.png" alt-text="Diagram showing the eShopOnContainers solution architecture." border="false" lightbox="../../media/microservices/eshop-architecture.png":::

The preceding diagram doesn't show some of the services that are present in this Azure Kubernetes Service (AKS) deployment, such as [Seq](https://datalust.co/seq) for unified logging and the *:::no-loc text="WebStatus":::* web app.

### Data storage

In a microservices architecture, there's no single master data store that all services interact with. This data isolation gives every microservice the autonomy to independently apply data schema updates without affecting other services in the production environment.

Each microservice can implement the data store that's best optimized for its workload, storage needs, and read/write patterns. Data store choices include relational, document, key-value, and graph-based. For example, the *catalog* service stores its data in a SQL Server on Linux database. The *basket* service uses a Redis cache for storage.

### Authentication and authorization

The *:::no-loc text="WebSPA ":::* client app delegates authentication and authorization to an **Identity microservice** that also serves as a Security Token Service (STS). The identity service is a containerized ASP.NET Core project that uses [IdentityServer 4](https://identityserver4.readthedocs.io), a popular OpenID Connect and OAuth 2.0 framework for ASP.NET Core. An alternative to hosting an STS is to use [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory), which offers identity and access management as a service.

The identity service in the diagram is configured to allow direct access, so it bypasses the API gateway. The full *:::no-loc text="eShopOnContainers":::* app that this sample is based on uses multiple API gateways separated by business areas. The smaller implementation in this module doesn't require another API gateway.

### Event bus

The app uses an event bus for asynchronous messaging and event-driven communication. The current solution uses RabbitMQ in a Docker container deployed to AKS, but you could also use a service such as [Azure Service Bus](https://azure.microsoft.com/services/service-bus). The following diagram shows the publish/subscribe (pub-sub) pattern the event bus uses.

:::image type="content" source="../media/3-solution-architecture/eventbus-implementation.png" alt-text="Diagram showing the event bus pub-sub pattern." border="false" lightbox="../media/3-solution-architecture/eventbus-implementation.png":::

Any service can publish an event to the event bus, and each service is responsible for subscribing to the messages relevant to its domain. Each service calls an `AddEventBus` extension method in the `ConfigureServices` method of *:::no-loc text="Startup.cs":::*. The `AddEventBus` method establishes a connection to the event bus and registers the appropriate event handlers for that service's domain.

### API gateway

The *:::no-loc text="WebSPA":::* UI client app accesses the microservices via the **API gateway**. Among other advantages, API gateways enhance security and decouple backend services from individual clients.

The :::no-loc text="WebSPA"::: ASP.NET Core MVC and Angular storefront app is accessible via a public IP address. HTTP requests from the app to the microservices route through the API gateway, which is an example of the [Backends-For-Frontends](/azure/architecture/patterns/backends-for-frontends) pattern.

The app implements basic routing configurations by using the NGINX reverse proxy. The ASP.NET Core web API named `Web.Shopping.HttpAggregator` combines multiple requests into a single request, a pattern called [Gateway Aggregation](/azure/architecture/patterns/gateway-aggregation).

Real-world scenarios use managed API gateway services like [Azure API Management](https://azure.microsoft.com/services/api-management).

### Coupon service

Microservices are small enough for a feature team to independently build, test, and deploy to production multiple times a day, without affecting other systems. In this module, you complete and deploy an ASP.NET Core microservice project named Coupon.API to the existing :::no-loc text="eShopOnContainers"::: app in production.

In the next unit, you deploy the :::no-loc text="eShopOnContainers"::: app and further investigate its code.
