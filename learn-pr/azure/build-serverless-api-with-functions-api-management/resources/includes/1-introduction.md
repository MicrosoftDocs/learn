An Online store has built multiple Functions apps in a microservices architecture, and wants to stitch them together into a unified API to expose to partners.

A visitor of the website store will need to be able to see products details, place an order.

This system can be implemented using separate microservices such as:

- Viewing details of a product (Product with public GET API)
- Place an order (Order with public GET and POST API)
- Shipping an order (Triggered by an event)

In this module, you will enable application logging to record traces in your web applications. You will enable logging, monitor a live log stream, and retrieve logs from Azure.

## Learning objectives

In this module, you will:

- Identify the value of API Management in a serverless application.
- Import Function Apps as APIs
- Expose multiple Function Apps through a single API in API Management.

## Prerequisites

- Basic knowledge of Azure API Management and Azure Functions