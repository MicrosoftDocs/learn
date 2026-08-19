## Foundry resource hierarchy

When your organization deploys AI at scale, you need infrastructure that balances centralized governance with team autonomy. Microsoft Foundry uses a top-level Foundry resource as the governance boundary and child projects as development boundaries.

At the resource level, administrators configure networking, security, model deployments, and connections. Projects organize files, agents, evaluations, and related assets for individual use cases. You can scope role assignments at the resource or project level to separate platform administration from development work.

For example, the Support Team's chatbot project and the Sales Team's forecasting project can exist under one Foundry resource. The teams work with separate project assets while administrators manage common resource-level controls. Some project settings, including role assignments and managed identities, can also be configured independently when a use case requires a narrower boundary.

## Connected resources and the sharing model

Connected Azure services, such as Azure Storage, Key Vault, and Azure AI Search, are separate Azure resources with their own governance boundaries. Manage networking, access policies, and compliance settings on each connected resource. A Foundry connection records how a project reaches an external resource, but it doesn't replace the target resource's authorization controls.

Multiple projects can connect to the same Azure AI Search service when sharing it meets your security, capacity, and cost-allocation requirements. Separate indexes can organize distinct data domains, but index separation alone isn't an authorization boundary. Use Azure role-based access control (RBAC), managed identities, network controls, and query-time security filters to enforce access.

Use dedicated connected resources when compliance, performance, data residency, or cost allocation requirements demand separation. Evaluate these requirements before deciding whether projects should share an Azure service.

## Identity, networking, and policy inheritance

Foundry supports managed identities at resource and project scopes. A managed identity can authenticate to an external service without storing credentials in application code. Authentication doesn't grant authorization automatically: an administrator must assign the identity the roles required on each target Azure resource.

Configure private networking on the Foundry resource when your organization requires network isolation. Connected services retain separate network boundaries, so configure their firewalls, private endpoints, and DNS paths as part of the end-to-end design.

Apply Azure Policy at a management group, subscription, or resource group scope that contains the governed resources. The effect depends on each policy definition and the resource types in scope. Verify policy applicability instead of assuming that a project automatically transfers requirements to separately connected services.

## Practical organizational patterns

As your organization scales, align Foundry resource boundaries with requirements that need independent governance, such as environment, region, network isolation, or compliance scope. For example, separate development and production resources can use different network and access configurations. Use projects within each resource to organize application use cases.

Now that you understand how Foundry resources, projects, and connected Azure services interact, you're ready to plan the resource and project structure for your organization.


## More resources

- [Microsoft Foundry architecture](/azure/foundry/concepts/architecture)
- [Managed identities for Azure resources](/entra/identity/managed-identities-azure-resources/overview)


