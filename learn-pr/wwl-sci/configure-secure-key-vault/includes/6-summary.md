The Contoso Health security audit identified three gaps that exposed patient data encryption keys to unacceptable risk. This module addressed each one with controls that a Cloud and AI Security Engineer can configure, enforce at scale, and audit continuously.

## Review configuration accomplishments

The first gap—vaults deployed without purge protection—is now addressed at the organizational level. You configured Key Vault with purge protection enabled at creation time, and backed that configuration with Azure Policy assignments. The configuration identifies noncompliant vaults across your subscription estate and can enforce a Deny effect to block new deployments that skip this control. No vault in Contoso Health's environment can be deployed without permanent deletion protection in place.

The second gap—developers holding permanent Key Vault Administrator assignments—is resolved in two layers. First, Azure RBAC is the access model, with a clear separation between control plane roles (Owner, Contributor) and data plane roles (Key Vault Administrator, Secrets User). Access policies remain supported but are the legacy option; RBAC is now the default for new vaults from API version 2026-02-01 onward. Second, the administrator assignments are now eligible roles managed through Privileged Identity Management. Activation requires justification, an approver's decision, and MFA reverification, bounded to a configurable time window. For AI agents and service principals that can't hold eligible assignments, time-limited active assignments with start and end dates provide a comparable control. Every elevation event produces an audit trail that your security operations team can review.

The third gap—vaults reachable from any public IP—is addressed through a layered set of network controls. IP-based firewall rules provide a transitional hardening option for bounded use cases. Virtual network service endpoints route traffic from Azure-hosted workloads over the Azure backbone, eliminating internet routing while the public endpoint persists. Private endpoints provide full isolation: Key Vault receives a private IP, public network access is disabled, and the only path into the vault is through your virtual network or connected on-premises networks. For organizations managing isolation across multiple PaaS resources, Network Security Perimeter provides a logical perimeter boundary outside the virtual network model. For AI agents, the right model depends on where the agent runs—VNet-hosted agents follow the same workload patterns, while Copilot Studio agents have two supported paths: Power Platform Virtual Network support with a private link, or environment variable secret references that don't require a direct network path to Key Vault at all.

In this module, you learned to:

- Deployed Azure Key Vault with security controls—soft delete, purge protection, and SKU selection—enforced at creation time
- Configured RBAC-based access control, managed identity authentication, and just-in-time privilege activation using Privileged Identity Management
- Secured Key Vault network access using firewall rules, virtual network service endpoints, and private endpoints
- Choose the right network isolation model for your architecture and evaluated the security trade-offs of each option

## What's next

These controls secure the vault as infrastructure. With the vault hardened, your focus shifts to actively managing what lives inside it—the keys, secrets, and certificates that applications and services depend on. That means understanding lifecycle management, rotation policies, and how to detect and respond to anomalous access patterns in Key Vault audit logs.

> [!TIP]
> To explore Key Vault security best practices across keys, secrets, and certificates, see [Secure your Azure Key Vault](/azure/key-vault/general/secure-key-vault).
