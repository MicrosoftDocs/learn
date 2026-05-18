Contoso Retail's security review identified four control gaps that left their serverless workloads exposed: unauthenticated HTTP triggers, plain-text connection strings in application settings, no inbound network restrictions on Function app endpoints, and hardcoded credentials in shared Logic app connection resources. This module addressed each gap using controls organized around three security layers.

## Review what you configured

The authentication layer—controlling who can invoke a Function app—was addressed through Azure App Service Authentication. You configured Microsoft Entra ID as the EasyAuth identity provider, using the **Require authentication** setting to block unauthenticated requests before the function code executes. Function authorization levels provide a secondary layer: host keys for app-wide access, function keys for per-function restriction, and the anonymous level reserved for endpoints protected by an upstream gateway.

The identity layer—controlling what the Function app acts as when making downstream calls—was addressed through system-assigned managed identity. With managed identity enabled and the appropriate RBAC roles assigned, connection strings are no longer stored in application settings. For AI orchestration patterns where Function apps invoke Azure OpenAI endpoints, the **Cognitive Services OpenAI User** role replaces API key storage entirely. Key Vault references with the `@Microsoft.KeyVault(SecretUri=...)` syntax extend this pattern to any application setting that previously held a secret value.

The network isolation layer—controlling what can reach the function endpoint—was addressed through inbound IP restrictions, private endpoints for Function apps on the Elastic Premium or Dedicated plan, and virtual network integration for outbound traffic. The same three-layer model was applied to Logic apps, with the Standard plan providing virtual network integration, private endpoints, and single-tenant isolation that the Consumption plan doesn't support. Secure inputs and secure outputs settings on individual Logic app actions protect sensitive data from appearing in run history.

## Learn more

- [Authentication and authorization in Azure App Service and Azure Functions](/azure/app-service/overview-authentication-authorization)
- [Azure Functions networking options](/azure/azure-functions/functions-networking-options)
- [Secure access and data for workflows in Azure Logic Apps](/azure/logic-apps/logic-apps-securing-a-logic-app)
- [Use Key Vault references in Azure App Service and Azure Functions](/azure/app-service/app-service-key-vault-references)
