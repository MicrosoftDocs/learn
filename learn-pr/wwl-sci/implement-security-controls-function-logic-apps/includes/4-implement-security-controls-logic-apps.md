Azure Logic Apps workflows face the same three-layer security requirement as Function apps: controlling who can invoke a workflow trigger, what identity the workflow uses when authenticating to connectors, and what network path can reach the trigger endpoint. The controls available to you—and how you configure them—depend on which Logic Apps hosting plan you choose. Plan selection is a security decision, not just a cost, or scale decision.

## Choose between Consumption and Standard plan

Logic Apps Consumption workflows run in a shared, multitenant environment managed by Microsoft. Standard workflows run in a dedicated single-tenant environment. This architectural difference has direct security implications that affect which controls you can apply.

The Consumption plan offers limited network controls. You can configure IP restrictions on the trigger endpoint and restrict access to run history, but virtual network integration and private endpoints aren't supported. If, a Consumption workflow needs to call private resources—a SQL Server with no public access or a Storage account restricted to specific virtual network subnets—you need intermediary services such as Azure API Management or an on-premises data gateway to bridge the network gap.

The Standard plan supports the full set of network controls available in Azure App Service: Virtual network integration for outbound connector calls, private endpoints for inbound trigger requests, and the same access restriction model used in Azure Functions. Standard plan workflows also run in isolation from other tenants' workflows.

| Capability | Consumption | Standard |
|---|---|---|
| IP restrictions on trigger | ✔ | ✔ |
| Virtual network integration (outbound) | ✗ | ✔ |
| Private endpoint (inbound) | ✗ | ✔ |
| Single-tenant isolation | ✗ | ✔ |

For workflows that handle personal data (personal data), financial data, authentication tokens, or calls to private resources, the Standard plan is the appropriate choice. The Consumption plan's network limitations are a meaningful security gap for these workloads, not a minor inconvenience.

## Use managed identity for connector authentication

Logic Apps connectors use connection resources to authenticate to external services. By default, those connection resources store credentials—a username and password, an API key, or an OAuth client secret—that persist in the connection configuration and are visible to anyone with access to the Logic app resource.

Managed identity authentication for connectors replaces stored credentials with an Azure-managed identity. The Logic app uses its system-assigned or user-assigned managed identity to authenticate to supported Azure services through connectors. Supported connectors include Azure Blob Storage, Azure Service Bus, Azure SQL Server, Azure Cosmos DB, and Azure Key Vault.

To configure managed identity for a connector:

1. Enable a managed identity on the Logic app—navigate to **Identity** and set the system-assigned identity to **On**, or configure a user-assigned identity.
2. When adding or editing a connector action in the workflow designer, select **Managed identity** as the authentication type.
3. Assign the managed identity the appropriate role on the target resource—for example, **Storage Blob Data Contributor** for Azure Blob Storage access.

Not every Logic Apps connector supports managed identity authentication. Before designing a workflow around this pattern, verify that your required connectors support it. For connectors that don't support managed identity, store credentials in Azure Key Vault and reference them from the connection resource configuration, rather than entering credentials directly into the connection.

> [!TIP]
> The Azure Logic Apps connector documentation for each service lists the supported authentication types. Check this before building the workflow, since changing authentication methods after a workflow is in production requires re-creating the affected connections.

## Restrict trigger access with IP allow lists

 Endpoints triggers for Logic Apps are HTTP endpoints. You can restrict which IP addresses can invoke a trigger by configuring IP allow lists, blocking all other source addresses before the workflow runs.

For Consumption plan workflows, configure trigger access restrictions in **Workflow settings** under **Access control configuration**. Specify the IP ranges permitted to call the trigger. All other source IPs are rejected.

For Standard plan workflows, configure access restrictions in **Networking** > **Access restrictions**, using the same interface as Azure Functions. You can allow specific IP ranges, Classless Inter-Domain Route (CIDR) blocks, or Azure service tags.

Service tag rules are useful for Logic apps that only handle events from specific Azure services. For example, restricting the trigger to the `AzureEventGrid` service tag means only calls originating from Azure Event Grid can invoke the workflow—arbitrary HTTP requests from other sources are blocked regardless of what URL they use.

## Configure private endpoints and virtual network integration for Standard plan

Standard plan Logic apps support the same private endpoint and virtual network integration model as Elastic Premium Function apps. These controls are configured at the Logic App (Standard) resource level and apply to all workflows within that resource.

A private endpoint for a Standard Logic app assigns the workflow trigger endpoint a private IP address within your virtual network. External callers can't reach the trigger URL from the public internet. Only resources within the virtual network—or connected networks through peering or ExpressRoute—can invoke the workflow. This is the correct configuration for workflows that process sensitive data and should only be reachable from internal systems.

Virtual network integration for outbound calls allows the Logic app to make connector calls to resources that aren't publicly accessible. With virtual network integration enabled on a Standard Logic app, connector actions can reach a SQL Server with no public endpoint, a Storage account locked to a specific subnet, or a private REST API hosted internally—the same outbound capabilities available to Elastic Premium Function apps.

> [!NOTE]
> Private endpoints and virtual network integration for Logic Apps are only available on the Standard plan. If your organization initially deployed workflows on the Consumption plan and later identified a requirement for private network access, migration to the Standard plan is required—there's no in-place upgrade path between plan types.

## Protect sensitive data in run history

Logic Apps stores the inputs and outputs of each action in run history, which is visible in the Azure portal. This default behavior is valuable for debugging, but for actions that process sensitive data—passwords, authentication tokens, personal data, or credentials—it exposes that data to anyone with read access to the Logic app resource.

The **Secure inputs** and **Secure outputs** settings on individual actions obfuscate the stored values in run history. When enabled, the portal displays `[Redacted]` instead of the actual content. The workflow still processes the data at runtime—only the storage of that data in run history is affected.

Enable secure inputs and outputs on any action that handles:

- Authentication tokens or API keys passed between steps
- Personal data retrieved from databases or external systems
- Credentials referenced from Key Vault connections
- Sensitive fields in HTTP request or response bodies

> [!IMPORTANT]
> Secure inputs and outputs are configured per action, not at the workflow level. Review each action in security-sensitive workflows individually and enable both settings where appropriate. An action earlier in the workflow that processes sensitive data without secure outputs enabled exposes that data in run history even if all downstream actions are secured.

## Require OAuth 2.0 authentication for HTTP triggers (Standard plan)

Standard plan Logic app workflows support OAuth 2.0 token validation on HTTP triggers through Microsoft Entra ID. When configured, the trigger requires a valid Microsoft Entra access token before the workflow starts—the same enforcement model as EasyAuth on Function apps.

To enable OAuth 2.0 on a Standard plan HTTP trigger, configure an authorization policy on the trigger. Add a Microsoft Entra ID authorization policy specifying the allowed audience—the application (client) ID of the app registration—and the required tenant. Requests without a valid bearer token that matches the policy are rejected before any workflow action runs.

This configuration is valuable for Standard plan workflows exposed as API endpoints that should only be callable by specific Microsoft Entra registered applications or identities. When you combine the configuration with IP restrictions or a private endpoint, OAuth 2.0 token validation on the trigger creates two independent authentication barriers.
