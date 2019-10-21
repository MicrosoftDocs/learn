# Module Design

## Title

Publish and manage your APIs with Azure API Management

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure
- Azure APIM

## Prerequisites

- Familiarity with basic concepts of web APIs, such as operations and endpoints

## Summary

Azure API Management is an Azure service that acts as a gateway between web APIs that you publish and the public internet. It lets you control who uses your APIs, enforces usage policies, and presents a professional front-end to developers using the API. Publishing an API through API Management lets you control who has access to your API by assigning them subscription keys.

## Learning objectives

1. Create an API gateway
1. Import an API
1. Publish an API
1. Call an API with a subscription key

## Chunk your content into subtasks

| Subtask                        | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|--------------------------------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Create an API gateway          | Creates a public API endpoint                                     | Exercise                                                 | 1                                                | Yes                                                                                                                            |
| Import an API                  | Enroll the API in APIM                                            | Exercise                                                 | 2                                                | No, combine with "publish an API"                                                                                              |
| Publish a product with the API | Publish the API at the endpoint                                   | Exercise                                                 | 3                                                | Yes                                                                                                                            |
| Call an APIM API               | Ensure the API is published and usable                            | Exercise                                                 | 4                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    An online shoe company is growing quickly and needs to expose some of its internal data and processes, such as inventory and planning, to its partners. They would like to do this via a set of web APIs. These APIs will be published on the public internet, but only partner applications should be able to use them. Stakeholders want to minimize the costs of integration, and the company's developers want to focus on the business logic, not secondary concerns like authorization.

1. **Create an API gateway**

    - Define API Management and its benefits
        - API Management is a hosted Azure service that sits between your APIs and the public internet.
        - Cover features briefly, including the developer portal
		- Spend a couple sentences calling out the consumption plan and its use cases (important as a lead-in for the exercise, see next unit).
    - Define API Gateway, explain how it works
        - (An API gateway is just an instance of API management)
    - How to create an API Gateway in the Azure portal
        - What happens when you create an API Gateway (an endpoint is created)

1. **Exercise - Create an API gateway**

    - Publish a sample API app that fits the scenario to App Service, explaining that within the scenario this is an existing API that the company wants to publish in a protected manner. This should be done quickly via the CLI, as it is purely overhead for the exercise. The sample app needs to publish an OpenAPI endpoint.
    - Use the portal to create an API Gateway in the sandbox subscription.
		- Create a Consumption plan gateway, not a standard SKU. Consumption plan is in preview and is intended for specific use cases that aren't very applicable here: we're doing it because it's much faster to create, so the unit needs to include a note making that clear. It should reassure the user that the overall experience is mostly the same.

1. **Import and publish an API**

    - Define what an API is in the context of APIM
    - Define "product" in the context of APIM
        - Collection of APIs
        - A scope at which configuration (like policies and access) can be applied
    - How to visualize products and their APIs in the portal
    - How to create/import APIs in APIM
        - Different methods/technologies offered

1. **Exercise - Import and publish an API**

    - Import the published API via its OpenAPI specification
    - Add it to the Unlimited product during the import process
    - Visualize the API in the Azure portal

1. **Call an API with the subscription key**

    - Define/explain subscription keys
        - Not required, but on by default, and a core feature of APIM
        - OUT OF SCOPE: Details on creating users and new subscription keys. This will be done in another module. This unit should call out that creating new users and giving them their subscription keys so they can access the API is a core part of the APIM workflow, but this should not walk through the process of doing so.
    - Explain how APIM keys must be passed in request headers
    - Explain how to find the administrator subscription key

1. **Exercise - Call an API with a subscription key**

    - Get the administrator APIM key from the portal
        - Explain that partners would be given their key as part of an onboarding process, but the mechanics of using the key are the same.
    - Using the Cloud SHell, craft a curl request to one of the API operations on the APIM endpoint. First try without the key, then with it.

1. **Summary**

    - Added an intermediary layer to an API
    - Built-in authorization system manageable from the portal
    - Can accommodate changes to APIs, new APIs, and implement access restrictions

## Notes

- This module is an "intro to APIM". The process this walks through (creating a gateway, publishing an API, making a call to it with the Administrator key) is the "Hello World" of APIM. Assume no knowledge of APIM on the part of the reader, although they should know the basics of web APIs.
- Requires a sample web API implementation that fits the scenario and publishes an OpenAPI spec. Please use ASP.NET Core and Swashbuckle to implement. The API only needs a handful (4-6) operations with names and inputs/outputs that fit the theme of the scenario, but the implementation of each operation can pretty much just return dummy data or some other kind of mocked-up response.
- We want the reader to use a Consumption plan API gateway because they can be created within a minute or two; the regular SKUs take ~30 minutes to create. This unfortunately precludes use of the developer portal, which means the final exercise will need to use the Cloud Shell and curl.