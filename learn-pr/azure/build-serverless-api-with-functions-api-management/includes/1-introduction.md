You can use Azure Functions and Azure API Management to build complete APIs with a microservices architecture.

<!-- TODO: I think this intro is inaccurate. My assumption is that our online store is up and running and the Function Apps are in existent as our business logic. The tasks is to give partners the ability to interact with our store functionality, hence the need to create an API. You already have the microservices. That's why, in the exercises that follow, we don't create functions, we just expose them as an API. Please modify this introduction.  -->

<!-- AJM: Good point. Fixed. -->

Suppose you work for an online store with a successful and busy web site. Your developers have written the business logic for the site as microservices in the form of Azure Functions. Now, you want to enable partners to interact with your online store from their own code by creating a web API that they can call over HTTP. You want to find an easy way to assemble your functions into a single API. 

The microservices include:

- A product details service.
- An order placement service.
- An order shipping status service.

In this module, you will learn how to use API Management to assemble multiple microservices, implemented as Azure Functions, into an integrated web API.

## Learning objectives

In this module, you will:

- Identify the value of Azure API Management in a serverless application
- Import an Azure Function App as an API in Azure API Management
- Import multiple Azure Function apps as a single API in Azure API Management

## Prerequisites

- Basic knowledge of Azure API Management and Azure Functions