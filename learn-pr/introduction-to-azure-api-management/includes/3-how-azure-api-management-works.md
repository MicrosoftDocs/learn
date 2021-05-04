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
Here, we'll discuss how Azure API Management works from three points of view: API customers, administrators, and developers. This knowledge will help you evaluate whether Azure API Management is a good solution for managing your organization's APIs.

In this unit, you'll learn about:

- How API customers use Azure API Management
- How API administrators use Azure API Management
- How API developers use Azure API Management

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

## How Azure API Management works for API customers

An API *customer* is any entity that makes a request to the API for data. So a customer can be any of the following:

- Mobile app
- Web app
- IoT device
- Business partner
- Employee
- Developer

The key Azure API Management component for customers is the gateway because all customer API calls are first routed to your gateway endpoint. The gateway is also the essential element in decoupling your APIs because the gateway endpoint is always separate from your API's deployment location in the backend. API customers only ever deal directly with the gateway, never with the actual API deployment instance.

The gateway performs many tasks from the customer's point of view, but the following are the most important:

- **Authentication**: The gateway monitors access to the API by verifying the customer's subscription keys, JWT tokens, and other credentials.
- **Security**: The gateway prevents denial-of-service attacks and API misuse by enforcing predefined rate limits and customer usage quotas.
- **Transformation**: The gateway transforms the API request or response as needed. For example, if the backend service responds with XML data, you can modernize the API by transform the XML into JSON on-the-fly, as shown in the image below.
- **Routing**: Once an API request is authenticated, validated, and transformed, the gateway routes the call to the backend service where the API is deployed.
- **Performance**: The gateway can store the backend API response in the Azure API Management cache. In situations where the backend response is static over time, serving subsequent responses from the cache gives customers faster response times and reduces the load on the backend server.

:::image type="content" source="../media/3-how-azure-api-management-works-transform.png" alt-text="Diagram depicting a mobile app requesting a weather forecast using an API. The diagram shows how the Azure API Management gateway routes the call to the backend server and how the gateway converts the server's XML response to JSON.":::

<!-- Pattern for complex topic -->

## How Azure API Management works for administrators

The Azure API Management administration interface is an Azure portal interface that enables you to administer your APIs, which includes the following activities:

- Defining or importing API schemas.
- Implementing usage policies such as quotas and rate limits.
- Setting security policies.
- Managing users.
- Packaging APIs into products.
- Defining API transformations.
- Handling API revisions and versions.
- Running analytics on your API metadata.

### Packaging APIs into products

### Handling revisions and versions

### Running analytics

## How Azure API Management works for developers

The Azure API Management developer portal is a web interface that enables developers to interact with your APIs in the following ways:

- Reading the documentation for each API.
- Trying an API using the interactive console.
- Subscribing to an API and getting the API subscription key.
- Viewing code samples in different programming languages.
- Running analytics on the developer's usage

Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->