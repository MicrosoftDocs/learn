<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how <features> of <product> work to <solve problem>."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Here, we'll discuss how Azure API Management works from three points of view: API consumers, administrators, and developers. This knowledge will help you evaluate whether Azure API Management is a good solution for managing your organization's APIs.

In this unit, you'll learn about how the following users use Azure API Management:

- API consumers
- API administrators
- API developers

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of <product> and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->

## How Azure API Management works for API consumers

An API *consumer* is an entity that makes a request to the API for data. So, for example, any of the following could be a consumer of an API:

- Business partner
- Employee
- Mobile app
- Web app
- IoT device

The key Azure API Management component for consumers is the gateway because all consumer API calls are first routed to your gateway endpoint. The gateway is also the essential element in decoupling your APIs, because the gateway endpoint is always separate from your API's deployment location in the backend. API consumers only ever deal directly with the gateway, never with the actual API deployment instance.

The gateway performs many tasks from the consumer's point of view, but the following are the most important:

- Authentication. The gateway monitors access to the API by verifying the consumer's subscription keys, JWT tokens, and other credentials.
- Security. The gateway prevents API misuse by enforcing predefined rate limits and consumer usage quotas.
- Transformation. The gateway transforms the API request or response as needed. For example, if the backend service responds with XML data, you can modernize the API by transforming the XML into JSON automatically, as depicted in the following image.
- Routing. After an API request is authenticated, validated, and transformed, the gateway routes the call to the backend service where the API is deployed.
- Performance. The gateway can store the backend API response in the Azure API Management cache. In situations where the backend response is static over time, serving subsequent responses from the cache gives consumers faster response times and reduces the load on the backend server.

:::image type="content" source="../media/3-how-azure-api-management-works-transform.png" alt-text="A mobile app requesting a weather forecast using an API. The Azure API Management gateway routes the call to the backend server and the gateway converts the server's XML response to JSON.":::

<!-- Pattern for complex topic -->

## How Azure API Management works for administrators

If you're an API administrator or manager, you still have a great deal of work to do after your APIs have been published. This work includes:

- Setting API policies
- Managing API consumers
- Handling API revisions and versions
- Monitoring and analyzing your APIs

You can perform all of these tasks and more by using the Azure API Management administration interface, which is a set of Azure portal pages that enables you to administer your APIs. Besides enabling you to set API policies, as you learned in the previous unit, the Azure API Management administration interface enables you to perform the following tasks:

- Defining and importing API specs. After you've provisioned your Azure API Management instance, you can use the administration interface to import your API specifications. You can import an OpenAPI specification, a REST API, and a Simple Object Access Protocol (SOAP) API (which you can optionally convert to REST). You can also create an API by importing instances of the following Azure services: Web App, Function App, Logic App, and Service Fabric. You can also create a blank API and define it manually.
- Managing users and groups. In Azure API Management, a *user* is a developer account—that is, it's an account for an API consumer. You can add users manually or invite users to create an account, but most users create their own accounts by using the developer portal. A *group* is a collection of related users. You can associate a group with a particular API product and each user in that group will have access to the product in the developer portal.
- Packaging APIs into products. In Azure API Management, a *product* is a group of related APIs. By packaging multiple APIs as a single product, you can configure just the product instead of configuring all the APIs separately. For example, you can set rate limits and other policies, define terms of use, add groups, and so on. This configuration gets applied to all the APIs in the product. After you publish the product, consumers can subscribe to it and use its APIs with a single subscription key.
- Handling API revisions and versions. When your API developer team needs to make changes to an API, you can make the change in a safe and controlled way that doesn't adversely affect consumers, by using revisions and versions:
  - Revisions. A *revision* is a relatively minor or non-breaking change to the API. Your development team can code and test the revision separately from the production API, as shown in the following image. Then, when your revision is ready for consumers, you can use the Azure API Management administration interface to set the updated API as the *current* revision.
  - Versions. A *version* is a relatively major or breaking change to the API. Azure API Management enables you to offer developers multiple versions of the API at the same time. It also offers several versioning schemes, including path-based, header-based, and query string-based versioning.
- Monitoring and analyzing APIs. The administration interface includes built-in monitoring tools that let you review API traffic in real time and analytics that enable you to derive insights on how consumers are using your published APIs. Azure API Management also supports several Azure tools for monitoring APIs and running analytics workloads. Azure services supported by Azure API Management include API Inspector, Azure Monitor Logs, and Azure Application Insights.

:::image type="content" source="../media/3-how-azure-api-management-works-revisions.png" alt-text="Depiction of how revisions work in Azure API Management. API requests from consumers are routed to the current revision of the API, whereas API requests from the in-house development team are routed to the API revision.":::

## How Azure API Management works for developers

Except for the Consumption tier, all Azure API Management instances include a developer portal where you surface your APIs to potential and existing API consumers. The developer portal comes with a default interface that is customizable to match your organization's branding and requirements.

Users with developer accounts sign in to the developer portal (which also accepts guest users who don't yet have an account). Developers are then presented with a web interface that enables them to interact with your APIs in the following ways:

- Accessing API documentation. Developers can review the documentation you've provided for each API.
- Testing an API. The developer portal offers an interactive console that enables a developer to quickly and safely test an API. The developer can choose an API operation, add parameter values, and then submit the call to view what response the API returns.
- Viewing API code samples. The developer portal offers API call samples in several programming languages, including C#, Java, JavaScript, PHP, and Python.
- Subscribing to an API. When a consumer decides to use your API, the developer portal enables the user to create a subscription to the API and obtain a subscription key to use when calling the API.
- Running analytics. The developer portal offers analytics on the developer's usage of an API.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
