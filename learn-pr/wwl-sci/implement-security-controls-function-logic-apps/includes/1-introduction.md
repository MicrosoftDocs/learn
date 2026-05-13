Contoso Retail runs Azure Functions to power event-driven order processing and inventory synchronization. These are HTTP-triggered functions that external partner systems call directly—triggered by inbound webhooks whenever a purchase is confirmed or a stock level changes. A security review surfaced four control gaps that had gone unaddressed since initial deployment. Several production functions accept unauthenticated requests—any caller with the URL can trigger them. Cosmos DB connection strings are stored as plain-text application settings, visible to anyone with read access to the App Service configuration screen. No inbound network restrictions exist, so the function endpoints accept traffic from anywhere on the internet. Their Logic Apps integration workflows present a fourth gap: connection resources shared across multiple apps contain hardcoded credentials that no one owns and no one rotates.

None of these gaps produce an immediate error. An unauthenticated HTTP trigger keeps working. A plain-text connection string keeps authenticating to the database. The exposure is silent until a credential is stolen, a function is abused, or a breach investigation reveals that every endpoint was open to the internet all along.

Serverless workloads require the same three-layer security model you apply to any API surface. The first layer controls who can invoke the function—authentication and authorization. The second layer controls what the function acts as when it makes downstream calls—managed identity. The third layer controls what can reach the function endpoint in the first place—network isolation.

This module works through each layer for both Azure Functions and Azure Logic Apps. For Function apps, you configure Azure App Service Authentication with Microsoft Entra ID, assign a managed identity to eliminate connection strings, and apply inbound IP restrictions, private endpoints, virtual network integration, and Key Vault references. For Logic apps, you apply the same managed identity and network patterns, choose the right hosting plan based on network capability requirements, and protect sensitive data exposed through run history.

By the end of this module, you're able to configure authentication, managed identity, and network isolation for Azure Function apps and Logic apps in a production security posture.

## Learning objectives

After completing this module, you'll be able to:

- Configure authentication and authorization controls for Azure Function apps
- Implement network access controls for Function apps including virtual network integration and private endpoints
- Apply managed identity, connector security, and network isolation for Azure Logic apps
