# Module Design

## Title

Control authentication for your APIs with Azure API Management

## Role(s)

- Solution architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure API Management

## Prerequisites

- Basic understanding of certificates
- Basic understanding of API Management

## Summary

Discover how to protect your APIs from unauthorized use through the use of API keys and client certificate authentication.

## Learning objectives

- Use API keys to secure your APIs
- Use client certificate authentication to secure your APIs

## Chunk your content into subtasks

Identify the subtasks of *Control authentication for your APIs with Azure API Management*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Create subscriptions in Azure API Management. | "You want to use Azure API Management to properly secure this API from unauthorized use" | Exercise | Use API keys to secure your APIs. | Yes. |
| Upload a client certificate to secure access to an API | "You want to use Azure API Management to properly secure this API from unauthorized use" | Exercise | Use client certificate authentication to secure your APIs | No. Configure an API to use a client certificate for gateway authentication. |
| Configure an API to use a client certificate for gateway authentication. | "You want to use Azure API Management to properly secure this API from unauthorized use" | Exercise | Use client certificate authentication to secure your APIs | No. Upload a client certificate to secure access to an API. |
||||||

## Outline the units

1. **Introduction**

    Companies that publish data in APIs often need to control access to that data.

    Suppose you work for a meteorological company, which has an API that customers use to access weather data for forecasts and research. There is proprietary information in this data, and you would like to ensure that only paying customers have access. You want to use Azure API Management to properly secure this API from unauthorized use.

    In this module, you will use two different methods to secure access to an API in Azure API Management: subscriptions and client certificates.

    By the end of this module, you will be able to ensure that only people with the right credentials can access the information in your API.

1. **Create subscriptions in Azure API Management**

    - Describe how keys secure access to Web APIs.
        - What is a subscription in Azure API Management?
        - How does the client submit the key with each request?
    - Choose the right tier for an API Management instance.
        - What is the Consumption tier?
    - Choose the right scope for a subscription.
        - Product Scope
        - All APIs Scope
        - Individual API Scope

    > [!NOTE]
    > Make sure you clearly differentiate Azure API Management subscriptions from other subscriptions, such as Azure subscriptions.

1. **Exercise - Create subscriptions in Azure API Management**

    1. Create a new Web API in the Azure App Service
    1. Deploy sample code for a Web API to Azure
    1. Add the Web API to an Azure API Management instance
    1. Create a new subscription in the Azure API Management instance
    1. Call the Web API and pass the key.

    > [!NOTE]
    > You can call the Web API either by using curl from the Cloud Shell or by running a sample console application. In this second case, you must configure it with the new subscription access key.

1. **Use client certificates to secure access to an API**

    - Configure TLS mutual authentication
        - Describe TLS mutual authentication.
        - What is a client certificate?
        - How can a client obtain a certificate?
        - Using self-certification
        - How does a client submit a client certificate?
    - Configure an API to use a client certificate for authentication
        - How to upload a certificate in the Azure portal
        - How to configure an API to accept a client certificate

1. **Exercise - Use client certificates to secure access to an API**

    1. Configure TLS mutual authentication for the Azure App Service that contains the Web API.
    1. Upload a client certificate in the Azure portal.
    1. Configure an API to use the client certificate for gateway authentication.
    1. Run a sample client that uses the certificate.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

- [Subscriptions in Azure API Management](https://docs.microsoft.com/azure/api-management/api-management-subscriptions)
- [Create subscriptions in Azure API Management](https://docs.microsoft.com/azure/api-management/api-management-howto-create-subscriptions)
- [Client cert auth in APIM](https://docs.microsoft.com/azure/api-management/api-management-howto-mutual-certificates-for-clients)
- [How to secure back-end services using client certificate authentication in Azure API Management](https://docs.microsoft.com/en-gb/azure/api-management/api-management-howto-mutual-certificates)
- [Configure TLS mutual authentication for Azure App Service](https://docs.microsoft.com/en-gb/azure/app-service/app-service-web-configure-tls-mutual-auth)

For the exercise, we'll need to use the consumption tier to minimize APIM spin-up time. This tier is only available in a few regions and is in preview, so we'll need to give accurate steps to ensure the proper tier is used.
