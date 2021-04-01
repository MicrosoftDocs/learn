At VanArsdel, Crystal and her development team have built web APIs for inventory management. She wants to make sure the APIs are ready for [Azure API Management][az apim] to discover their endpoints through an OpenAPI document easily.


## What Is OpenAPI and What Does It Do? ##

The OpenAPI document defines a standard and programming language-agnostic interface description for web APIs. It allows both humans and computers to discover and understand the capabilities of a service without having to access to source code, additional documentation, or inspection of network traffic.

![OpenAPI][image-01]

Because the OpenAPI document is a contract for web APIs, the consumers' of them understand and communicate with the web APIs, without having to know where the APIs are located or whether they are running.


## Activating OpenAPI Capability on ASP.NET Core Web API Applications ##

There are several ways activating the OpenAPI document capability into your ASP.NET Core Web API app. [Swashbuckle][swashbuckle] is the most popular way to do so.

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
