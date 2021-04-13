Organizations often need to provide partners with access to data. This access must be controlled and managed.

In the shoe company example, retailers that stock NorthWind Shoes need to know how much stock they can order. Customers also like to know exactly when they are going to get their order. 

Here, you'll learn how Azure API Management works, and how to set up an API gateway.

## Azure API management

The Azure API management service is hosted in the Azure cloud and is positioned between your APIs and the Internet. An **Azure API gateway** is an instance of the Azure API management service.

When you publish your APIs, you use the Azure portal to control how particular APIs are exposed to consumers. You might want some APIs to be freely available to developers, for demo purposes, and access to other APIs to be tightly controlled.

## Why use API Management?

For developers, API Management provides a range of benefits.

- **API documentation**. Documentation of APIs enables calling clients to quickly integrate their solutions. API Management allows you to quickly expose the structure of your API to calling clients through modern standards like Open API. You can have more than one version of an API. With multiple versions, you can stage app updates as your consuming apps don't have to use the new version straight away.
- **Rate limiting access**. If your API could potentially access a large amount of data, it's a good idea to limit the rate at which clients can request data. Rate limiting helps maintain optimal response times for every client. API Management let you set rate limits as a whole or for specific  individual clients.
- **Health monitoring**. APIs are consumed by remote clients. So it can be difficult to identify potential problems or errors. API Management lets you view error responses and log files, and filter by types of responses.
- **Modern formats like JSON**. APIs have used many different data exchange formats over the years from XML to CSV and many more. API Management enables you to expose these formats using modern data models like JSON.
- **Connections to any API**. In many businesses, APIs are located across different countries and use different formats. API Management lets you add all of these disparate APIs into single modern interface.
- **Analytics**. As you develop your APIs, it's useful to see how often your APIs are being called and by which types of systems. API Management allows you to visualize this data within the Azure portal. 
- **Security**. Security is paramount when dealing with system data. Unauthorized breaches can cost companies money, time lost in reworking code, and reputational loss. Security tools that you can use with Azure API management include OAuth 2.0 user authorization, and integration with Azure Active Directory.


## Pricing tiers
When you create an Azure API management gateway, you must select from one of several pricing tiers:

- **Developer**.  You use the Developer tier for evaluating the API management service. You shouldn't use this tier for production deployments. 
- **Basic**. Entry level production use. 99.9% SLA. 1000 requests/sec. Two scale units.
> [!NOTE]
> A scale unit enables you to scale up a service. The more scale units you have, the more you can scale up the service.
- **Standard**. Medium level production use. 99.9% SLA. 2500 requests/sec. Four scale units.
- **Premium**. Multi region deployment. High volume use. 99.95% SLA. 4000 requests/sec. 10 scale units per region.
- **Consumption**. The serverless consumption tier plan lets you pay for what you use, rather than having dedicated resources. You can quickly set up ad-hoc testing, and you can scale up API access when demand increases. The consumption tier has built-in high availability and autoscaling. Because it is serverless, you can provision a consumption tier gateway in a lot less time than the other server-based tiers.

## API management setup

To set up API management, you:
1. Create an API Management gateway. The name you use for the gateway  must be globally unique within the **.azure-api.net** namespace.
1. Register an existing Web API with the gateway. Registering the API makes the API available to consumers at the **\<gateway\>.azure-api.net** endpoint.
1. Call the existing API through the gateway. Consumers can now use the API at the endpoint URL, or through the developer portal.

