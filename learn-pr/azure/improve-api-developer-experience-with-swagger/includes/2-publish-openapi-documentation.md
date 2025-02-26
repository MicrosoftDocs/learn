An API can have great value, but it can't gain traction unless developers know how to use it. Developers want to integrate an API as quickly as they can. Good API documentation helps a developer understand the API's capabilities and how it should be used, making integration more efficient.

Traditionally, all documentation that described an API and how to use it was written by hand. Now we have a standard specification for API descriptions called OpenAPI. Swagger UI provides implementation and testing tooling of the OpenAPI specification for your APIs. Swashbuckle is an open-source package that provides automatic generation of OpenAPI description documents directly from Web API controllers using .NET reflection. Swashbuckle helps you automate the description process, making it easier for teams to generate, maintain, and use OpenAPI-based API documentation. You describe your API and let tools generate rich documentation.

## What is OpenAPI?

OpenAPI is a specification used for describing REST APIs. It's language agnostic, and enables you to describe your entire API including:

- Available endpoints
- Operation parameters
- Authentication methods
- Contact and other information

You can write API specifications in YAML or JSON. With the OpenAPI specification, humans and computers can understand the capabilities of your API without having access to its source code.

## What is Swagger?

Swagger is a set of open-source tools built around the OpenAPI specification. These tools can help you design, build, and document REST APIs. Swagger uses the OpenAPI specification of your API to understand its structure.

For example, **Swagger UI** is a tool that can visually render documentation in a browser for an API defined with the OpenAPI specification. **Swagger Codegen** can take the same OpenAPI specification of an API and generate client SDKs.

## What is Swashbuckle?

Swashbuckle is an open-source Swagger implementation used for generating Swagger documentation for .NET Core APIs using .NET reflection.

There are three main components to Swashbuckle:

- **Swashbuckle.AspNetCore.Swagger**: This component is the Swagger object model and middleware to expose `SwaggerDocument` objects as JSON endpoints.

- **Swashbuckle.AspNetCore.SwaggerGen**: This library is a Swagger generator that builds `SwaggerDocument` objects directly from your routes, controllers, and models. The library is typically combined with the Swagger endpoint middleware to automatically expose Swagger JSON.

- **Swashbuckle.AspNetCore.SwaggerUI**: This package is an embedded version of the Swagger UI tool. It interprets Swagger JSON to build a rich, customizable experience for describing the web API functionality. It includes built-in test harnesses for the public methods.

- **Swashbuckle CLI**: Once installed, this .NET global tool enables the ability to generate OpenAPI specifications during build/publish. There's a link to download Swashbuckle CLI at the end of this module.

Because these libraries are added to your app, they generate and visualize your API documentation from the latest version of your API. They create *living* documentation, always in sync with the latest code.
