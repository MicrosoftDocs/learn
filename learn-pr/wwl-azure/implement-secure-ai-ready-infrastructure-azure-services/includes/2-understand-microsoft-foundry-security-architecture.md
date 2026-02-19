
## The centralized governance challenge

You might be wondering how to enforce consistent security policies across multiple AI development teams without slowing down innovation. Traditional approaches create isolated environments for each team, forcing security administrators to configure network rules, identity permissions, and encryption settings repeatedly. With five AI projects underway, your security team faces configuring private endpoints, managed identities, and audit logging five separate times—multiplying administrative overhead and increasing the risk of configuration drift.

Microsoft Foundry Hubs solve this challenge by providing centralized security governance that applies automatically to all connected projects. A Foundry Hub acts as the policy enforcement layer where you configure network isolation, identity controls, and data protection once. Every Foundry Project that connects to the hub inherits these security controls, ensuring consistency without requiring per-project configuration. This separation allows your security team to maintain governance while data science teams retain autonomy within their project workspaces.

## How Hubs and Projects work together

Consider a scenario where your fraud detection team and customer service automation team both need access to Azure OpenAI Service. With traditional Azure resource groups, each team would create separate OpenAI instances, configure their own virtual networks, and manage independent sets of managed identities. This creates security islands where one team might enable public access while another enforces private endpoints—introducing compliance gaps your auditor's flag.

:::image type="content" source="../media/manage-independent-sets-managed-identities.png" alt-text="Diagram showing traditional Azure resource groups where each team creates separate OpenAI instances.":::

Foundry changes this architecture fundamentally. You create one Foundry Hub that defines your organization's security baseline: private endpoint connectivity required, managed identity authentication mandatory, and diagnostic logging enabled for all resources. When the fraud detection team creates their Foundry Project, it automatically inherits the hub's networking configuration—their Azure OpenAI Service endpoint is private by default. The customer service team's project gets identical security controls without more configurations. Both teams work independently within their project boundaries while the hub ensures security consistency.

This becomes especially important when your security team needs to respond to new compliance requirements. Instead of updating five separate environments, you modify the hub's policy once. All connected projects inherit the change immediately, reducing your compliance window from weeks to hours and eliminating the risk of overlooking an environment during updates.

## Core security components

The hub integrates three foundational security services that protect your AI workloads. Microsoft Entra ID provides identity and access management through role-based access control (RBAC), allowing you to define who can create projects, deploy models, and access training data. Unlike service-specific authentication, Microsoft Entra ID centralizes identity management—your existing user groups and conditional access policies apply automatically to AI resources. At the same time, managed identities eliminate credential storage by allowing applications and services to authenticate directly using Microsoft Entra ID tokens, removing API keys from your codebase entirely.

Azure Virtual Network delivers network isolation by creating private connectivity between your hub and Azure services. When you deploy a private endpoint for Azure OpenAI Service, all API traffic flows through your virtual network rather than the public internet. This network boundary prevents external access attempts and ensures compliance with data residency requirements. For example, your fraud detection models processing customer transactions stay within EU Azure regions, satisfying data localization mandates.

Azure Key Vault completes the protection layer by securing secrets, certificates, and encryption keys. Even when services require API keys for backward compatibility, Key Vault stores them with access logging and automatic rotation. Your applications reference keys using Key Vault URIs rather than embedding credentials in configuration files. With this approach, your security team gains audit trails showing when keys were accessed, by which identity, and from which application—visibility that's critical during security investigations.

## Policy inheritance and workspace isolation

Now that you understand the hub's role, let's examine how projects maintain both security consistency and team autonomy. Each Foundry Project operates as an isolated workspace with dedicated compute resources, storage accounts, and AI service connections. Data scientists in the fraud detection project can't access datasets or models in the customer service project—even though both projects connect to the same hub. This isolation prevents accidental data leakage between business domains while simplifying access control through project-level RBAC assignments.

Building on this concept, policy inheritance works like a security firewall with mandatory baseline rules. The hub enforces non-negotiable requirements—private endpoints, managed identities, encryption at rest—that projects can't disable. Within these boundaries, project administrators customize permissions for their team members and configure project-specific resources like storage containers or compute clusters. For instance, the fraud detection project might grant senior data scientists permission to deploy production models while restricting junior analysts to development experiments. These project-level permissions add flexibility without compromising hub-enforced security controls.

Consider what happens when a new data scientist joins your fraud detection team. The project administrator assigns them the "Data Scientist" role within the Foundry Project. This role inherits hub-level policies automatically—they can only access AI services through private endpoints and must authenticate with their Microsoft Entra ID credentials. The project role then grants specific permissions to training datasets and development compute resources. This layered approach means your security team manages baseline controls once at the hub level, while project administrators handle day-to-day access management within their domains.

:::image type="content" source="../media/architecture-centralized-security-controls.png" alt-text="Diagram showing the Microsoft Foundry Hub architecture with centralized security controls.":::


*Microsoft Foundry Hub architecture showing centralized security controls with policy inheritance flowing to isolated project workspaces*


## More resources

- [Plan your Microsoft Foundry Hub architecture](/azure/ai-foundry/concepts/hubs-projects) - Architectural guidance for hub and project design patterns
- [Configure managed identities for Azure AI services](/azure/ai-services/authentication) - Step-by-step guide for passwordless authentication


