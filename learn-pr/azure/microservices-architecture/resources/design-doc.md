# Title

Decompose a monolithic application into a microservices architecture

## Role(s)

- Solution Architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure Functions

## Prerequisites

- Basic understanding of application and system architecture
- Basic knowledge of C#

## Summary

Improve development agility, deployment, fault tolerance, and scalability by moderninzing your application with a microservices architecture.

## Learning objectives

1. Identify the properties and benefits of a microservices application
1. Decompose a monolithic application into a microservices architecture

## Chunk your content into subtasks

Identify the subtasks of *Decompose a monolithic application into a microservices architecture*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| **1** - Identify the features, benefits, and drawbacks of a microservices architecture | Determining if microservices is the right fit for their application | Knowledge check | Identify the properties and benefits of a microservices application | No, 2 |
| **2** - Compare the monolith and microservices architecture styles | Determining if microservices is the right fit for their application | Knowledge check | Identify the properties and benefits of a microservices application | No, 1 |
| **3** - Deploy a monolithic application on virtual machines | Running a monolithic application on virtual machines. | Exercise | Decompose a monolithic application into a microservices architecture | Yes |
| **4** - Analyze an application and identify decomposition boundaries | Evolving the application into a microservices architecture | Knowledge check | Decompose a monolithic application into a microservices architecture | Yes |
| **5** - Refactor a service within the monolith as a microservice | Evolving the application into a microservices architecture | Exercise | Decompose a monolithic application into a microservices architecture | Yes |
| **6** - Deploy a microservice on Azure Functions | Evolving the application into a microservices architecture | Exercise | Decompose a monolithic application into a microservices architecture | Yes |

## Outline the units

1. **Introduction**

    An organization is running a monolithic application on virtual machines. This application has become difficult to scale, code releases are causing frequent issues and have become increasingly large. This has delayed important features in the application, and is slowing innovation. The organization is interested in the microservices architecture, but are not sure if it's the right fit for their application, and how they would evolve their application into this architecture.

    **Delivery drone scenario**

    Fabrikam, Inc. is starting a drone delivery service, to compliment their existing shipping business. The company manages a fleet of drone aircraft. Businesses register with the service, and users can request a drone to pick up goods for delivery. When a customer schedules a pickup, a backend system assigns a drone and notifies the user with an estimated delivery time. While the delivery is in progress, the customer can track the location of the drone, with a continuously updated ETA.

    This scenario involves a fairly complicated domain. Some of the business concerns include scheduling drones, tracking packages, managing user accounts, and storing and analyzing historical data. Moreover, Fabrikam wants to get to market quickly and then iterate quickly, adding new functionality and capabilities. The application needs to operate at cloud scale, with a high service level objective (SLO). Fabrikam also expects that different parts of the system will have very different requirements for data storage and querying. All of these considerations lead Fabrikam to choose a microservices architecture for the Drone Delivery application.

1. **Monolith to microservices**

    List the content that will enable the learner to *Identify the features, benefits, and drawbacks of a microservices architecture*:

    - What is a microservices architecture?
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

    List the content that will enable the learner to *Compare the monolith and microservices architecture styles*:

    - Benefits of microservices over monolith
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - When to select microservices
        - Large applications that require a high release velocity.
        - Complex applications that need to be highly scalable.
        - Applications with rich domains or many subdomains.
        - An organization that consists of small development teams.

    *Knowledge check*

    What types of questions will test *learning objective*?

    - What are the benefits of microservices?
    - Which is an example of a microservices architecture?
    - What technologies are a requirement of microservices architecture?

1. **Exercise - Deploy a monolithic application on App Service**

    List the steps which apply the learning content from previous unit:

    1. Create App Service
    1. Create database (possibly Azure SQL)
    1. Deploy App Insights
    1. Deploy application

1. **Performance constraints of a monolithic application**

    Discussion of performance issues the application exhibits. Discussion of how this particular application is performing poorly as a monolith.

1. **Exercise - Identify performance issues in a monolithic app**

    Load test and look at poor performance in App Insights.

1. **Analyze an application and identify decomposition boundaries**

    List the content that will enable the learner to *Analyze an application and identify decomposition boundaries*:

    - Use Domain Driven Design (DDD) to establish service boundaries and responsibility
        - Identify the natural areas of responsibility to define the scope of a microservice.
            - Could also rely on organizational boundaries.
            - Inventory service, scheduling service, shipping service
        - Services should be fully encapsulated.
            - Changes should have impact isolated to the service
            - Services should expose domain model, not implementation details
        - Development teams should be small, focused, and autonomous

    List the content that will enable the learner to *Refactor a service within the monolith as a microservice*:

    - Identify the contracts and communication mechanisms to dependant services
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Create new service exposing APIs necessary for dependant services and reconfigure consumers to use the new service location.
    - Track and migrate any remaining legacy service users over to the new microservice.

    *Knowledge check*

    What types of questions will test *Analyze an application and identify decomposition boundaries* and *Refactor a service within the monolith as a microservice*?

    - Give an example business architecture, identify the possible domains

1. **Exercise - Refactor a service within the monolith as a microservice**

    List the steps which apply the learning content from previous unit:

    Show how the app now calls an API instead of an internal service.

    1. Pull out the code from the monolith into a microservice project
    1. Refactor to expose APIs where reliance on the microservice exits in the existing monolithic application.
        1. Could be handled by creating a proxy service for non-HTTP calls, and redirect clients to the proxy. Can then track and deprecate dependant service calls.
    1. Commit code changes to app.

1. **Exercise - Deploy a microservice on Azure Functions**

    List the steps which apply the learning content from previous unit:

    1. Create Azure Function
    1. Deploy application
    1. Configure monolith app to talk to Azure Function instead of service inside monolith.
    1. Re-run the load test and see improvement of performance

1. **Summary**

    We have identified the features and capabilities of microservices. We've discussed the differences between a monolith and microservices architecture. We've gone through service decomposition for a monolithic application and redeployed it as a microservice.

## Notes

Module based on this document from the Architecture Center - https://docs.microsoft.com/azure/architecture/guide/architecture-styles/microservices

Related article on monolithic apps - https://docs.microsoft.com/dotnet/standard/containerized-lifecycle-architecture/design-develop-containerized-apps/monolithic-applications
