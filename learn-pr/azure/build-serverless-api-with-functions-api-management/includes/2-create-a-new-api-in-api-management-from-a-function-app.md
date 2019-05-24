<!-- Add introduction -->


## Azure Functions



## Azure API Management

Azure API Management (APIM) is a fully managed service that enables customers to publish, secure, transform, maintain,and monitor APIs. It helps organizations publish APIs to external, partner, and internal developers to unlock the potential of their data and services. API Management handles all the tasks involved in mediating API calls, including request authentication and authorization, rate limit and quota enforcement, request and response transformation, logging and tracing, and API version management. APIM enables you to create and manage modern API gateways for existing backend services hosted anywhere.

## Consumption Tier

The consumption tier is especially suited for microservice-based architectures and event-driven systems. For example, it would be a great choice for our example online store

You can choose the Consumption tier when creating a new API Management instance. This Consumption tier, is designed and implemented around serverless principles, will allow more customers to enjoy the benefits of API management, and will become a more organic fit for the emerging breed of applications built using serverless technologies.

Consumption tier uses the same underlying service components as the previous tiers but employs an entirely different architecture based on shared, dynamically allocated resources. It aligns perfectly with serverless computing model, i.e., no infrastructure to manage, no idle capacity, high-availability, automatic scaling, and usage-based pricing, all of which make it an especially good choice for solutions that involve exposing serverless resources as APIs.

## Import a Function App as an API

Azure API Management supports importing Azure Function Apps as new APIs or appending them to existing APIs. The process automatically generates a host key in the Azure Function App, which is then assigned to a named value in Azure API Management.