Many organizations that build distributed applications implement them by using microservices architectures.

In your online store, you want to implement each part of the application as a microservice - one for the product details, one for order placement, and so on. You have assigned a separate team to develop each microservice and each team will use continuous development and delivery to update and deploy their code on a regular basis. You want to find a way to assemble these microservices into a single product and then manage that product centrally.

Here, you will learn how you can build microservices as Azure Functions and then use Azure API Management to assemble those services into a complete product.

## Serverless architecture and microservices

In recent times, a new approach to the architecture of distributed applications has become more popular: microservices. When you build an application as a collection of microservices, you create many different small services. Each service is responsible for a limited set of functions and, usually, developed by a small team. Each microservice is developed, deployed, and scaled independently. This modular architecture results in an application that is easier to understand, improve, and test. It also makes continuous delivery easier because, when you deploy a microservice, you change only a small part of the whole application. 

Another complimentary trend in distributed software development is serverless architecture. In this approach, a host organization publishes a set of services that developers can use to run their code. The developers do not have to concern themselves with the supporting hardware, operating systems, or underlying software. Instead the code is run in stateless computing resources that are triggered by requests. 

## Azure Functions

Azure Functions is a service that enables serverless architectures in Azure. You can write your function to address your business problem directly, without worrying about the supporting infrastructure. You can write functions many different languages, including C#, F#, Node.js, Java, and PHP. You can also use libraries from NuGet and the Node Package Manager (NPM) and authenticate users with the OAuth standard from providers such as Active Directory, Facebook, Google, and Microsoft Account.

When you write a function, you choose a template to use, depending on how you want to trigger your code. Templates include:

- **HTTPTrigger** Code executes in response to an HTTP request.
- **TimerTrigger** Code executes based on a predefined schedule.
- **QueueTrigger** Code executes as messages arrive in an Azure Storage queue.
- **BlobTrigger** Code executes when Binary Large Objects (Blobs) are added to an Azure Storage account.
- **CosmosDBTrigger** Code executes when documents are added or updated in the Cosmos DB NoSQL database.

When you use Azure Functions, you are charged only for the time that your code runs. 

## Azure API Management

Azure API Management (APIM) is a fully managed cloud service that you can use to publish, secure, transform, maintain, and monitor APIs. It helps organizations publish APIs to external, partner, and internal developers to unlock the potential of their data and services. API Management handles all the tasks involved in mediating API calls, including request authentication and authorization, rate limit and quota enforcement, request and response transformation, logging and tracing, and API version management. APIM enables you to create and manage modern API gateways for existing backend services no matter where they are hosted.

Because you can publish Azure Functions through API Management, you can use them to implement a microservices architecture: Each function implements a microservice. By adding many functions to a single API Management product, you can build those microservices into an integrated distributed application. Once the application is built, you have many facilities that you can use to administer it. For example, you can use API Management policies to implement caching or ensure security requirements. In this module, you will see how to assemble functions in this way.

## Consumption Tier

The consumption tier is especially suited for microservice-based architectures and event-driven systems. For example, it would be a great choice for our example online store

You can choose the Consumption tier when creating a new API Management instance. This Consumption tier is designed and implemented around serverless principles, will allow more customers to enjoy the benefits of API management, and will become a more organic fit for the emerging breed of applications built using serverless technologies.

The Consumption tier uses the same underlying service components as the previous tiers but employs an entirely different architecture based on shared, dynamically allocated resources. It aligns perfectly with serverless computing models. There is no infrastructure to manage, no idle capacity, high-availability, automatic scaling, and usage-based pricing, all of which make it an especially good choice for solutions that involve exposing serverless resources as APIs.