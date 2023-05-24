Azure API Management acts as a gateway between your web APIs and the public internet.

Suppose you're the lead developer for an online shoe company. The company is growing quickly and wants to optimize its supply chain. One component of this optimization is to expose some internal data and processes, such as inventory and planning, to partners so they can directly access information on current stock levels. You want to provide partner access through a set of web APIs. These APIs will be published on the public internet, but only partner applications should be able to use them. Your company and your partners want to minimize the costs of integration, and your developer teams want to focus on the business logic, not secondary concerns such as authorization.

In this module, you'll create an API gateway to securely publish an API. To introduce ways you can secure access to an API, you'll use an API Management subscription key. At the end of this module, you'll be able to use API Management to publish any API.

## Learning objectives

In this module, you will:

- Create an Azure API Management gateway.
- Import an API to the API gateway.
- Publish an API ready for developer access.
- Call an API with a subscription key.

## Prerequisites

- Familiarity with basic concepts of web APIs, including operations, endpoints, and API standards such as OpenAPI.
 - Have a base understanding of Azure and cloud concepts, services, and the Azure portal.
- [!include[](../../../includes/azure-subscription-prerequisite.md)]