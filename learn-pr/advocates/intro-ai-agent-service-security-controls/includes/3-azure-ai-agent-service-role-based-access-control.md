Azure role-based access control (Azure RBAC) manages access to Azure resources. In Foundry Agent Service, you use Microsoft Entra ID and Azure RBAC to control who can administer a Foundry resource, manage Foundry projects, build agents, publish agents, and access connected resources.

RBAC only restricts access when the caller authenticates with Microsoft Entra ID. API keys bypass role restrictions because possession of the key grants access. Prefer Microsoft Entra ID authentication and RBAC, and avoid keys where possible.

The following Foundry roles are the current built-in roles to use with Foundry Agent Service.

> [!IMPORTANT]
> Foundry RBAC roles were recently renamed. **Foundry User** was formerly **Azure AI User**, **Foundry Owner** was formerly **Azure AI Owner**, **Foundry Account Owner** was formerly **Azure AI Account Owner**, and **Foundry Project Manager** was formerly **Azure AI Project Manager**. You might see older names during rollout, but the role definition IDs and core permissions are unchanged. Use role definition IDs in automation: Foundry User `53ca6127-db72-4b80-b1b0-d745d6d5456d`, Foundry Owner `c883944f-8b7b-4483-af10-35834be79c4a`, Foundry Account Owner `e47c6f54-e4a2-4754-9501-8e0985b135e1`, and Foundry Project Manager `eadc314b-1a2d-4efa-be10-5d325db5065e`.

| **Role** | **Typical scope** | **Use** |
|---|---|---|
| **Foundry User** | Foundry resource or Foundry project | Least-privilege role for building and developing in a project. Assign this role to users who build agents and to the project's managed identity on the Foundry resource. |
| **Foundry Project Manager** | Foundry resource | Manage projects, build and develop in projects, publish agents, and conditionally assign the Foundry User role to other users. |
| **Foundry Account Owner** | Foundry resource | Manage Foundry resources, projects, models, and selected role assignments. Use for platform owners who need resource-level administration but don't necessarily need project data actions. |
| **Foundry Owner** | Foundry resource | Full Foundry administration and project development permissions, including publishing agents and selected role assignments. Use sparingly because it's highly privileged. |

Don't use classic or hub-focused roles such as Azure AI Administrator, Azure AI Developer, or Azure AI Inference Deployment Operator for current Foundry projects or hosted agents. Despite its name, Azure AI Developer applies to Azure Machine Learning workspaces and Foundry hubs, not to current Foundry projects or Foundry hosted agents.

The following table shows a sample enterprise persona mapping.

| **Persona** | **Role assignment** | **Purpose** |
|---|---|---|
| **IT admin** | Azure Owner at the subscription scope for broad Foundry resource governance; or, for separated duties, Contributor at the subscription or resource group scope for resource creation and configuration plus Owner, Role Based Access Control Administrator, or User Access Administrator only where role assignment is required; Foundry Owner only when needed | Establish enterprise standards, create or govern Foundry resources, configure security settings, and delegate Foundry access without overgranting broad permissions to every admin. |
| **Platform or AI manager** | Foundry Account Owner or Foundry Project Manager on the Foundry resource | Manage projects, models, shared connections, and project access without granting broad Azure subscription permissions. |
| **Team lead or lead developer** | Foundry Project Manager on the Foundry resource | Create and manage projects, publish agents, and invite team members by assigning Foundry User. |
| **Team member or developer** | Foundry User on the Foundry project, plus Reader on the Foundry resource if needed | Build and test agents in an assigned project with least-privilege access. |
| **Project runtime identity** | Foundry User for the project's managed identity on the Foundry resource | Allows the project identity used by Foundry Agent Service to access required Foundry features without using a human account. |

For IT administrators, don't treat **User Access Administrator** or **Role Based Access Control Administrator** as replacements for Azure **Owner** or **Contributor** when the task includes creating Foundry resources or configuring resource settings. Those access-administration roles are appropriate when the admin only needs to create, remove, or delegate Azure RBAC role assignments. If duties are separated, grant **Contributor** for resource creation and configuration, and grant **Owner**, **Role Based Access Control Administrator**, or **User Access Administrator** only to the principal that must manage role assignments at the required scope.

You can manage role assignments from the Foundry portal Admin page or from the Azure portal by using **Access control (IAM)**. Assign roles at the smallest scope that supports the task, such as a specific Foundry project for developers and the Foundry resource for project managers or runtime identities.

> [!IMPORTANT]
> Hosted agents have additional identity requirements. The agent **creator** needs **Foundry Project Manager** at the Foundry project scope to create the Hosted agent and assign **Foundry User** to the agent identity (the dedicated Microsoft Entra ID that Foundry creates for the Hosted agent at deploy time). To **publish agents** or **deploy agent applications**, the same role is required at the **Foundry resource (account) scope** instead. That agent identity needs **Foundry User** on the project for runtime model and artifact access. The project managed identity also needs Azure Container Registry pull permissions, such as **Container Registry Repository Reader** or **AcrPull**, on the registry that stores the Hosted agent image. Don't treat the project managed identity's **Foundry User** role on the Foundry resource as sufficient for Hosted agent deployment, runtime access, or image pulls.

## Managed identities, agent identities, and user delegation

A managed identity is a service principal that represents an Azure resource or project. For current Foundry projects, assign the project's managed identity the **Foundry User** role on the Foundry resource. This baseline assignment lets the project access required Foundry features, but it doesn't mean the project managed identity is the right principal for every tool or runtime path. This replaces older hub guidance that referenced a default Azure AI Administrator assignment.

Managed identity access is different from OAuth On-Behalf-Of (OBO) identity passthrough:

- **Managed identity or agent identity access** uses a nonhuman identity. The downstream resource authorizes the identity by checking its RBAC roles or other application permissions.
- **OAuth/OBO passthrough** uses the signed-in user's delegated permissions. The agent can only access resources that the user is authorized and consented to access.

When an agent or tool connects to an external data source, identify which principal the connection uses and grant that principal only the data-source roles it needs:

- **Project managed identity**: Use when project setup, BYO resources, or a tool connection explicitly authenticates with the project managed identity. The Azure AI Search tool with a private virtual network requires keyless Microsoft Entra authentication with this identity.
- **Shared project agent identity**: Use for unpublished or in-development agents that share the project's agent identity.
- **Distinct published agent identity**: Use for published agents and agent applications. Publishing creates a distinct identity, so reassign any Azure RBAC or downstream permissions that the unpublished agent used.
- **OBO user identity**: Use when a tool relies on OAuth On-Behalf-Of passthrough. The downstream service authorizes the signed-in user's delegated permissions, not the project or agent identity alone.

Common data-source role assignments include:

| **Data source** | **Least-privilege role guidance** |
|---|---|
| **Azure Blob Storage** | Assign **Storage Blob Data Reader** to the identity that only needs to read or list blobs. Use a write-capable role only when the agent must create or update blobs. |
| **Azure AI Search** | Distinguish generic search clients from Foundry tool setup. For a generic query-only app or process, enable RBAC and assign **Search Index Data Reader** for search and retrieval. For the Foundry Azure AI Search tool with keyless authentication when the service must create or manage indexes (Standard and private-network setups), Foundry templates assign the project's managed identity **Search Index Data Contributor** and **Search Service Contributor** on the search service. If a managed identity only needs to query a pre-existing index, **Search Index Data Reader** alone is sufficient and least-privilege. Scope these roles narrowly and don't grant contributor roles to unrelated query-only callers. |

Avoid assigning broad Azure roles, such as Owner or Contributor, to agent or project identities for data access. These roles can expose administrative actions or keys that are unnecessary for normal agent operation. RBAC doesn't grant network reachability, so configure private networking, firewalls, and endpoints separately when connected resources aren't publicly reachable.

Private networking doesn't replace identity permissions. All Standard setups require BYO Azure Storage, Azure AI Search, and Azure Cosmos DB resources so agent data stays in your Azure tenant. When you combine Standard Setup with private networking, private endpoints for those BYO resources aren't auto-created and must be configured separately. Basic setup can use inbound private access, but outbound private network isolation for agent traffic requires Standard Setup with private networking. For Azure AI Search over a private virtual network, use keyless Microsoft Entra authentication with the project managed identity; key-based authentication isn't supported for that connection path.

