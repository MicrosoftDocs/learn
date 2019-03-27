## Title

*Option 1:* Build a serverless application with Azure Functions and API Management
*Option 2:* Expose and abstract serverless applications with API Management

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

Build a simplified online store system with Azure Functions and expose it through Azure API Management.

## Learning objectives

1. Recognize the value of API Management in a serverless application.
1. Expose multiple Function Apps through a single API in API Management.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask                                                                                                  | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Recognize the problems of microservices-based architectures and understand how API Management can solve them |                                                                   | Knowledge check                                          | 1                                                | Yes                                                                                                                            |
| Create a new API from a Function App in API Management                                                   |                                                                   | Exercise                                                 | 2                                                | Yes                                                                                                                            |
| Import a Function App into an existing API in API Management                                             |                                                                   | Exercise                                                 | 2                                                | Yes                                                                                                                            |
| Test the API with the API Management interactive console                                                 |                                                                   | Exercise                                                 | 2                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    - Present the real-world problem: online store
    - Outline the microservices-based architecture of the system

1. **Implement a serverless application with Azure Functions** (should be done automatically by the learning environment)

    - Create two Function Apps with HTTP trigger Functions
    - Implement the Functions

1. **Learn the problems of microservices-based architectures and understand how API Management can solve them**

    - Problems:
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

1. **Knowledge check: Learn the problems of microservices-based architectures and understand how API Management can solve them**

    - *TBD*

1. **Exercise: Create a new API in API Management from a Function App**

    - Create new API Management instance
    - Import a Function App as an API

1. **Exercise: Import a Function App into an API in API Management**

    - Import the second Function App into an existing API

1. **Summary**

    - *TBD*
    - Check out other modules from API Management to learn more about policies, security, optimization

    **Notes**:
    - Consider adding policies to the scope of the module
    - Frame the takeaway (single API management plane, unified domain)