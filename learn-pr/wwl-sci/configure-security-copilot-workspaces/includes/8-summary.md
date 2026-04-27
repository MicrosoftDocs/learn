In this module, you learned how to plan, create, and configure Microsoft Security Copilot workspaces for enterprise segmentation. You explored how workspaces enable team-specific environments with dedicated capacity, data residency compliance, role-based access, and customized configurations.

You started by planning workspace deployments. You evaluated capacity models—pay-as-you-go provisioning versus Microsoft 365 E5 inclusion—and determined provisioned and overage Security Compute Unit (SCU) allocations based on usage patterns. You identified data storage and prompt evaluation location requirements to meet compliance mandates. You confirmed the Azure and Security Copilot roles needed to create and manage workspaces.

You created Security Copilot workspaces through the portal, making critical configuration decisions during the creation process. You named workspaces following Azure resource conventions, and associated existing or newly created capacity resources. Then you selected immutable data storage locations for regulatory compliance. Finally, you configured prompt evaluation regions for performance optimization, and set data sharing preferences aligned with organizational policies.

You configured workspace access by assigning Owner and Contributor roles to users, groups, Microsoft Entra roles, or managed identities. You learned that workspace roles apply specifically to individual workspaces, enabling delegated administration without tenant-wide privileges. You configured workspace-level owner settings—capacity management, data sharing, file upload permissions—and enabled workspace-specific plugins to tailor Security Copilot capabilities to team needs.

You assigned integrated Microsoft Security Copilot agents from products like Defender XDR, Purview, Intune, and Microsoft Entra to specific workspaces. You understood that agent workspace assignment is a tenant-wide setting that routes all agent traffic from a product to the designated workspace. You ensured users have appropriate workspace access to avoid errors when invoking agents from embedded experiences. You understood that agent workspace assignments are tenant-wide settings, routing all embedded experience traffic to the designated workspace.

You monitored and managed workspace capacity through usage dashboards displaying SCU consumption, prompt volumes, and utilization trends. You adjusted provisioned and overage SCU allocations based on observed patterns, recognizing that capacity changes take up to 30 minutes to take effect. You understood when to increase capacity for sustained high utilization, convert overage to provisioned units for cost optimization, and decrease capacity for underutilized workspaces.

## Contoso's outcome

By implementing workspace segmentation, Contoso achieved its organizational goals:

The **SOC workspace** provides the SOC team with dedicated high capacity, US data storage, and Defender XDR agent routing. SOC analysts investigate threats efficiently without capacity constraints or compliance concerns.

The **compliance workspace** ensures EU data residency for all prompts and session data, meeting regulatory requirements. The Purview agent routes to this workspace, enabling compliance officers to monitor data governance while maintaining geographic compliance.

The **sandbox workspace** offers the security architecture team an isolated environment to test custom plugins and promptbooks before production deployment. Low capacity allocation minimizes costs while supporting experimentation.

Workspace-specific ownership enables delegation. The SOC Director, Compliance Manager, and Security Architect independently configure their workspaces without requiring tenant-wide administrative roles or coordinating changes across teams.

## Next steps

To deepen your Security Copilot expertise, consider exploring:

- **[Build your own promptbooks](/copilot/security/build-promptbooks)** - Create custom multi-step workflows to automate investigation and response procedures within your workspaces.
- **[Understand authentication in Microsoft Security Copilot](/copilot/security/authentication)** - Explore Security Copilot roles, Microsoft Entra roles, and Azure RBAC in depth.

## Learn more

- [Manage workspaces](/copilot/security/manage-workspaces)
- [Workspaces overview](/copilot/security/workspaces-overview)
- [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)
- [Manage usage of security compute units](/copilot/security/manage-usage)
- [Configure Copilot settings with the owner role](/copilot/security/owner-settings)
