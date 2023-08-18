Organizations often need to provide partners with access to data. This access must be controlled and managed.

In the shoe company example, retailers that stock NorthWind Shoes need to know how much stock they can order. Customers also like to know exactly when they're going to get their order.

Here, you'll learn how Azure API Management works, and how to set up an API gateway.

## Azure API management

The Azure API management service is hosted in the Azure cloud and is positioned between your APIs and the internet. Your API Management instance acts as an **Azure API gateway**.

When you publish your APIs, you use the Azure portal to control how particular APIs are exposed to consumers. You might want some APIs to be freely available to developers, for demo purposes, and access to other APIs to be tightly controlled.

## Why use API Management?

For developers, API Management provides a range of benefits.

- **API documentation**. Documentation of APIs enables calling clients to quickly integrate their solutions. API Management allows you to quickly expose the structure of your API to calling clients through modern standards like OpenAPI. You can have more than one version of an API. With multiple versions, you can stage app updates as your consuming apps don't have to use the new version straight away.
- **Rate limiting access**. If your API could potentially access a large amount of data, it's a good idea to limit the rate at which clients can request data. Rate limiting helps maintain optimal response times for every client. API Management lets you set rate limits as a whole or for specific individual clients.
- **Health monitoring**. APIs are consumed by remote clients. So it can be difficult to identify potential problems or errors. API Management lets you view error responses and log files, and filter by types of responses.
- **Modern formats like JSON**. APIs have used many different data exchange formats over the years from XML to CSV and many more. API Management enables you to expose these formats using modern data models like JSON.
- **Connections to any API**. In many businesses, APIs are located across different countries or regions and use different formats. API Management lets you add all of these disparate APIs into a single modern interface.
- **Analytics**. As you develop your APIs, it's useful to see how often your APIs are being called and by which types of systems. API Management allows you to visualize this data within the Azure portal. 
- **Security**. Security is paramount when dealing with system data. Unauthorized breaches can cost companies money, time lost in reworking code, and reputational loss. Security tools that you can use with Azure API management include OAuth 2.0 user authorization, and integration with Azure Active Directory.
- **Pricing tiers**. API Management offers tiers with different capabilities for request throughput, SLA, network isolation, upgrade flexibility, and so on. When you create an Azure API management gateway, you choose the tier that meets your needs.

## API management setup

To set up API management, you:

1. Create an API Management gateway. The name you use for the gateway must be globally unique within the **.azure-api.net** namespace.
1. Register an existing web API with the gateway. Registering the API makes the API available to consumers at the **\<gateway\>.azure-api.net** endpoint.
1. Call the existing API through the gateway. Consumers can now call the API at the endpoint URL.
