# Module Design

## Title

Improve the performance of an API by adding a caching policy in Azure API Management

## Role

- Developer

## Level

- Beginner

## Products

- Azure
- Azure API Management

## Prerequisites

- Experience with publishing an API in Azure API Management
- Experience with XML syntax

## Summary

API Management policies are configurable modules that can be attached to APIs to change their behaviors. Policies can do things like cache responses, transform documents and values, call webhooks for notification or audit purposes, and retry requests in the event of transient failures. This module will use policies to enable caching in order to improve API performance under load.

## Learning objectives

1. Identify whether or not a policy exists for the desired behavior
1. Choose a policy scope
1. Configure and apply a caching policy in the Azure portal

## Chunk your content into subtasks

Identify the subtasks of *Improve the performance of an API by adding a caching policy in Azure API Management*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Identify the architecture of APIM and where policies execute | "You want to learn how to write API Management policies" | Knowledge check | Identify whether or not a policy exists for the desired behavior | No. Identify the right policy for a task. |
| Identify the right policy for a task | "You want to learn how to write API Management policies" | Knowledge check | Identify whether or not a policy exists for the desired behavior | No. Identify the architecture of APIM and where policies execute. |
| Choose a policy scope | "You want to learn how to write API Management policies" | Knowledge check | Choose a policy scope | No. Choose from inbound, backend, outbound, and onerror tags |
| Choose from inbound, backend, outbound, and onerror tags | "You want to learn how to write API Management policies" | Knowledge check | Configure and apply a caching policy in the Azure portal | No. Choose a policy scope |
| Write XML for a policy | "...and how to use them to set up and control a cache" | Exercise | Configure and apply a caching policy in the Azure portal | No. Write a caching policy, Use the optimal vary-by tags and attributes in a caching policy |
| Write a caching policy | "...and how to use them to set up and control a cache" | Exercise | Configure and apply a caching policy in the Azure portal | No. Write XML for a policy, Use the optimal vary-by tags and attributes in a caching policy |
| Use the optimal vary-by tags and attributes in a caching policy | "...and how to use them to set up and control a cache" | Exercise | Configure and apply a caching policy in the Azure portal | No. Write XML for a policy, Write a caching policy |

## Outline the units

1. **Introduction**

    Many organizations use APIs to publish data and services. Customers and partners can call these APIs from any kind of client: desktop applications, mobile apps, web apps, and other systems. If your API is popular, you may need to optimize its performance to guarantee a good service to users.

    Suppose you are a developer for a board game company. A product line produced by your company has recently become very popular, and the volume of requests from your retail partners to your inventory API is growing quickly: much faster than the rate that your inventory actually changes. You'd like to be able to respond to requests successfully without incurring load on your API.

    You use Azure API Management to host your API. You've read that you can configure an API Management policy to cache compiled responses to requests and you think that this will be a good way to optimize performance. You want to learn how to write API Management policies and how to use them to set up and control a cache. Then you want to write a policy that accelerates responses to users.

    This unit also includes **Prerequisites** and **Learning objectives**

1. **Choose the right API Management policy**

    - Identify the role of policies in APIM and their overall capabilities
        - Cross-cutting concerns and things you don't necessarily want to code yourself - the boring business of APIs, as opposed to the business logic
        - What kinds of problems would you solve with policy? What kinds of problems should be solved in your own API code?
    - Identify the right policy for a task
        - List the high-level groups of policies that are available and take a closer look at a handful of them (don't drain the documentation)
        - Using the API Management policy documentation
        - Using the Azure portal UI
    - Choose a policy scope
        - Define these scopes: global, product, API, operation.
        - Portal screenshots and instructions about where to find the editor for the policy document at each scope
    - Choose from inbound, backend, outbound, and on-error tags
        - Explain when policies within each of these tags are applied

1. **Knowledge check**

    Describe a scenario which requires policies to modify the behavior of an API. For example, a scenario that requires throttling.

    - Question type: Which policy would you use?
    - Question type: Which policy scope would you use?
    - Question type: Would you place the policy in the inbound, backend, outbound, or on-error tag?

1. **Write a caching policy**

    - Write XML for a policy
        - How to use the templates provided by the Azure portal
        - Using the **&lt;base /&gt;** tag to determine when higher level policies apply
    - Write a caching policy
        - Use the **&lt;cache-lookup&gt;** policy in the **&lt;inbound&gt;** tag
        - Use the **&lt;cache-store&gt;** policy in the **&lt;outbound&gt;** tag
    - Use the optimal vary-by tags and attributes in a caching policy
        - Reasons to set the **vary-by-developer** attribute to true
        - Reasons to set the **vary-by-developer-groups** attribute to true
        - Using the **&lt;vary-by-header&gt;** tag
        - Using the **&lt;vary-by-parameter&gt;** tag

1. **Exercise - Write a caching policy**

    List the steps which apply the learning content from previous unit:

    1. Clone the API code in the Cloud Shell
    1. Deploy to App Service
    1. Create an API Management instance
    1. Add the new API to API Management
    1. Test the API
    2. Add a **&lt;cache-lookup&gt;** policy to the **&lt;inbound&gt;** tag
    3. Add **&lt;vary-by-header&gt;** and **&lt;vary-by-parameter&gt;** tags
    4. Add a **&lt;cache-store&gt;** policy to the **&lt;outbound&gt;** tag
    5. Test the policy. Make sure this makes it clear that APIM is actually successfully caching responses and skipping extraneous calls to the backend API.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- This module uses caching as a vehicle for introducing policy more generally. The prerequistes only assume the most basic of knowledge around publishing an API in APIM.
- Policy expressions are not covered in this module.
- Use zipdeploy to quickly deploy to app service instead of doing the git dance. See https://docs.microsoft.com/learn/modules/instrument-web-app-code-with-application-insights/5-instrument-the-application for an example.
- The sample code should be an ASP.NET Core web api and should use Swashbuckle/Swagger to publish an OpenAPI spec that can then be consumed in APIM. At least one operation on the API should be interesting enough to showcase the capabilities of APIM caching policies (varying by param, etc.)

Reference links:

- [What is API Management?](https://docs.microsoft.com/azure/api-management/api-management-key-concepts)
- [Policies in Azure API Management](https://docs.microsoft.com/azure/api-management/api-management-howto-policies)
- [How to set or edit Azure API Management policies](https://docs.microsoft.com/azure/api-management/set-edit-policies)
- [API Management caching policies](https://docs.microsoft.com/azure/api-management/api-management-caching-policies)
- [Add caching to improve performance in Azure API Management](https://docs.microsoft.com/azure/api-management/api-management-howto-cache)
- [API Management policies reference index](https://docs.microsoft.com/azure/api-management/api-management-policies)