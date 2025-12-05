Companies that publish web APIs often need to control the behavior of those APIs without recoding them.

Suppose you're the lead developer for a government agency. The agency created an API to make recent and historical census data available. They want to prevent any unnecessary backend information from being exposed that could be used in malicious attacks. They would also like to prevent abuse of the APIs in the form of a large volume of requests. They need a mechanism to throttle requests if the requests exceed an allowed amount. They're serving their APIs on the Azure API Management service and would like to implement policies to address these concerns.

Azure API Management enables a consistent, modern, and secure gateway for all your web APIs. It offers policies to transform API requests and responses through configuration.

In this module, you create an API gateway to publish a RESTful API. Then, you remove response headers, replace URLs, and throttle requests to achieve a secure endpoint for clients to communicate with.

## Learning objectives

In this module, you will:

- Create an Azure API gateway.
- Import a RESTful API into the gateway.
- Implement policies to limit unintended information exposure and throttle the requests.
- Test the applied policies by calling an API.

## Prerequisites

- Experience with publishing an API in Azure API Management
- Experience with XML syntax
- [!include[](../../../includes/azure-subscription-prerequisite.md)]
  