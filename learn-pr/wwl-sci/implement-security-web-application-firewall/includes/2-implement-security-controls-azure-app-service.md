Azure App Service provides several built-in security controls that operate at the platform layer—before any request reaches your application code. For Contoso Retail, applying these controls closes the first two gaps from the penetration test: no platform-level authentication enforcement, and unrestricted inbound traffic from any source IP address.

## Configure authentication with Microsoft Entra ID

App Service's built-in authentication feature—called EasyAuth—runs as a middleware layer that intercepts every incoming HTTP request before it reaches your application. When you configure EasyAuth with Microsoft Entra ID as the identity provider and set the unauthenticated request action to **Require authentication**, unauthenticated requests never reach your application code. The platform returns a 401 response for API clients or redirects browser users to the Microsoft Entra sign-in page.

Three settings require attention when configuring EasyAuth:

- **Token store**: Enable this setting so App Service stores and manages OAuth tokens on behalf of authenticated users. Your application code can read the token from injected HTTP request headers without implementing token management itself.
- **Allowed token audiences**: Set this to your application's Microsoft Entra app registration client ID. This rejects tokens issued for other applications, even if they're signed with a trusted issuer certificate.
- **Token refresh**: Configure how long the platform waits before refreshing tokens before they expire. The default behavior refreshes tokens automatically.

To configure EasyAuth in the Azure portal, navigate to your App Service, select **Settings** > **Authentication**, and then select **Add identity provider**. Choose **Microsoft** as the provider, then specify your Microsoft Entra tenant and app registration.

> [!NOTE]
> EasyAuth handles authentication—it verifies identity. Authorization decisions, such as role-based access within the application, still require implementation in your application code.

## Authenticate outbound calls with managed identity

Your App Service makes outbound calls to other Azure services—Azure SQL Database, Key Vault, Azure Storage, Azure AI services, and Azure OpenAI endpoints. Each connection requires authentication. Storing credentials in application settings or connection strings is a security risk: if the settings are exposed in logs, pipelines, or error messages, those credentials are exposed too.

A system-assigned managed identity eliminates this risk. When you enable a managed identity on the App Service, Azure creates an identity in Microsoft Entra ID bound to the lifecycle of that specific App Service resource. You don't create, store, or rotate this identity's credentials—Azure manages them automatically.

To use the managed identity for a downstream service, assign the appropriate role to the managed identity on the target resource. For example:

- Assign **Key Vault Secrets User** on the Key Vault to retrieve secrets.
- Assign **Storage Blob Data Reader** on a storage account to read blobs.
- Assign a built-in role on an Azure OpenAI resource to call the inference endpoint.

Enable the managed identity in the Azure portal by navigating to **Settings** > **Identity**, then toggle **System assigned** status to **On** and select **Save**.

## Enforce HTTPS and minimum Transport Layer Security (TLS) version

All traffic to App Service should travel over HTTPS. The platform accepts HTTP connections by default, which means credentials, tokens, and application data can be transmitted over unencrypted connections without extra configuration. Two settings close this gap.

**HTTPS Only** forces all HTTP requests to redirect to HTTPS before reaching the application. Enable it in the Azure portal under **Settings** > **Configuration** > **General settings**, then set **HTTPS Only** to **On**.

**Minimum TLS version** sets the lowest accepted protocol version. Set this to **1.2** to reject connections from clients using TLS 1.0 or 1.1, both of which have vulnerabilities and are considered deprecated. The minimum TLS version setting is on the same **General settings** page.

## Restrict inbound traffic with access restrictions

Access restrictions on App Service control which source IP addresses and network ranges can send inbound requests to your application. You configure rules in a priority-ordered allow/deny list. When the list contains at least one rule, an implicit deny-all applies to any source not matched by a rule.

Two rule types are useful when integrating App Service with an Application Gateway:

- **IP-based rules**: Allow a specific IPv4 address or Classless Inter-Domain Route (CIDR) range. Use this when the Application Gateway's public IP address is static and known.
- **Service tag rules**: Allow traffic identified by a service tag such as `AzureApplicationGateway`. This approach is more resilient to Application Gateway IP address changes.

To configure access restrictions, navigate to **Settings** > **Networking** > **Public network access**. Select **Add** to add a rule, set **Action** to **Allow**, and specify the source type and value. Rules are evaluated in priority order—the rule with the lowest priority number is evaluated first.

> [!IMPORTANT]
> Configuring access restrictions to allow only Application Gateway traffic is the step that prevents attackers from bypassing the WAF by targeting the App Service hostname directly. Don't skip this step after deploying Application Gateway.

## Enable virtual network integration for private outbound access

Virtual network integration allows your App Service to make outbound connections to resources inside an Azure virtual network without those resources having a public endpoint. Your App Service can reach a private Azure SQL Database, a Key Vault with public access disabled, or a private API endpoint—all over the virtual network's address space.

**Regional VNet integration** works by joining the App Service to a delegated subnet in your virtual network. Outbound connections from the App Service originate from the virtual network's IP address range, so private resources can grant access based on the subnet rather than a public IP.

Configure virtual network integration in the Azure portal under **Settings** > **Networking** > **VNet integration**. Select **Add VNet integration** and choose the virtual network and subnet. The subnet must be delegated to `Microsoft.Web/serverFarms` and must not be used for any other App Service resource.

## Deploy a private endpoint for fully private inbound access

A private endpoint assigns your App Service a private IP address in a subnet of your virtual network. With a private endpoint deployed and public network access disabled, the App Service has no internet-facing endpoint. The only path to the application is through the virtual network.

This configuration pairs naturally with Application Gateway as the public entry point. Application Gateway receives internet traffic on its public IP, WAF inspects each request, and approved requests are forwarded to the App Service private endpoint over the virtual network. The App Service is never directly reachable from the internet.

Deploy a private endpoint by navigating to **Settings** > **Networking** > **Private endpoints**, then select **Add**. Specify the subnet in which to create the private endpoint and allow Azure to create the necessary private DNS zone entry.

## Reference Key Vault secrets from app settings

Instead of storing sensitive values such as connection strings and API keys directly in app settings, use Key Vault references. A Key Vault reference is an app setting value in the following format:

```
@Microsoft.KeyVault(SecretUri=https://<vault-name>.vault.azure.net/secrets/<secret-name>)
```

At runtime, App Service resolves the reference by calling Key Vault using the managed identity you configured earlier, then substitutes the actual secret value. Your application code reads the app setting normally and receives the secret value—no changes to application code are needed.

Key Vault references provide two operational benefits beyond credential security. If a secret rotates in Key Vault, App Service picks up the new value automatically within 24 hours, or immediately on the next app restart or configuration change. And because the secret value never appears in App Service configuration blades or deployment artifacts, it's harder to expose accidentally.

> [!TIP]
> For the full reference string syntax and instructions for configuring access to network-restricted vaults, see [Use Key Vault references as app settings in Azure App Service](/azure/app-service/app-service-key-vault-references).
