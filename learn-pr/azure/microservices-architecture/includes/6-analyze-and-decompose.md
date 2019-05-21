To move their application to a microservices architecture, Fabrikam needs to evaluate their current application and determine what the scope of each microservice is. To do this, they are going to use the domain-driven design (DDD) framework. Let's see how they apply this to their application.

> [!NOTE]
> This article doesn't show a complete and comprehensive domain analysis. We deliberately kept the example brief, to illustrate the main points. For more information on DDD, please see the *Learn more* section in the summary at the end of this module.

## What is domain-driven design?

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