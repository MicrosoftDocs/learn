# Title

Protect your APIs on Azure API Management

## Role(s)

- Solution Architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure API Management

## Prerequisites

- Basic knowledge of Azure API Management

## Summary

Protect your back-end APIs from information exposure and implement throttling to prevent resource exhaustion with policies in Azure API Management.

## Learning objectives

1. Remove response headers from your APIs
2. Replace URLs in the response body
3. Throttle requests that exceed a threshold

## Chunk your content into subtasks

Identify the subtasks of *Protect your APIs on Azure API Management*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Define what a response header is and why they are important | Prevent any unnecessary back-end information from being exposed | Exercise | 1 | No, 2 & 3 |
| Explain how to remove sensitive information from a response header | Prevent any unnecessary back-end information from being exposed | Exercise | 1 | No, 1 & 3 |
| Import an API into the APIM and test it | Prevent any unnecessary back-end information from being exposed  | Exercise | 1,2,3 | No, 1 & 2 |
| Define what a response body is | Prevent any unnecessary back-end information from being exposed  | Exercise | 2 | No, 5 & 6 |
| Explain how to mask URLS in a response body | Prevent any unnecessary back-end information from being exposed  | Exercise | 2 | No, 4 & 6 |
| Describe how the API Management Service policies can be used, transformation and rate limit | They are serving their APIs on the Azure API Management service and would like to implement policies to address these concerns  | Exercise | 2 | No, 4 & 5 |
| Throttle requests that exceed a threshold | Prevent abuse of the APIs in the form of a large volume of requests, and need a mechanism to throttle requests if they exceed an allowed amount  | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    A government agency has created an API to make recent and historical census data available. They want to prevent any unnecessary back-end information from being exposed that could lead to malicious attack. They would also like to prevent abuse of the APIs in the form of a large volume of requests, and need a mechanism to throttle requests if they exceed an allowed amount. They are serving their APIs on the Azure API Management service and would like to implement policies to address these concerns.

1. **Remove technical information from API responses**
    - Why is it important for the government agency to protect its APIs?
    - Overview of APIM and how to import an existing API, can we reference Publish and manage your APIs with Azure API Management for details?
    - Define response headers
        - Call out the consumption plan and how it can benefit developers
        - How to remove response headers in the Azure portal
        - Test what happens when you remove the response headers in the developer portal

1. **Exercise - Remove technical information from API responses**
    - Publish an API via the CLI, as this will speed up the exercise. The sample app needs to publish an OpenAPI endpoint.
    - Use the portal to create an API Management instance in the sandbox subscription.
        - Create a Consumption plan APIM instance (point out this is in Preview), so the unit needs to include a note making that clear. It should reassure the user that the overall experience is mostly the same.
    - Go into the developer portal and detail the test steps that will strip out the 'X-Powered-By' and 'X-AspNet-Version' headers.
    - Test the original response
    - Set the transformation policy

1. **Hide an APIs original URLs with a transformation policy**
    - Define what the response body is.
    - Why in this scenario is it important to amend the source URLs in the body of the API response with the APIM gateway URLs?
    - Explain what a transformation policy is and how to create one

1. **Exercise - Hide an APIs original URLs with a transformation policy**
    - Test the original response.
    - Create a transformation policy, and apply it to the API
    - Retest the new response

1. **Protect the performance of an API with a rate limit policy**
    - Define throttling, and how to choose between the two types (limit by subscription, or limit by key)
    - Explain how to test throttling
    - Describe how to write a rate limiting policy

1. **Exercise - Protect the performance of an API with a rate limit policy**
    - Create a rate limit policy, and apply it to the API
    - Test the API is being throttled

1. **Summary**
    - Learned why it is important to protect APIs
    - Can remove response headers from an API
    - Can replace and test URLs in the response body
    - Added throttling to limit calls to your APIs

## Notes

- Module will go through much of this tutorial - https://docs.microsoft.com/azure/api-management/transform-api

- Reuse example code from "Publish and manage your APIs with Azure API Management": A sample web API implementation that fits the scenario and publishes an OpenAPI spec. Please use ASP.NET Core and Swashbuckle to implement. The API only needs a handful (4-6) operations with names and inputs/outputs that fit the theme of the scenario, but the implementation of each operation can pretty much just return dummy data or some other kind of mocked-up response.
- To keep module duration down, use the consumption tier of APIM, which is available in the North Central US, West US, West Europe, North Europe, Southeast Asia, and Australia East regions

- I added a couple of comments as well. This module will use the consumption tier, which does not have access to the developer portal, so exercises that reference it will need to adjust accordingly. Additionally, I'm ok if this module is done in the portal. The portal provides a better experience for APIM, so probably will work better for this module.