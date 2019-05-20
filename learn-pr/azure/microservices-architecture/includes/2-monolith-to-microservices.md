

## What is a monolithic architecture?

## What is a microservices architecture?
    - In a microservices architecture, services are small, independent, and loosely coupled.
    - A microservice is small enough that a single small team of developers can write and maintain it.
    - Services can be deployed independently. A team can update an existing service without rebuilding and redeploying the entire application.
    - Services are responsible for persisting their own data or external state. This differs from the traditional model, where a separate data layer handles data persistence.
    - Services communicate with each other by using well-defined APIs. Internal implementation details of each service are hidden from other services.
    - Services don't need to share the same technology stack, libraries, or frameworks.
- What are the benefits of a microservices architecture?
    - Agility
    - Small code, small teams
    - Mix of technologies
    - Resiliency
    - Scalability
    - Data isolation
- What are the potential challenges of a microservices architecture?
    - Complexity
    - Development and testing
    - Lack of governance
    - Network congestion and latency
    - Data integrity
    - Management
    - Versioning
    - Skillset


## When should you choose a microservices architecture?
    - Large applications that require a high release velocity.
    - Complex applications that need to be highly scalable.
    - Applications with rich domains or many subdomains.
    - An organization that consists of small development teams.