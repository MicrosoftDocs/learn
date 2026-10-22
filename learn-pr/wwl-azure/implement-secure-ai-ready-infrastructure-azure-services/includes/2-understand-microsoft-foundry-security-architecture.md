
## Centralize shared security settings

Your fraud detection and customer service teams need consistent security controls for AI development. If each team configures every resource independently, your security administrators must review multiple sets of network rules, role assignments, and logging settings. A shared platform reduces repeated configuration, but you still need to identify which controls apply to each resource.

This unit covers Microsoft Foundry hubs and **hub-based projects**, which use the Foundry (classic) architecture. These aren't the same resource type as newer Foundry projects. Use the documentation for the project type you deploy rather than assuming both architectures have the same inheritance behavior.

A hub shares supported configurations across its hub-based projects. These include public network access settings, customer-managed key encryption, identity controls, and a managed virtual network. Hub-level Azure Policy enforcement also applies to the hub-based projects as documented for this architecture. Shared settings give your platform team a common baseline, while project permissions organize team access.

## Separate hub settings from connected resource controls

Suppose both teams need Azure OpenAI Service. They might provision separate service resources and networks, or use a shared service through a hub connection. The security design needs to account for the Azure OpenAI resource in either case.

:::image type="content" source="../media/manage-independent-sets-managed-identities.png" alt-text="Diagram showing separate fraud detection and customer service environments with their own Azure OpenAI resources and virtual networks.":::

A connection stores information needed to access an external service. It doesn't make that service part of the hub's resource boundary. Adding an Azure OpenAI connection doesn't automatically disable the service's public endpoint, configure its diagnostic settings, or assign permissions to every calling application.

For each connected resource, verify:

- The public network access setting and required private endpoint connections.
- The DNS configuration and network path used by callers.
- The identities, authentication method, and role assignments used for access.
- The diagnostic settings and approved log destinations.
- The encryption configuration required for that service.

Azure Policy assignments at appropriate resource scopes can audit or enforce supported settings. Check the policy's resource types, aliases, effect, and scope. A policy or diagnostic setting on the hub isn't a universal control for every resource referenced by a connection. When you change the baseline, verify compliance across the hub, projects, and connected services.

## Configure identity and network access

Microsoft Entra ID and Azure role-based access control (RBAC) govern access to the hub and projects. Access to connected Azure services also requires permissions on those services. For example, when a hub connection uses Microsoft Entra ID, grant the hub's managed identity the required role on the target resource.

Hub connections support multiple authentication methods, depending on the connector. These include managed identity, service principal, API key, and some storage SAS token scenarios. Prefer managed identity where supported, and configure credentials and their lifecycle explicitly where another method is necessary. The presence of a hub doesn't require all connections or applications to use managed identity.

For networking, configure the hub's managed network isolation mode and required outbound connections for supported compute. Separately configure private connectivity and public access restrictions for the target services. For example, your Azure OpenAI resource needs its own approved private endpoint connection and appropriate DNS resolution. Private networking controls access paths. It doesn't determine where model inference is processed.

Azure Key Vault stores secrets and encryption keys used by the architecture. Review its permissions, networking, and logging alongside the hub configuration. A shared security design still needs service-specific checks.

## Isolate project assets within shared infrastructure

Hub-based projects organize team assets and access within shared infrastructure. Compute and quota are managed as shared capacity across the hub's projects. Dependent resources, such as Storage and Key Vault, are set up once for the hub and its associated projects. This doesn't mean every project receives a dedicated storage account or its own complete set of service connections.

Project isolation includes project GUID-prefixed storage containers and project-scoped access to secrets through the supported APIs. Connections can be shared at hub scope or limited to a project. Review the scope before sharing credentials or a service connection with multiple teams.

When a new data scientist joins the fraud detection team, assign a suitable role, such as Azure AI Developer, at the intended project scope. Review inherited assignments and direct permissions on shared services as well. Project membership alone doesn't describe all access that the person might have through a subscription role, storage role, or shared connection.

Validate the design with identities representing each team. Confirm that permitted project operations succeed and that access outside the intended scope is denied. If business domains require stronger separation, assess separate hubs or resources against those requirements rather than assuming project boundaries provide dedicated infrastructure.

## More resources

- [Plan your Microsoft Foundry Hub architecture](/azure/foundry-classic/concepts/ai-resources) - Architectural guidance for hub and project design patterns
- [Manage hub connections](/azure/foundry-classic/how-to/hub-connections-add) - Connection scope and supported authentication methods
- [Review hub and project RBAC](/azure/foundry-classic/concepts/hub-rbac-foundry) - Role assignments and dependency-service permissions
- [Configure a hub managed network](/azure/foundry-classic/how-to/configure-managed-network) - Network isolation modes and outbound connections

