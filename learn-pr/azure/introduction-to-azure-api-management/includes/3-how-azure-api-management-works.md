Here, we discuss how Azure API Management works from three points of use. This knowledge helps you continue to evaluate whether Azure API Management is a good solution for managing your organization's APIs.

In this unit, you learn about how Azure API Management works for the following types of users:

- API consumers
- API providers
- App developers

## How Azure API Management works for API consumers

An *API consumer* is an entity that makes a request to the API for data. For example, any of these entities could be an API consumer:

- Mobile app
- Web app
- IoT device

The key Azure API Management component for consumers is the gateway. All consumer API calls are first routed to your gateway endpoint. API consumers only ever interact directly with the gateway, and never with the actual API deployment instance.

The gateway performs many tasks from the consumer's point of view, but the following are the most important:

- **Authentication**. The gateway monitors access to the API by verifying the consumer's subscription keys, JWT tokens, and other credentials.
- **Security**. The gateway prevents API misuse by enforcing predefined rate limits and consumer usage quotas, or by validating requests and responses against the API's schema.
- **Transformation**. The gateway transforms the API request or response as needed. For example, if the backend service responds with XML data, you can modernize the API by transforming the XML into JSON automatically, as depicted in the following image.
- **Routing**. After an API request is authenticated, validated, and transformed, the gateway routes the call to the backend service where the API is deployed. 
- **Performance**. The gateway can store the backend API response in a cache. In situations where the backend response is static over time, serving subsequent responses from the cache gives consumers faster response times and reduces the load on the backend server.

:::image type="content" source="../media/3-how-azure-api-management-works-transform.png" alt-text="A mobile app requests a weather forecast using an API. The Azure API Management gateway routes the call to the backend server and then converts the server's XML response to JSON before returning it to the mobile app." lightbox="../media/3-how-azure-api-management-works-transform.png":::

## How Azure API Management works for API providers

If you're an API provider, you still have a great deal of work to do after your APIs have been published. This work includes:

- Setting API policies
- Managing API consumers
- Managing API revisions and versions
- Monitoring and analyzing your APIs

You can perform all these tasks and more, by using the Azure API Management administration interface in the Azure portal. Or, by using tools such as Azure CLI or Azure PowerShell. Besides enabling you to set API policies (as you learned in the previous unit), the administration interface enables you to perform the following tasks:

- **Define and import API specs**. Import an OpenAPI specification, a REST API, a Simple Object Access Protocol (SOAP) API (which you can optionally convert to REST), a WebSocket API, or a GraphQL API. You can also create an API by importing instances of the following Azure services: Web App, Container App, Function App, Logic App, and Service Fabric. You can also create a blank API and define it manually.
- **Manage users and groups**.
  - A *user* is a developer account. It's an account for an API consumer. You can add users manually or invite users to create an account, but most users create their own accounts by using the developer portal.
  - A *group* is a collection of related users. You can associate a group with a particular API product, and then each user in that group has access to the product in the developer portal.
- **Package APIs into products**. In Azure API Management, a *product* is a group of related APIs. By packaging multiple APIs as a single product, you can configure just the product instead of configuring all the APIs separately. For example, set rate limits and other policies, define terms of use, add groups, and so on. This configuration gets applied to all the APIs in the product. After you publish the product, consumers can subscribe to it and use its APIs with a single subscription key.
- **Manage API revisions and versions**. When your API developer team needs to make changes to an API, expose the change in a safe and controlled manner that doesn't adversely affect consumers by using revisions and versions:
  - A *revision* is a relatively minor or nonbreaking change to an API. Your development team can code and test the revision separately from the production API, as in the following image. Then, when your revision is ready for consumers, use the Azure API Management administration interface to set the updated API as the *current* revision.
  - A *version* is a relatively major or breaking change to an API. Azure API Management enables you to offer developers multiple versions of the API simultaneously. It also offers several versioning schemes, including path-based, header-based, and query string-based versioning.
- **Monitor and analyze APIs**. The administration interface includes built-in monitoring tools to trace and review API traffic in real time, and analytics for insights on how consumers are using your published APIs. Azure API Management also supports several Azure tools for monitoring APIs and running analytics workloads. Azure services supported by Azure API Management include Azure Monitor Logs, Application Insights, and Event Hubs.

:::image type="content" source="../media/3-how-azure-api-management-works-revisions.png" alt-text="Depiction of how revisions work in Azure API Management. API requests from consumers are routed to the current revision of the API, whereas API requests from the in-house development team are routed to the API revision." lightbox="../media/3-how-azure-api-management-works-revisions.png":::

## How Azure API Management works for app developers

Except for the Consumption tier, all Azure API Management instances include a developer portal where you surface your APIs to potential and existing API consumers. The developer portal comes with a default interface that's customizable to match your organization's branding and requirements.

App developers with developer accounts sign in to the developer portal (which also accepts guest users who don't yet have an account). Developers are then presented with a web interface that enables them to interact with APIs in the following ways:

- **Accessing API documentation**. Developers can review the documentation you've provided for each API.
- **Testing an API**. The developer portal offers an interactive console that enables a developer to test an API quickly and safely. The developer can choose an API operation, add parameter values, and then submit the call to determine what response the API returns.
- **Reviewing API code samples**. The developer portal offers API call samples in several programming languages, including C#, Java, JavaScript, PHP, and Python.
- **Subscribing to an API**. When a consumer decides to use your API, the developer portal enables the user to create a subscription to the API and obtain a subscription key to use when calling the API.
- **Running analytics**. The developer portal offers analytics on the developer's usage of an API.
