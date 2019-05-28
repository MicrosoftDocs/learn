To move their application to a microservices architecture, Fabrikam needs to evaluate their current application and determine the scope and boundary of each microservice. To do this, they are going to use the domain-driven design (DDD) framework. Let's see how they apply this to their application.

> [!NOTE]
> This article doesn't show a complete and comprehensive domain analysis. We deliberately kept the example brief, to illustrate the main points. For more information on DDD, please see the *Learn more* section in the summary at the end of this module.

## What is domain-driven design?

Domain-driven design is an approach to system design originally introduced by Erik Evans in his 2005 book *Domain-Driven Design: Tackling Complexity in the Heart of Software*. This approach focuses on three key elements:

- Focusing on the core domain and domain logic
- Structuring the design on a model of the domain
- Driving iterative collaboration between the technical teams and business partners to constantly improve the system

Domain-driven design (DDD) provides a framework that can get you most of the way to a set of well-designed microservices. DDD has two distinct phases, *strategic* and *tactical*. In strategic DDD, you are defining the large-scale structure of the system. Strategic DDD helps to ensure that your architecture remains focused on business capabilities. Tactical DDD provides a set of design patterns that you can use to create the domain model. These patterns include entities, aggregates, and domain services. These tactical patterns will help you to design microservices that are both loosely coupled and cohesive.

![Diagram of the steps for domain-driven design](../media/6-ddd-process.png)

At a high level, you can break this process into four steps:

1. Start by analyzing the business domain to understand the application's functional requirements. The output of this step is an informal description of the domain, which can be refined into a more formal set of domain models.
2. Next, define the bounded contexts of the domain. Each bounded context contains a domain model that represents a particular subdomain of the larger application.
3. Within a bounded context, apply tactical DDD patterns to define entities, aggregates, and domain services.
4. Identify the microservices in your application using the results from the previous step.



## Drone app decomposition

After analyzing the application, Fabrikam has defined the following bounded contexts for their application:

![Diagram of the bounded contexts for the drone application](../media/6-bounded-contexts.png)



![Diagram of the shipping boundd context](../media/6-shipping-bounded-context.png)

- Use domain-driven design (DDD) to establish service boundaries and responsibility
  - Identify the natural areas of responsibility to define the scope of a microservice.
    - Could also rely on organizational boundaries.
    - Inventory service, scheduling service, shipping service
  - Services should be fully encapsulated.
    - Changes should have impact isolated to the service
    - Services should expose domain model, not implementation details
  - Development teams should be small, focused, and autonomous
- Identify the contracts and communication mechanisms to dependant services
  - Information needed to accomplish the enabling objective
  - Information needed to accomplish the enabling objective
- Create new service exposing APIs necessary for dependant services and reconfigure consumers to use the new service location.
- Track and migrate any remaining legacy service users over to the new microservice.