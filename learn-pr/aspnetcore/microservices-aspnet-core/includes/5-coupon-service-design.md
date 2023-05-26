There are many ways to implement a coupon code feature in an e-commerce app. The following sections summarize the requirements, technology stack, and interservice integration for the :::no-loc text="eShopOnContainers"::: coupon service.

## Coupon microservice

Microservices are small enough for a feature team to independently build, test, and deploy to production multiple times a day, without affecting other services. As you complete the ASP.NET Core *Coupon.API* microservice project and deploy it to the existing :::no-loc text="eShopOnContainers"::: app in production, you learn how to:

- Design a microservice by using Domain-Driven Design (DDD).
- Containerize the microservice by using Docker.
- Publish the container image to Azure Container Registry.
- Deploy the container to an existing Azure Kubernetes Service (AKS) cluster.

## Business requirements

The coupon feature for the :::no-loc text="eShopOnContainers"::: app has the following business requirements:

- To get a discount, a user applies a coupon code from the checkout page. Coupon codes are prefixed with *:::no-loc text="DISC-":::* and suffixed with an unsigned integer indicating the US dollar (USD) amount to deduct from the order total. For example, *:::no-loc text="DISC-30":::* deducts 30 USD.
- The coupon service validates that the coupon code is available before allowing it to be used.
- After the payment processes, the ordering service requests coupon validation during the order process.
- Upon validation, the coupon is assigned to the order and isn't available for any other order by that user.
- If an order is canceled, the assigned coupon is released for any other order to use.

## Domain design model

The :::no-loc text="eShopOnContainers"::: app uses Domain-Driven Design (DDD), a design pattern where the code structure and language, including class names, methods, and variables, match the business domain. The DDD pattern describes independent problem areas as bounded contexts, and emphasizes a common language to describe these problems.

Determining where to draw the domain boundaries is an essential task when designing and defining a microservices-based solution. For each bounded context, you must identify and define the entities, value objects, and aggregates that model your domain.

You implement the coupon service like a create, read, update, delete (CRUD) service, and you clearly define the boundaries within the coupon domain. The service represents a coupon as a `Coupon` object, using the class defined at *:::no-loc text="src/Services/Coupon/Coupon.API/Infrastructure/Models/Coupon.cs":::*. The class encapsulates the following attributes of a coupon:

|Property  |Description |
|----------|------------|
|`Id`      |The unique identifier of the coupon.|
|`Discount`|The discount amount represented in USD currency.|
|`Code`    |The coupon code.|
|`Consumed`|A flag that indicates whether the coupon code has been used.|
|`OrderId` |The unique identifier of the order the coupon code has been applied to.|

The `Coupon` model is the centerpiece of all business logic in the *:::no-loc text="Coupon.API":::* project. The coupon service concerns itself only with the domain of coupons, but it relies on the other services to interact with other domains, such as determining whether an order is valid.

## Technology stack

Microservice architectures are technology agnostic. This characteristic gives development teams the flexibility to independently select the technology stack for each service. The following table outlines the technologies the coupon service uses.

| Technology | Description |
|-------------------|-------------|
| ASP.NET Core web API | The RESTful services for managing discounts are implemented in ASP.NET Core. A web API uses controllers to handle HTTP requests. |
| MongoDB | A NoSQL database stores the coupons and their usage data. In a real-world scenario, services often use a managed database, like [Azure Cosmos DB](https://azure.microsoft.com/services/cosmos-db), instead of running in a container. |
| Docker | Docker packages the web API project, MongoDB database, and their dependencies into their respective container images. |

## Ordering service event integration

The app routes orders submitted through the UI to the ordering service via the API gateway. The ordering service then validates the coupon with the coupon service. The following diagram shows the event messaging flow between the ordering and coupon microservices.

:::image type="content" source="../media/5-coupon-service-design/coupon-ordering-event-bus.png" alt-text="Diagram showing the event messaging flow between the ordering and coupon services." border="false" lightbox="../media/5-coupon-service-design/coupon-ordering-event-bus.png":::

1. The ordering service raises an event of type `OrderStatusChangedToAwaitingCouponValidationIntegrationEvent` that indicates there's an order awaiting coupon validation. The event is serialized as a message on the event bus.
1. The coupon service receives the event from the event bus, and invokes the appropriate event handler to determine the status of the coupon.
1. The coupon service raises an event to indicate the status of the coupon.
   - If the coupon is valid, the coupon service marks the coupon as `consumed` in the database, and raises an event of type `OrderCouponConfirmedIntegrationEvent`. This event sends a message to the event bus to inform the ordering service that the order can be processed.
   - If the coupon isn't valid, the coupon service raises an event of type `OrderCouponRejectedIntegrationEvent`.
1. The ordering service handles the event that the coupon service raised.

In the next unit, you complete the coupon service code and modify the files that define the Azure Kubernetes Service (AKS) deployment.
