

- Use Domain Driven Design (DDD) to establish service boundaries and responsibility
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