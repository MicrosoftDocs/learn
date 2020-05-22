In this unit, you complete the *Coupon.API* project. You will then run a script to generate changes to the *WebSPA* HTML, as well as generate and modify Helm charts to define the kubernetes deployment.

## Business requirements

There are many ways to implement a coupon code feature in an e-commerce app. For simplicity, the following business requirements have been provided:

* To obtain a discount, the user can apply a coupon code from the checkout page. All coupon codes are prefixed with *DISC-* and are suffixed with an unsigned integer. The integer indicates the US dollar amount to be deducted from the order total. For example, *DISC-30* deducts 30 US dollars.
* The coupon service must validate that the coupon code is available before allowing it to be used.
* Once the payment is processed, the ordering service should request validation for the coupon during the order process.
* Upon validation, the coupon should be assigned to the order and won't be available for any other order.
* If an order is canceled, the assigned coupon should be released for any other order to use.

## Domain model

**D**omain-**D**riven **D**esign (DDD) is a design pattern whereby the structure and language of your code (including class names, methods, and variables) should match the business domain. The pattern describes independent problem areas as bounded contexts and emphasizes a common language to describe these problems. Knowing where to draw the boundaries is the most important task when designing and defining a microservices-based solution. For each bounded context, you must identify and define the entities, value objects, and aggregates that model your domain. The coupon feature requirement is straightforward, so the coupon service is implemented like a CRUD service, and the boundaries are well-defined within the coupon domain.

The coupon service represents a coupon as a `Coupon` object, using the class defined at *src/Services/Coupon/Coupon.API/Infrastructure/Models/Coupon.cs*. This class encapsulates the attributes of a coupon.

|Property  |Description |
|----------|------------|
|`Id`      |The unique identifier of the coupon.|
|`Discount`|The discount amount in US dollars.|
|`Code`    |The coupon code.|
|`Consumed`|A flag indicating whether the coupon code has been used.|
|`OrderId` |The unique identifier of the associated order to which the coupon code has been applied.|

These may seem like obvious design choices, but note that the `Coupon` model is key to all of the business logic in `Coupon.API`. The coupon service:

* Only concerns itself with the domain of coupons.
* Relies on the other services to interact with other domains, such as determining whether an order is valid.

## Technology stack

Microservice architectures are technology agnostic, thus giving development teams flexibility to select the technology stack for each service independently. The following table outlines the relevant technologies used by the coupon service.

| Technology | Description |
|-------------------|-------------|
| ASP.NET Core web API | The RESTful services for querying discounts are implemented in ASP.NET Core. A web API uses *Controllers* to handle HTTP requests. |
| MongoDB | The NoSQL database that stores the coupons and their utilization data. In a real-world scenario, it's common for services to use a managed database like [Azure Cosmos DB](https://azure.microsoft.com/services/cosmos-db) instead of running them in a container. |
| Docker | The web API project and the MongoDB database, along with their dependencies, are packaged into respective container images using Docker. |

## Integration with other services

**%TODO%** - What's going on with Orders and Basket. And Identity.

In the next unit, you'll complete the coupon service code. You'll also make adjustments to the files that define the AKS deployment.
