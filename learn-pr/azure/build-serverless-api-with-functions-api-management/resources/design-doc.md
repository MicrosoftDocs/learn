## Title

Publish a serverless API with multiple Azure Functions apps and Azure API Management

## Role(s)

- Developer
- Solution Architect

## Level

Intermediate

## Product(s)

- Azure API Management
- Azure Functions

## Prerequisites

- Basic knowledge of Azure API Management and Azure Functions

## Summary

Build a simplified online store API with Azure Functions and expose it through Azure API Management.

## Learning objectives

1. Identify the value of API Management in a serverless application.
1. Import Function Apps as APIs
1. Expose multiple Function Apps through a single API in API Management.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask                                                                                                  | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Create a new API from a Function App in API Management                                                   |                                                                   | Exercise                                                 | 2                                                | Yes                                                                                                                            |
| Import a Function App into an existing API in API Management                                             |                                                                   | Exercise                                                 | 2                                                | Yes                                                                                                                            |
| Test the API with the API Management interactive console                                                 |                                                                   | Exercise                                                 | 2                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    Scenario <!-- TODO Flesh out -->: Online store has built multiple Functions apps in a microservices architecture, and wants to stitch them together into a unified API to expose to partners.

1. **Learning: Create a new API in API Management from a Function App**

    - Create new API Management instance
        - Discuss the serverless/consumption tier SKU
    - Import a Function App as an API

1. **Exercise: Create a new API in API Management from a Function App**

    - Scripted setup: Deploy two readymade Function Apps with HTTP trigger Functions that fit the scenario
    - Create new API Management instance (serverless SKU)
    - Import a Function App as an API
    - Use from the command line

1. **Learning: Import additional Functions to an existing API**

    - This unit should focus on the *why* of doing this
        - Concepts/problems:
            - Client applications are coupled to internal microservices
            - APIs are not surfaced under the same domain or IP address
            - Common API rules cannot be easily applied across microservices
            - Managing API changes and introducing new versions is difficult
        - How does API Management help?
            - API Management abstracts APIs from their implementation and hosts them under the same domain or a static IP address
            - Using API Management secures APIs by aggregating them in Azure API Management, and not exposing your microservices directly
            - With API Management you can also execute rules on APIs
            - API Management simplifies changing APIs
            - You can also monitor APIs when using API Management
            - API Management makes it easy to publish APIs to external developers
    - Show how to import an additional Functions app to an API
    - Add a two-question knowledge check at the end of this unit

1. **Exercise: Import additional Functions to an existing API**

    - Import the second Function App into the existing API
    - Use from the command line to illustrate how both APIs are exposed via the same endpoint

1. **Summary**

## Notes
    - Frame the takeaway (single API management plane, unified domain)
    - Based on https://docs.microsoft.com/en-us/azure/api-management/import-function-app-as-api, but should contain more conceptual content