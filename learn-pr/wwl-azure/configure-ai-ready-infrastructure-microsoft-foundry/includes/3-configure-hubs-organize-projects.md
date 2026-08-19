## Foundry resource provisioning decisions

Before you create a Foundry resource, consider the region, resource group, and network boundary. Choose a supported region that meets workload and data-residency requirements. Separate development and production resources when they require different governance or lifecycle controls.

Networking carries significant security implications. Public access can simplify development, while production workloads might require a managed virtual network or private endpoints. Plan DNS and connectivity for the Foundry resource and for each connected Azure service. A private Foundry endpoint doesn't automatically make a connected search or storage service private.

Enable a managed identity at the scope that performs the workload operation. You can use a Foundry resource identity for resource-level automation and a project identity for project workloads. Assign the selected identity only the permissions it needs on connected resources.

## Role-based access control configuration

Assign Azure RBAC roles to control who can create resources and projects, manage access, and develop AI applications. Use **Foundry Account Owner** or **Foundry Owner** for users who must create Foundry resources and projects. Assign **Foundry User** to developers who need the minimum permissions to build and test applications in an existing project. Use **Foundry Project Manager** when a project lead must manage development work and assign the Foundry User role within the documented limits.

Assign roles to Microsoft Entra security groups where possible so membership changes don't require individual role assignments. If compliance personnel need control-plane visibility without modification permissions, consider the Azure **Reader** role at the appropriate scope. Reader doesn't grant Foundry data-plane access.

If the built-in roles don't meet a specialized requirement, create a custom role from documented `Microsoft.CognitiveServices` control-plane actions and data actions. Validate every operation against the current resource provider operations before you deploy the role. Only an identity with permission to create custom roles, such as **Owner** at the applicable scope, can create one.

## Project creation and organization patterns

Organize projects to reflect how teams work. A project can represent an AI application or use case: the Customer Support Bot project contains its agents, files, and evaluations, while the Fraud Detection project contains a separate set of project assets. This mapping creates clear ownership and project-level access boundaries.

Projects are child resources of a Foundry resource and reuse resource-level model deployments and connections. Projects can also have scoped role assignments and managed identities. Treat external Azure services as separate governance boundaries and configure their access explicitly.

For cost allocation or lifecycle reporting, apply your organization's required tags when you deploy Azure resources. If the Foundry portal's basic project workflow doesn't expose the required resource names, security controls, or tags, use the Azure portal or an infrastructure template. Test Azure Policy definitions against the `Microsoft.CognitiveServices/accounts` and `Microsoft.CognitiveServices/accounts/projects` resource types before enforcement.

## Governance at scale through Azure Policy

Use Azure Policy at a management group, subscription, or resource group scope to govern supported Foundry resource types. Common controls include allowed regions, public network access, and diagnostic settings. Review each policy definition's supported resource types and effects before assignment.

Connected services such as Azure AI Search and Storage are independent resources. Include them in the appropriate policy scope and configure their network and compliance settings separately. A policy assigned to the Foundry resource doesn't automatically govern a connected resource outside that assignment scope.

Combine Azure Policy with RBAC, managed identities, private networking, and diagnostic settings. These controls operate at different scopes, so validate the complete architecture rather than relying on implicit inheritance.

## More resources

- [Microsoft Foundry architecture](/azure/foundry/concepts/architecture)
- [Role-based access control for Microsoft Foundry](/azure/foundry/concepts/rbac-foundry)
- [Configure a private link for Microsoft Foundry](/azure/foundry/how-to/configure-private-link)

