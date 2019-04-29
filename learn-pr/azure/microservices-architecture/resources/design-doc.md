## Title

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
- Basic knowledge of Docker containers

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

1. **Exercise - Deploy a monolithic application on virtual machines**

    List the steps which apply the learning content from previous unit:

    1. Create VMs
    1. Create database (possibly Azure SQL)
    1. Deploy application

1. **Analyze an application and identify decomposition boundaries**

    List the content that will enable the learner to *Analyze an application and identify decomposition boundaries*:

    - Use Domain Driven Design (DDD) to establish service boundaries and responsibility
        - Inventory service, scheduling service, shipping service
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective
    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    List the content that will enable the learner to *subtask*:

    - Enabling objective
        - Information needed to accomplish the enabling objective
        - Information needed to accomplish the enabling objective

    *Knowledge check*

    What types of questions will test *learning objective*?

    - Question type
    - Question type

1. **Exercise - Refactor a service within the monolith as a microservice**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Exercise - Deploy a microservice on Azure Functions**

    List the steps which apply the learning content from previous unit:

    1. Step
    1. Step
    1. Step

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

Module based on this document from the Architecture Center - https://docs.microsoft.com/en-us/azure/architecture/guide/architecture-styles/microservices

Related article on monolithic apps - https://docs.microsoft.com/en-us/dotnet/standard/containerized-lifecycle-architecture/design-develop-containerized-apps/monolithic-applications