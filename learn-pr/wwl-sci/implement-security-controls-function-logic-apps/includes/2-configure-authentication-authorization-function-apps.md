A Function app exposed as an HTTP endpoint with no authentication is directly accessible to any client that discovers the URL. Azure Functions doesn't enforce authentication by default—the platform trusts the application to implement it. For Contoso Retail's order processing functions, which receive inbound calls from external partner systems, that default is the wrong starting point.

## Understand Azure App Service Authentication

Azure App Service Authentication—commonly called EasyAuth—is a built-in authentication middleware that runs as a separate component on the same platform as your Function app. When enabled, every inbound HTTP request passes through the authentication layer before your function code runs. EasyAuth validates tokens, manages authenticated sessions, and injects identity information into request headers. You don't need to add authentication libraries to your function code or modify any function logic.

EasyAuth supports multiple identity providers: Microsoft Entra ID, Facebook, Google, X, GitHub, and any OpenID Connect-compatible provider. For enterprise workloads, Microsoft Entra ID is the correct choice. When you configure Microsoft Entra as the provider, EasyAuth validates the bearer token on each request against your tenant—any request without a valid token is stopped at the middleware layer.

> [!NOTE]
> Enabling EasyAuth automatically redirects all inbound requests to HTTPS, regardless of your Function app's existing HTTPS enforcement settings. Authentication tokens are never transmitted over unencrypted HTTP connections.

## Configure Microsoft Entra ID as the identity provider

To configure Microsoft Entra ID authentication, navigate to **Authentication** in the Function app's settings screen and add Microsoft Entra ID as an identity provider. Azure supports two configuration modes:

- **Express setup**: Azure automatically creates a new app registration in the Microsoft Entra tenant associated with your subscription. This is the fastest path for greenfield deployments where no existing registration is required. The registration is scoped to your Function app and configured with the correct redirect URIs automatically.
- **Advanced setup**: You provide an existing app registration—the application (client) ID and the issuer URL (your Microsoft Entra tenant endpoint). Use this mode when the app registration is managed centrally by your identity team, when you need to configure specific claims or API permissions, or when the function needs to appear as a known enterprise application in your directory.

Once the identity provider is configured, EasyAuth enforces authentication according to the **Action to take when request is not authenticated** setting:

- **Require authentication**: Any request without a valid Microsoft Entra bearer token is rejected with a 401 response or redirected to the identity provider sign-in page. The function code is never executed for unauthenticated requests. This is the correct setting for Function apps that should only accept calls from authenticated callers.
- **Allow unauthenticated requests**: Requests pass through to the function regardless of authentication status. EasyAuth still validates tokens when they're present and injects identity headers, but it doesn't block unauthenticated callers. Use this mode when the function itself handles authentication decisions—for example, when it needs to respond differently to anonymous and authenticated requests.

For Contoso Retail's inbound HTTP triggers, which should only accept calls from partner systems holding a valid Microsoft Entra token, **Require authentication** is the correct setting. No function code changes are required.

> [!IMPORTANT]
> By default, any user in your Microsoft Entra tenant can obtain a token for your application and call authenticated functions. If you need to restrict access to a specific group, application, or set of users, configure the app registration in Microsoft Entra to require assignment, then assign only the identities you want to permit.

## Understand Function authorization levels

In addition to EasyAuth, Azure Functions includes its own lightweight authorization mechanism: function authorization levels. This mechanism uses API keys to gate access to function endpoints and operates independently of EasyAuth.

Authorization levels are set per function or at the Function app level:

- **Anonymous**: No API key required. Any caller can invoke the function without a key. Use this level only when EasyAuth or an upstream gateway protects the endpoint—an anonymous function with no upstream authentication layer is a fully open HTTP endpoint.
- **Function**: Requires a key specific to that individual function. Each function in the app can have its own set of keys. A caller with one function's key can't invoke other functions in the same app.
- **Host**: Requires the host key, which is shared across all functions in the Function app. A caller with the host key can invoke any function in the app. The host key is also called the admin key when used for administrative operations.

Function keys aren't a substitute for identity-based authentication. API keys are static strings that can be extracted from code or configuration and inadvertently shared. For production Function apps where EasyAuth is configured with Microsoft Entra ID, function authorization levels provide defense-in-depth—a secondary layer that requires the caller to present both a valid key and a valid identity token.

> [!IMPORTANT]
> Don't use the Anonymous authorization level without an upstream authentication layer such as EasyAuth or Azure API Management. An anonymous function with no protection is a fully open HTTP endpoint on the public internet.

## Assign a managed identity for outbound connections

Contoso Retail's second gap—Cosmos DB connection strings stored as plain-text application settings—is a credential management problem. Application settings in a Function app are visible to anyone with read access to the App Service configuration screen. A plain-text connection string in an application setting is a direct path from access to the Function app configuration to full access to the downstream database.

Managed identities solve this by giving the Function app a Microsoft Entra ID identity that Azure manages automatically. The Function app authenticates to downstream Azure services using this identity—no connection string required, no credential to store, rotate, or accidentally expose.

To enable a system-assigned managed identity, navigate to **Identity** in the Function app settings and set **Status** to **On**. Azure creates a service principal for the Function app in the Microsoft Entra tenant. You then assign that service principal the appropriate role on each downstream resource:

| Downstream service | Recommended role |
|---|---|
| Azure Cosmos DB | Cosmos DB Built-in Data Contributor |
| Azure Service Bus | Service Bus Data Sender or Service Bus Data Receiver |
| Azure Storage | Storage Blob Data Contributor or Storage Queue Data Contributor |
| Azure Key Vault | Key Vault Secrets User |
| Azure OpenAI | Cognitive Services OpenAI User |

> [!NOTE]
> Function apps increasingly serve as AI agent orchestrators—coordinating calls to Azure OpenAI models, Azure AI Foundry endpoints, or custom prompt flow deployments. When a Function app invokes an Azure OpenAI endpoint, managed identity with the **Cognitive Services OpenAI User** role is the correct authentication pattern. This eliminates API key storage in application settings and ensures that access to the model endpoint is controlled and auditable through Azure RBAC.

With managed identity enabled and roles assigned, update each downstream service call in your function code to use `DefaultAzureCredential` from the Azure Identity SDK instead of a connection string. The credential automatically picks up the Function app's managed identity at runtime. For trigger and binding configurations that reference Azure services—Storage accounts for queue triggers, Service Bus for topic triggers—the connection property in the function configuration also supports managed identity through identity-based connections rather than connection string values.
