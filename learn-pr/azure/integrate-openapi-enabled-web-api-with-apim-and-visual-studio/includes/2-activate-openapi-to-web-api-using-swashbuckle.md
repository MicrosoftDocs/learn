Before a web API can be published to [Azure API Management][az apim] with Visual Studio, it should have an OpenAPI description document.

The OpenAPI document is used by API Management to discover the endpoints for the web API.

And by using the Swashbuckle tooling, it's easier than ever for the VanArsdel developers to create an OpenAPI description of their web APIs.


## What is OpenAPI and what does it do? ##

The OpenAPI document defines a standard and programming language-agnostic interface description for web APIs. It allows both humans and computers to discover and understand the capabilities of a service without having access to source code, additional documentation, or inspection of network traffic.

![OpenAPI][image-01]

The OpenAPI document is a contract for web APIs. And it's all a consuming application needs to understand and communicate with the web APIs, without having to know where the APIs are located or whether they are running.


## Generate an OpenAPI document from an ASP.NET Core web API application ##

There are several ways to generate the OpenAPI document from your ASP.NET Core Web API app. [Swashbuckle][swashbuckle] is the most popular way to do so.

![Swashbuckle][image-02]

It's easy to use and, once it's installed to your app, it automatically displays the Swagger UI screen.

![Swagger UI][image-03]

Swashbuckle also generates the OpenAPI document on-the-fly, which includes all the API endpoint details, payload structures, security requirements, etc. Here's the sample document for VanArsdel's web API for the inventory management.

![OpenAPI Document][image-04]

In the next unit, you will take an exercise how to enable this OpenAPI capability to your ASP.NET Core Web API app.


[image-01]: ../media/2-activate-openapi-to-web-api-using-swashbuckle-01.png
[image-02]: ../media/2-activate-openapi-to-web-api-using-swashbuckle-02.png
[image-03]: ../media/2-activate-openapi-to-web-api-using-swashbuckle-03.png
[image-04]: ../media/2-activate-openapi-to-web-api-using-swashbuckle-04.png


[az apim]: https://docs.microsoft.com/azure/api-management/api-management-key-concepts
[swashbuckle]: https://github.com/domaindrivendev/Swashbuckle.AspNetCore
