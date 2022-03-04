Publishing an API is a great way to increase market share, generate revenue, and foster innovation. However, maintaining even one API brings significant challenges, such as onboarding users, managing revisions, and implementing security.

How do you reduce the complexity inherent in having numerous APIs and their management? You need an API Management that acts as a front door for all your APIs. API Management provides tools for implementing security, managing revisions, and performing analytics.

In this unit, you’ll learn about Azure API Management, and determine whether it's the correct solution to help reduce your API complexity.

## Select an API management solution

Suppose you work at a Tailwind Traders that has acquired a food-delivery platform. The customers use a mobile app or a website to browse the menus of multiple restaurants. Customers then place an order for the food they want. Your new company delivers the food. The backbone of your platform is a large collection of APIs. Some of the APIs that you publish are used by:

- Your mobile app

- Your web app

- Your partner restaurants

- The IoT devices on your delivery vehicles

- Your in-house development teams

- Your employees, such as business analysts

Each published API resides on a different server, has its own process for onboarding users, and has its own policies for security, revisions, analytics, and more. You've been tasked to find a way to reduce this complexity. 

Let's learn how Azure API Management can standardize, centralize, and help secure all the aspects of publishing and maintaining APIs across the full API lifecycle.

## What is Azure API Management?

[Azure API Management](/azure/api-management/api-management-key-concepts) is a cloud service platform that lets you publish, secure, maintain, and analyze all your company's APIs. The following diagram shows Azure API Management that acts as a 'front door' for all an organization's APIs, which are then routed to the server where the API is deployed.

:::image type="content" source="../media/api-management.png" alt-text="A graphic that depicts the use of Azure API management as described in the following text.":::

> [!IMPORTANT]
> Azure API Management does not host your actual APIs; your APIs remain where they were originally deployed. Instead, Azure API Management acts as a kind of façade or "front door" for your APIs. In this way, Azure API Management is said to decouple your APIs. This lets you set API policies and other management options in Azure, while leaving your deployed backend APIs untouched.

## When to use Azure API Management?

Here are the criteria we'll use to help you decide whether Azure API Management is a suitable choice for managing and publishing your organization's inventory of APIs.

- Number of APIs

- Rate of API changes

- API administration load

When you have numerous deployed APIs that you revise frequently and that require significant administrative overhead. Azure API Management can help you administer and publish them. Azure API Management might not be the correct choice for use cases that typically involve small, static, or simple API deployments. Let's review the decision criteria in more detail.

| **Criteria**| **Analysis** |
| - | - |
| Number of APIs| The key consideration when you're evaluating Azure API Management is the number of APIs that you manage. The more APIs you've deployed, the greater the need for deployment standardization, and centralization of API control. |
| Rate of API changes| The next consideration is the rate at which your organization implements API revisions and versions. The faster you create API revisions and publish new API versions, the greater the need for a robust, and flexible versioning control system. |
| API administration load| The last consideration is how much policy overhead you apply to your APIs. This includes usage quotas, call rate limits, request transformations, and request validation. The more configurations and options your APIs require, the greater the need for standardized, and centralized policy implementations. |


## Consider Azure API Management 

There are many reasons to choose Azure API Management. Using the food delivery scenario above as an example, let’s investigate API lifecycle management with respect to standardizing APIs, centralizing API management, and enhancing API security. The following table describes these features.

| **Feature**| **Description** |
| - | - |
| Standardize all disparate APIs| Considering disparate APIs in the new company such as mobile, partner restaurants, and IoT devices. It’s imperative that you use an API management solution. This solution will standardize API specs, help in creating documentation, and standardize the base URL for ease of use. API Management can provide consistent analytics across multiple APIs and ensure compliance across all APIs. |
| Centralize API operations| By bringing multiple APIs under a single administrative umbrella, Azure API Management enhances the centralization of all API operations. Without an API management service, each API is on its own in terms of administration, deployment, and developer access. A centralized model results in less duplicated effort and increases efficiency in the food delivery scenario. |
| Secure APIs| Azure API Management was designed with API security in mind. It manages permissions, access, protects the API from malicious usage and helps in achieving all corporate and government-related compliance. |