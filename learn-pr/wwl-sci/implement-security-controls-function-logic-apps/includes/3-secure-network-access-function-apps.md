A Function app with authentication configured controls who can call it, but the function endpoint is still reachable from any network path—including the public internet. Network controls add a separate enforcement layer: restricting which network paths can reach the function at all, and controlling which network paths the function uses for its own outbound calls. Authentication and network isolation are independent and complementary. Both must be in place for a defensible security posture.

## Restrict inbound access with IP allow lists

Access restrictions let you define a priority-ordered list of allow and deny rules based on source IP address, Classless Inter-Domain Route (CIDR) range, or Azure service tag. When any explicit rule exists, an implicit deny-all applies to all traffic that doesn't match—you don't need to add a deny rule manually.

For Function apps that should only accept inbound calls from specific Azure services, service tag rules provide a clean solution. For example, to accept webhook calls only from Azure Event Grid, add a rule allowing the `AzureEventGrid` service tag and deny all other traffic. The service tag covers the full range of IP addresses used by that Azure service, so you don't need to manage individual IP ranges for services that use dynamic address pools.

Access restrictions are available across all Function app hosting plans, including Consumption, Flex Consumption, Elastic Premium, and Dedicated.

> [!TIP]
> Configure access restrictions to deny all traffic by default and add explicit allow rules for known sources before deploying to production. Starting with a deny-all posture is simpler to audit than building up a block list against an implicit allow-all.

## Deploy a private endpoint for inbound access

When Function app traffic should never traverse the public internet, a private endpoint removes the public endpoint entirely. A private endpoint assigns the Function app a private IP address within your virtual network (virtual network). All inbound traffic arrives through that private IP—external callers can't reach the function URL from the internet because no public route exists.

Private endpoints for Function apps are supported in the Flex Consumption, Elastic Premium, and Dedicated (App Service) hosting plans. The standard Consumption plan doesn't support private endpoints.

Once a private endpoint is configured, callers within the VNet—including other Azure services connected to the same network—resolve the function's hostname to the private IP address. This name resolution requires Azure DNS private zones. If your function is the backend for Azure API Management or an Application Gateway, those resources connect to the Function app through the private endpoint rather than a public URL, keeping all traffic on the Azure backbone.

> [!IMPORTANT]
> After creating a private endpoint for a Function app, disable public network access to ensure that all inbound traffic flows through the private endpoint only. Leaving public access enabled while a private endpoint exists creates a split-path network posture that's difficult to audit.

## Configure virtual network integration for outbound traffic

Private endpoints control inbound access—what can reach the Function app. Virtual network integration controls outbound access—what the Function app can reach. These are distinct controls and serve different purposes.

With virtual network integration enabled, the Function app routes its outbound network calls through a delegated subnet in your virtual network. This allows the function to call resources that aren't exposed to the public internet: a Cosmos DB account with no public access, a Storage account locked to specific virtual network subnets, or a private REST API hosted on a VM in the same network.

Regional virtual network integration is available in the Flex Consumption, Elastic Premium, and Dedicated plans and is the recommended configuration for most scenarios. The Function app and the virtual network must be in the same Azure region. The integration uses a delegated subnet—that subnet can't be used for other resources such as VMs or private endpoints.

> [!IMPORTANT]
> Virtual network integration alone doesn't route all outbound traffic through the virtual network. By default, only traffic destined for private IP address ranges (RFC 1918) routes through the integration subnet. To force all outbound traffic—including calls to public internet addresses—through the virtual network, set the `WEBSITE_VNET_ROUTE_ALL` application setting to `1`, or enable **Route all traffic** in the virtual network integration configuration screen.

## Configure CORS for browser-based clients

Cross-origin resource sharing (CORS) applies when browser-based web applications call HTTP-triggered Function apps directly. By default, browsers block cross-origin requests. Azure Functions lets you configure which origins are permitted to make those requests.

In production, specify explicit allowed origins—for example, `https://contoso-retail.com`. Never use the wildcard (`*`) in production. A wildcard CORS configuration allows any origin to make requests to your Function app, which removes the cross-origin protection that CORS provides for browser-based clients.

CORS restrictions apply only to browser-based HTTP clients. Server-to-server calls—from backend services, Azure services, or nonbrowser HTTP clients—aren't subject to CORS enforcement. CORS is a browser security mechanism, not a server-side access control.

## Reference Key Vault secrets in application settings

Application settings in Azure Functions are one of the most common locations where connection strings and API keys end up stored in plain text. The Key Vault reference pattern replaces a plain-text application setting value with a reference that the Function app resolves at runtime using its managed identity.

The syntax for a Key Vault reference in an application setting is:

```
@Microsoft.KeyVault(SecretUri=https://<vault-name>.vault.azure.net/secrets/<secret-name>/<version>)
```

If you omit the version identifier, the Function app resolves the latest version of the secret. This is useful for secrets that rotate regularly—the function picks up the updated value within 24 hours of rotation, without a redeployment.

To use Key Vault references:

1. Enable a system-assigned managed identity on the Function app.
2. Assign the **Key Vault Secrets User** role to the managed identity on the Key Vault.
3. Replace the plain-text value in each application setting with the `@Microsoft.KeyVault(...)` reference syntax.

The Function app resolves the reference at startup and injects the secret value as the application setting value. Function code reads the setting using `Environment.GetEnvironmentVariable("SETTING_NAME")` - the same call used for any other application setting, with no awareness of the Key Vault reference layer.

> [!NOTE]
> If the Key Vault is configured with network restrictions—a private endpoint or virtual network service endpoints—the Function app needs virtual network integration to reach the vault. Configure virtual network integration before adding Key Vault references to network-restricted vaults. Without a network path to the vault, the Function app can't resolve the reference and fails to start.
