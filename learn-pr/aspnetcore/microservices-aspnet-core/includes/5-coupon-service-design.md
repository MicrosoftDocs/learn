In this unit, you learn about the business requirements for the requested coupon code feature. Additionally, you'll learn about DDD and the selected technology stack for the solution.

## Business requirements

There are many ways to implement a coupon code feature in an e-commerce app. For simplicity, the following business requirements have been provided:

* To obtain a discount, the user can apply a coupon code from the checkout page. All coupon codes are prefixed with *DISC-* and are suffixed with an unsigned integer. The integer indicates the US dollar amount to be deducted from the order total. For example, *DISC-30* deducts $30 USD.
* The coupon service must validate that the coupon code is available before allowing it to be used.
* Once the payment is processed, the ordering service should request validation for the coupon during the order process.
* Upon validation, the coupon should be assigned to the order and won't be available for any other order.
* If an order is canceled, the assigned coupon should be released for any other order to use.

## Domain model

DDD is a design pattern whereby the structure and language of your code&mdash;including class names, methods, and variables&mdash;matches the business domain. The pattern describes independent problem areas as bounded contexts and emphasizes a common language to describe these problems. Determining where to draw the boundaries is an essential task when designing and defining a microservices-based solution. For each bounded context, you must identify and define the entities, value objects, and aggregates that model your domain.

The coupon service is implemented like a CRUD service, and the boundaries are clearly defined within the coupon domain. The service represents a coupon as a `Coupon` object, using the class defined at *src/Services/Coupon/Coupon.API/Infrastructure/Models/Coupon.cs*. This class encapsulates the attributes of a coupon.

|Property  |Description |
|----------|------------|
|`Id`      |The unique identifier of the coupon.|
|`Discount`|The discount amount represented in USD currency.|
|`Code`    |The coupon code.|
|`Consumed`|A flag indicating whether the coupon code has been used.|
|`OrderId` |The unique identifier of the associated order to which the coupon code has been applied.|

These design choices may seem obvious, but note that the `Coupon` model is a centerpiece of all business logic in the *Coupon.API* project. The coupon service:

* Only concerns itself with the domain of coupons.
* Relies on the other services to interact with other domains, such as determining whether an order is valid.

## Technology stack

Microservice architectures are technology agnostic. This characteristic gives development teams flexibility to select the technology stack for each service independently. The following table outlines the relevant technologies used by the coupon service.

| Technology | Description |
|-------------------|-------------|
| ASP.NET Core web API | The RESTful services for managing discounts are implemented in ASP.NET Core. A web API uses controllers to handle HTTP requests. |
| MongoDB | The NoSQL database that stores the coupons and their usage data. In a real-world scenario, it's common for services to use a managed database like [Azure Cosmos DB](https://azure.microsoft.com/services/cosmos-db) instead of running them in a container. |
| Docker | The web API project and the MongoDB database, along with their dependencies, are packaged into respective container images using Docker. |

## Integration events in the ordering service

Orders submitted through the UI are routed to the ordering service via the API gateway. The ordering service then validates the coupon with the coupon service.

:::image type="content" source="../media/temp/coupon-ordering-event-bus.png" alt-text="event messaging flow between the ordering and coupon services" border="true" lightbox="../media/temp/coupon-ordering-event-bus.png":::

1. The ordering service raises an event of type `OrderStatusChangedToAwaitingCouponValidationIntegrationEvent`. The event:
    * Indicates that there's an order awaiting coupon validation.
    * Is serialized as a message on the event bus.
1. The coupon service receives the event from the event bus and invokes the appropriate event handler to determine the status of the coupon.
1. The coupon service raises an event to indicate the status of the coupon.
    * If the coupon is valid, the coupon service:
        * Marks the coupon as "consumed" in the database.
        * Raises an event of type `OrderCouponConfirmedIntegrationEvent`. This event sends a message to the event bus to inform the ordering service that the order may be processed.
    * If the coupon is invalid, an event of type `OrderCouponRejectedIntegrationEvent` is raised.
1. The ordering service handles the event that was raised by the coupon service.

In the next unit, you'll complete the coupon service code. You'll also modify the files that define the AKS deployment.
