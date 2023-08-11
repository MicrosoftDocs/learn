Any organization that publishes an API needs to make sure that users can access it securely and that malicious users can't successfully attack it.

Governments store much personal data regarding citizens. Census data reveals a lot about each citizen, and their life. This data could be exploited to harm people. It is imperative that any data exposed through API endpoints are secured through modern standards.

As the lead developer, you'll look at how to set up a secured API gateway, which will protect the census data from unauthorized access. It will also help protect the endpoints from denial-of-service attacks.

## Azure API Management

The Azure API Management service is hosted in the Azure cloud and is positioned between your APIs and the internet. An **Azure API gateway** is an instance of the Azure API Management service.

Publishers of APIs use the Azure portal or other Azure tools to control how each API is exposed to consumers. For example, you might want some APIs to be freely available to developers, for demo purposes, and access to other APIs to be tightly controlled.

## Response headers

Response headers are metadata associated with HTTP responses that provide the detailed context of the response. They can expose information about the Server and platform technology being used.

:::image type="content" source="../media/2-response-headers.png" alt-text="Response Headers." loc-scope="other":::

In the Census API example, it's important that you remove the following header:

| Header | Detail |
|---------|---------|
| X-Powered-By | This header allows callers to see the technology stack being used. It could allow a malicious user to attempt to exploit any bugs within that stack. |

## API Management setup

To set up API Management, you will perform the following tasks:

- **Create an API Management gateway**. In this step, you create the API Management resource in the Azure portal. You also assign properties to the gateway, such as an FQDN and a pricing tier.
- **Register an existing web API with the gateway**. In this step, you add the web API to the gateway. The API already has its own Azure app service host but you must add it to API Management in order to use policies and other API Management tools.
- **Remove a header from the response**. In this step, you will apply a policy that removes an insecure header from all responses.
