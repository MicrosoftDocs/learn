
Publishing an API is a great way to increase market share, generate revenue, and foster innovation. However, maintaining even one API brings significant challenges, such as onboarding users, managing revisions, and implementing security.

Developers need a way to reduce the complexity involved in supporting numerous APIs and their management. They require an API Management technology that can serve as a _front door_ for all their APIs. They need tools to implement security, manage revisions, and perform analytics.

Suppose Tailwind Traders has started a new service for premier subscribers to request home delivery, product assembly, and in person assistance for promoted products. The service is available in the mobile app and the online retail website. Customers browse the list of promoted products, and place their order. Tailwind Traders connects with contracted specialists who deliver and assemble the product, and provide the customer with hands on instruction.

The backbone of the new service is a large collection of published APIs, some of which are used by the following entities:
- Tailwind Traders mobile app and online website
- IoT devices on the delivery vehicles
- Vendor product specialists
- Tailwind Traders in-house development teams
- Tailwind Traders employees, such as business analysts

Each published API resides on a different server. Each API has its own process for onboarding users, and its own policies for security, revisions, analytics, and more. You're looking for an Azure solution that can help reduce this complexity. 

### Things to know about Azure API Management

[Azure API Management](/azure/api-management/api-management-key-concepts) is a cloud service platform that lets you publish, secure, maintain, and analyze all your APIs. The following diagram shows how Azure API Management serves as a front door for an organization's APIs, and routes to the server where the APIs are deployed.

:::image type="content" source="../media/api-management.png" alt-text="Illustration that shows how Azure API management serves as a front door for an organization's APIs." border="false":::

> [!IMPORTANT]
> Azure API Management doesn't host your actual APIs. Your APIs remain where they were originally deployed.
>
> Azure API Management serves as a front door for your APIs. In this way, Azure API Management is said to **decouple your APIs**.
> You set API policies and other management options in Azure, while leaving your deployed back-end APIs untouched.

### Things to consider when using Azure API Management

To determine whether Azure API Management is a suitable choice for managing and publishing your organization's inventory of APIs, there are three essential criteria to consider: number of APIs, rate of API changes, and API administration load. If you have a large number of deployed APIs that you revise frequently and require significant administrative overhead, Azure API Management is a strong solution. But for scenarios that involve small, static, or simple API deployments, Azure API Management might not be the correct choice.

Review the following criteria, and think about what APIs and API management are required to support the Tailwind Traders applications.

- **Consider number of APIs**. Identify how many APIs you need to manage. The more APIs you deploy, the greater the need for deployment standardization, and centralization of API control.

- **Consider rate of API changes**. Determine the rate at which your organization plans to implement API revisions and versions. The faster you create API revisions and publish new API versions, the greater the need for a robust, and flexible versioning control system.

- **Consider API administration load**. Define how much policy overhead you need to apply to your APIs. Policies include usage quotas, call rate limits, request transformations, and request validation. The more configurations and options your APIs require, the greater the need for standardized, and centralized policy implementations.

- **Consider standardizing disparate APIs**. Use an API management solution to standardize API specs, generate documentation, and create a consistent base URL for ease of use. Azure API Management can provide consistent analytics across multiple APIs and ensure compliance across all APIs.

- **Consider centralized API management**. Bring multiple APIs under a single administrative umbrella with Azure API Management and centralize all API operations. Without an API management service, each API is on its own in terms of administration, deployment, and developer access. A centralized model results in less duplicated effort and increases efficiency.

- **Consider enhanced API security**. Azure API Management was designed with API security in mind. Use the service to manage permissions and access, and protect your APIs from malicious usage.  Azure API Management helps to achieve all corporate and government-related compliance.