Azure API Center is a new service on Azure that offers a structured and centralized repository of all your organizational APIs, enabling unified tracking, discovery, reuse, and governance. API Center is a secure solution that consolidates and organizes all your APIs regardless of their type, development lifecycle stage or deployment location for your API runtime together with any metadata or API-related information.

:::image type="content" source="../media/2-apic-definition.png" alt-text="Screenshot showing Azure API Center landing page on Azure.":::

## Benefits of API Center

| Customer problem| Benefits of API Center |
|----------|----------|
| **Poor API discoverability and reuse**   | **Ease of API discoverability and consumption.** API managers can view a complete inventory of all APIs in the Azure portal. API consumers can use the web-based API Center portal to discover and consume APIs, or use the API Center extension for Visual Studio Code to build, discover, and consume APIs.     |
| **Isolated and Abandoned APIs**    | **Centralized inventory of APIs.** API Center allows organizations to build a central repository of APIs from different teams and departments that act as a consolidated source of truth and trust for all APIs.    |
| **Potential security threats**    | **Ease of API governance.** With APIs consolidated in one location, governing these APIs to enforce organization security policies becomes easier for administrators.    |
| **Inconsistent API design**   | **Automated API design conformance checks.** API Center allows admins to enforce design standards across all APIs and implements a linting workflow that checks APIs against a defined style guide and generates an API compliance report accessible in your API Center.    |

## API Ecosystem roles & responsibilities

An organization's API ecosystem often consists of different roles with diverse responsibilities that are integral to its successful operation. Let's take a closer look into some of the roles.

1. **API producers** - These could be individual developers or teams whose main responsibilities include:
    - Consolidating system specifications and requirements
    - Designing the API architecture that fits the defined goals
    - Developing, securing, and publishing the APIs
    - Testing and ensuring APIs meet both functional and performance requirements
    - Documenting the APIs
    - API maintenance operations, which include managing versions and updates

    API producers strive to ensure they're following the best practices, security & compliance policies and organizational API standards for consistency. They also need to ensure they aren't duplicating the effort of previous/ other teams within the organization.

1. **API consumers** - These could be internal or external users of the APIs who:
    - Consume private APIs in their internal business workflows and services *(Internal consumers)*
    - Use restricted API endpoints to integrate into strategic business partnerships *(Partner consumers)*
    - Consume publicly available APIs to build external systems that use services provided by the organization *(Third-party consumers)*

    API consumers need to ensure that they quickly discover the most suitable APIs for their workloads to avoid wasting valuable development resources and efforts on duplications. To achieve this, it's important that they receive quality and easy to use documentation to validate the APIs that solve their respective needs and that they can seamlessly integrate into their applications.

1. **Product managers** - Product managers care about releasing secure, reliable, and compliant product experiences. Some of their tasks may include:
    - Creating plans to centralize all API operations
    - Enforce API best practices across product engineering teams for API design, security, and lifecycle
    - Enforce monitoring, analysis, and reporting for API governance
    - Facilitate collaboration and feedback between API producers and consumers
    - Driving successful product adoption

Product managers and IT Administrators at Contoso work together to roll out an easy-to-adopt strategy that will prevent the organization from experiencing API sprawl.

## How API Center works

Product managers and IT Administrators in an organization  need a fast and easy way to configure a centralized repository of all their APIs (both internal and external) along with any other metadata such as API versions, definitions, and more.
With API Center, you can create a catalog of APIs hosted and managed on different API management solutions and manage them across their different design, development, testing, and production lifecycles.

:::image type="content" source="../media/2-contoso-apic.png" alt-text="Screenshot showing an overview of API Center components":::

### Capabilities of Azure API Center

**API inventory**

At the foundation of API Center is building a complete and up-to-date inventory of all APIs built and used throughout the organization. This inventory is key to enabling API governance, discovery, and consumption at scale.

With API Center, you can add APIs to your inventory regardless of:

- API technology & language: ASP.NET Core Web API, Express, FastAPI, serverless API, etc.
- API type: REST, GraphQL, SOAP, gRPC, WebSocket, WebHook, etc.
- Runtime environment: Kubernetes cluster, Web App, API Management, Apigee API Management, Azure Functions, etc.

**API governance**

Now, with a complete API inventory, we need to look into how we can ensure these APIs are consistent, standardized, usable, and secure. API governance is defined as the practice of defining and applying standards, policies, and processes at scale across all organizational APIs.

This capability in API Center simplifies the tracking of APIs using metadata like versions, owners, lifecycle, and tracking of processes like compliance reviews, breaking change detection etcetera.

API Center also offers tooling around API design governance that supports linting, implemented using the Spectral JSON/ YAML linter, that ensures registered APIs conform to the organization’s style rules and provides an analytics functionality for your APIs. Enabling this for your organization helps with early detection of errors and inconsistency by generating a compliance report that can be viewed in your API Center.

API platform efforts are most successful when they have developer buy-in. The API Center extension for Visual Studio Code provides shift-left API governance capabilities for breaking change detection and API design governance to ensure APIs are built the right way the first time.

:::image type="content" source="../media/2-apic-analysis.png" alt-text="Screenshot showing API Analysis on API Center":::

**API discovery & consumption**

API Center streamlines the entire API development lifecycle, improving developer experience by integrating with popular developer tools such as Visual Studio Code. The API Center extension provides an experience for API consumers to discover, try, and consume APIs directly inside Visual Studio Code in the context of how they already work. Another capability of API Center is a traditional web-based API Center portal, designed to enable API consumers to easily navigate documentation, discover, access, and consume APIs from your API catalog.

:::image type="content" source="../media/2-apic-portal.png" alt-text="Screenshot showing API Center web-based portal":::

In the next unit, you'll see how you can create and manage your API inventory with API Center via the Azure portal, locally using the Azure CLI or on VS Code using the API Center extension.
