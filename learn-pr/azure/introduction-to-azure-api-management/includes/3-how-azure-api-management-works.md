Here, we discuss how Azure API Management works for API consumers, API providers, and App developers. This knowledge helps you continue to evaluate whether Azure API Management is a good solution for managing your organization's APIs.

## Azure API Management for API consumers

An *API consumer* is an entity such as a mobile app, web app, or IoT device that makes a request to the API for data. The key Azure API Management component for consumers is the gateway. All consumer API calls are first routed to your gateway endpoint. API consumers only ever interact directly with the gateway and never with the actual API deployment instance.

The gateway performs many tasks from the consumer's point of view, but the following are the most important:

- **Authentication**: The gateway monitors access to the API by verifying the consumer's credentials.
- **Security**: The gateway prevents API misuse by enforcing predefined rate limits and consumer usage quotas, or by validating requests and responses against the API's schema.
- **Routing**: After an API request is authenticated, validated, and transformed, the gateway routes the call to the backend service where the API is deployed.
- **Performance**: The gateway can store the backend API response in a cache, which gives consumers faster response times and reduces the load on the backend server.
- **Transformation**: The gateway transforms the API request or response as needed. For example, if the backend service responds with XML data, you can modernize the API by transforming the XML into JSON automatically, as depicted in the following image.

:::image type="content" source="../media/3-how-azure-api-management-works-transform.png" alt-text="A mobile app requests a weather forecast using an API. The Azure API Management gateway routes the call to the backend server and then converts the server's XML response to JSON before returning it to the mobile app." lightbox="../media/3-how-azure-api-management-works-transform.png":::

## Azure API Management for API providers

If you're an API provider, you still have work to do after your APIs have been published. This work includes setting API policies, managing API consumers, managing API revisions and versions, and monitoring and analyzing your APIs. You can perform these tasks using the Azure API Management administration interface, Azure CLI, or Azure PowerShell.

The administration interface enables you to perform the following tasks:

### Define and import API specs

You can import an OpenAPI specification, a REST API, a Simple Object Access Protocol (SOAP) API, a WebSocket API, or a GraphQL API. You can also create an API by importing instances of Azure services like Web App, Container App, Function App, Logic App, and Service Fabric. In addition, you can create a blank API and define it manually.

### Manage users and groups

A *user* is a developer account for an API consumer that you can add manually or invite to create an account. A *group* is a collection of related users that you can associate with a particular API product, and then each group's user has access to the product.

### Package APIs into products

A *product* is a group of related APIs. By packaging multiple APIs as a single product, you can configure just the product instead of configuring all the APIs separately. This configuration gets applied to all the APIs in the product, and after published consumers can subscribe with a single subscription key.

### Monitor and analyze APIs

The administration interface includes built-in monitoring tools to trace and review API traffic in real time and analytics for insights on how consumers are using your published APIs. Azure API Management also supports several Azure tools including Azure Monitor Logs, Application Insights, and Event Hubs.

### Manage API revisions and versions

When your API developer team needs to make changes to an API, expose the change in a safe and controlled manner by using revisions and versions. A *revision* is a relatively minor or nonbreaking change to an API. Your development team can code and test the revision separately from the production API, and then set the updated API as the current revision once ready as in the following image. A *version* is a relatively major or breaking change to an API. Azure API Management enables you to offer developers multiple versions of the API simultaneously and offers several versioning schemes.

:::image type="content" source="../media/3-how-azure-api-management-works-revisions.png" alt-text="Depiction of how revisions work in Azure API Management. API requests from consumers are routed to the current revision of the API, whereas API requests from the in-house development team are routed to the API revision." lightbox="../media/3-how-azure-api-management-works-revisions.png":::

## Azure API Management for App developers

Except for the Consumption tier, all Azure API Management instances include a developer portal where you surface your APIs to potential and existing API consumers. The developer portal comes with a default interface that's customizable to match your organization's branding and requirements. Once signed in, developers are presented with a web interface that enables them to interact with APIs in the following ways:

- **Accessing API documentation**: Developers can review the documentation you've provided for each API.
- **Testing an API**: Offers an interactive console that enables a developer to test an API quickly and safely.
- **Reviewing API code samples**: API call samples in several programming languages, including C#, Java, JavaScript, PHP, and Python.
- **Subscribing to an API**: When a consumer decides to use your API, it enables the user to create a subscription to the API and obtain a subscription key to use when calling the API.
- **Running analytics**: Includes analytics on the developer's usage of an API.
