As organizations expand their use of AI, different teams often share the same Azure AI Foundry environment. Developers build and deploy models, data scientists manage datasets, and operations teams configure guardrails and integrations. Without clear access boundaries, a single overly broad role can expose data, alter configurations, or disrupt production workloads.

**Microsoft Entra ID** provides the foundation for identity and access across Azure AI Foundry. It lets you assign permissions through **role-based access control (RBAC)** and enforce **least-privilege principles** so people only have access to what they need. Foundry adds a second access layer inside each project with its own user roles, giving you more precision over who can work in a specific AI environment.

Together, these layers create a structured model that protects both the Azure infrastructure and the AI workspace that runs on top of it.

## Apply RBAC and least privilege in Microsoft Entra ID

Access to Azure AI Foundry begins at the Azure resource layer. Each Foundry workspace is an Azure resource that inherits permissions from **Microsoft Entra ID** through **role-based access control (RBAC)**. These assignments define who can create, configure, or delete Foundry workspaces and manage the Azure services that support them, like **Storage**, **Key Vault**, and **managed networks**.

RBAC permissions can be assigned at different scopes, including subscription, resource group, or resource level. The best practice is to assign roles at the **Foundry resource level** whenever possible. Assigning at higher scopes, like subscription or resource group, automatically includes other resources that might not need the same level of access. Keeping assignments focused limits the potential impact of misconfiguration or misuse.

Assign roles carefully and at the smallest scope that fits operational needs:

- **Owner**: full control of the Foundry resource, including user access and role assignments.
- **Contributor**: can create and manage workspaces, connect resources, and deploy models, but can't grant access.
- **Reader**: can view project details, dashboards, and configurations without making changes.
- **Custom roles**: useful when specific operations like linking managed identities or enabling diagnostic settings need to be delegated without broader permissions.

Because Azure AI Foundry is a multi-resource environment, users might also need access to dependent components. For example, someone deploying a model might require Contributor rights for both the Foundry workspace and the resource group that hosts associated compute and storage assets. Keep these assignments aligned and minimal to maintain least privilege.

For automation, use **managed identities** or **service principals** for pipelines and deployment processes instead of personal accounts. This keeps operations auditable and avoids permissions lingering after personnel changes.

To reduce standing administrative access:

- Use **Privileged Identity Management (PIM)** for temporary elevation during workspace setup or configuration.
- Apply **Conditional Access** policies to require multifactor authentication and compliant devices for privileged users.
- Schedule **access reviews** to confirm that permissions remain accurate as teams or projects evolve.

These practices secure the Azure layer that hosts Azure AI Foundry and create a strong foundation for managing access inside the Foundry portal itself.

For detailed steps on assigning Azure RBAC roles, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal?azure-portal=true).

By defining clear roles and scopes through Microsoft Entra ID, you ensure that only authorized users can manage or modify your Azure AI Foundry environment. Once this foundation is in place, you can focus on managing access within Foundry itself to control who can work inside each project.
