Cloud ecosystems such as Microsoft Azure and Amazon Web Services (AWS) are deeply embedded in the IT industry and popular hosting solutions for web applications and web services. It's likely that a cloud hosting system is the default choice for your applications so you need to ensure that the applications you create are designed to take maximum advantage from them.

A cloud-native application is one that you specifically design to run in the cloud. The applications often exhibit certain architectural patterns so that performance, scalability, and reliability are optimal. 

Imagine you work for an outdoor clothing and equipment company. The board has asked you to develop a new eShop web app for the company's main customer-facing site. Your team is familiar with the microservices model and you want to know whether using .NET Aspire will make the project easier.

In this unit, you'll learn more about cloud-native architectures and see the challenges that can be involved in building them. You'll also see how .NET Aspire can address those challenges.

## What is a cloud-native application?

A cloud-native application is one that is architected to make optimal use of cloud infrastructures to deliver the best performance, availability, and resilience. There are six pillars of cloud-native software architectures:

- **Cloud infrastructure.** Cloud-native applications are deployed to cloud hosting solutions and not to on-premises server farms.
- **Microservices.** Cloud-native applications are implemented as a set of microservices, each of which implements a small part of the business functionality.
- **Containers.** Microservices and other parts of the application are developed and deployed in containers to ensure a consistent execution environment.
- **Backing services.** Ancillary resources, such as databases and caching services, can be used to provide common functionality to microservices.
- **Modern design.** Cloud-native applications conform to the Twelve-Factore Application methodology, which includes principles such as Continuous Integration/Continuous Deployment (CI/CD), disposability, port binding, and so on.
- **Automation.** Cloud-native applications use Infrastructure as Code (IaC) to automate platform provisioning and deployment.

:::image type="content" source="/dotnet/architecture/cloud-native/media/cloud-native-foundational-pillars.png" alt-text="Conceptual diagram showing the six pillars of cloud-native applications.":::

To provide agility, a cloud-native application is composed of a set of microservices. Each microservice:

- Implements one portion of the complete functionality. 
- Executes in its own process and is isolated from the others, frequently in a dedicated container.
- Is built by a separate team. 
- Communicates with the others, but is loosely coupled. 

Each team chooses the languages and technologies they prefer to implement their microservice. Each microservice is deployed and scales independently of the others. 

The following diagram illustrates the differences between a traditional monolithic web application and a web application composed of microservices.

:::image type="content" source="/dotnet/architecture/cloud-native/media/monolithic-vs-microservices.png" alt-text="Conceptual diagram showing the differences between a monolithic web application and an application composed of microservices.":::

Cloud-native apps can realize many advantages for your business. For example:

- By hosting your app in the cloud, you don't have to build and maintain infrastructure such as hosting servers, operating systems, and supporting services yourself.
- Since each microservice is developed independently, you can continuously deploy new functionality in them without having to wait for other teams or major version milestones.
- Since each microservice runs in one or more containers, you know that the environment will be the same in all testing, staging, and production environments.
- You can use a container orchestration system, such as Kubernetes, to deploy extra instances rapidly to respond to additional demand.

## Challenges presented by cloud-native applications

A cloud-native application consisting of multiple microservices and with many features can become complex and present challenges that don't arise with monolithic apps. For example:

- **App definition.** Unless documented carefully, it can be difficult for developers to understand which components make up the complete cloud-native app.
- **Communication.** Each microservice might need to exchange messages or data with other microservices in order to formulate a response to a user request. While you must enable such communication, you must do so in a way that doesn't tightly couple one microservice to another. You also need communication to remain reliable at times of high demand or during service failures.
- **Resiliency.** No hosting service can be 100% available. You must ensure that, in rare occasions when a microservice is unavailable, the app handles failures robustly and keeps requests until the service returns.
- **Distributed data.** Each microservice implements its own data storage layer and may not use the same database server as the others. You must consider how you'll query for data from multiple microservices and how will you implement transactions.
- **Secrets.** If your app handles any kind of sensitive data, each microservice must authenticate every request it receives before returning a response. Often secrets such as asymmetric and symmetric encryption keys are used to protect data and positively identify calling users and microservices. You must consider how these secrets are stored and exchanged in your cloud-native app.
- **Developer onboarding.** New developers must be able to understand the app's architecture and how to work with it quickly. You must ensure that new developers can get up to speed without lots of cross-domain knowledge or local setup.

Recently, cloud-native application design has been gaining in popularity but challenges like those in this section discourage some teams from embracing this pattern. .NET, for example, has all the features needed to solve these issues but the solutions may need significant investment in training and custom code.

## What is .NET Aspire?

.NET Aspire is a new cloud-ready stack built for .NET designed to enable developers to create cloud-native applications fast and easily. Let's look at the features of .NET Aspire that address the challenges we've seen.

### Orchestration

Microservices and their loosely coupled nature increase the flexibility of your deployed app but can make configuration harder. The list of services that make up the app can become unclear and the endpoint where a microservice is available can be difficult to identify. .NET Aspire provides orchestration functionality so that:

- You can specify clearly for all teams the .NET projects, containers, executables, and cloud resources that make up the application.
- Microservices can automatically discover endpoints for all the application's components. .NET Aspire performs this service discovery by managing connection strings and injecting them into microservices where needed.

When you create a .NET Aspire solution, you'll see a new project in the solution called **\<SolutionName\>.AppHost**. This project implements orchestration for your app and you should ensure it's the start-up project for the solution.

### Components

Microservices commonly have functional requirements for complex backing services that underpin their features. For example:

- **Data storage.** To persist data to support product catalogs, shopping carts, identity stores, and other features, microservices must store data in structured or semi-structured stores.
- **Caching.** To maximize performance, microservices can store partial or complete responses in a cache so that subsequent similar requests can be satisfied more quickly.
- **Messaging.** Loosely coupled microservices must communicate with each other and you must ensure that this communication is reliable even when traffic is high or network conditions are challenging. A service that queues and distributes messages from senders to recipients is a common requirement.

In .NET Aspire, it's easy to implement these backing services in each microservice because the stack includes .NET Aspire components. Each component is a NuGet package that you can add to your solution and implements a standard interface to a backing service. This standard interface ensures that your microservice connects to its backing services consistently and seamlessly.

The out-of-the-box .NET Aspire components include:

- Data storage components such as those for PostgreSQL, SQL Database, Azure Cosmos DB, and MongoDB.
- Caching components such as the component for Redis.
- Messaging components such as those for RabbitMQ and Azure Service Bus.

> [!IMPORTANT]
> .NET Aspire includes many components that work with Azure services, like Azure Storage and Azure Service Bus but Azure is not required for .NET Aspire projects and they work equally well with backing services outside Azure, like RabbitMQ and MongoDB.

### Tooling

.NET Aspire also adds to the tools available for developers in Visual Studio. For example:

- New project templates enable you to create .NET Aspire solutions with a few steps in a wizard.
- The .NET Aspire dashboard is a web interface that appears whenever you start the solution from Visual Studio. This dashboard displays all the microservices and backing services for the app, and you can call them for testing. It also shows performance and monitoring tools.
- Extra menus items appear, which you can use to add a .NET Aspire component, register a project for .NET Aspire orchestrator support, or complete other tasks.

> [!NOTE] 
> You'll learn more about the .NET Aspire tools later in this module.

## Learn more

- [What is Cloud Native?](/dotnet/architecture/cloud-native/definition)
- [.NET Aspire overview](/dotnet/aspire/get-started/aspire-overview)
