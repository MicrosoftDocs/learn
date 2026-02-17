When your data scientist tries to launch a Jupyter notebook in Azure Machine Learning, Azure immediately asks: *Who is making this request?* The answer comes from Microsoft Entra ID security principals—the identities that represent users, applications, and services accessing your AI resources. Without properly configured principals, your team faces a dilemma: either grant overly broad permissions that expose sensitive data, or create so many individual access rules that administration becomes unmanageable.

Microsoft Entra ID provides four principal types, each designed for specific access patterns. Users represent individual people like your data scientists who need interactive access during model development. Groups simplify management by letting you assign permissions to entire teams—when you add a new data scientist to the "Customer Analytics" group, they automatically inherit access to the project's ML workspace and training data. Service principals authenticate applications and automation scripts, making them essential for CI/CD pipelines that deploy models without human intervention. Managed identities eliminate credential management entirely by providing Azure resources with automatically managed identities—your ML workspace can access storage accounts without storing any passwords or connection strings.

:::image type="content" source="../media/provide-four-principal-types.png" alt-text="Diagram showing how Microsoft Entra ID provides four principal types, each designed for specific access patterns.":::


With this foundation in place, consider how these principals map to your team's daily tasks. Your data scientists need Contributor access to ML workspaces for experimentation, but only Reader access to production resources for monitoring. Your deployment pipeline requires a service principal with specific permissions to register models and update endpoints, but shouldn't be able to delete workspaces or modify access controls. This principle of least privilege—granting only the minimum permissions required for each task—becomes your primary defense against both accidental misconfiguration and intentional misuse.

## Choosing the right principal for AI scenarios

The distinction between principal types becomes critical during production deployment. Suppose your sentiment analysis model needs to read customer reviews from an Azure Storage account during inference. You could create a service principal, generate a client secret, store that secret in your application code, and implement rotation logic to update the secret before it expires. This approach works but introduces risk: developers might accidentally commit secrets to source control, rotation scripts might fail, and you must audit every location where the secret is stored.

Managed identities solve these problems by eliminating secrets entirely. When you enable a system-assigned managed identity on your Azure Machine Learning workspace, Azure automatically creates an identity tied to lifecycle. You then grant this managed identity the "Storage Blob Data Reader" role on your storage account. Now your workspace can authenticate to storage using its managed identity—no secrets, no rotation, and automatic cleanup when you delete the workspace. Microsoft Entra ID handles token acquisition and renewal behind the scenes. For production AI workloads, this pattern reduces security risk by 40-60% compared to manually managed credentials, according to Microsoft's internal deployment telemetry.

:::image type="content" source="../media/workspace-azure-automatically-creates-identity.png" alt-text="Diagram showing how Azure automatically creates an identity tied to a workspace's lifecycle.":::

Building on this concept, user-assigned managed identities extend this pattern to scenarios where multiple resources need the same identity. If your AI platform includes five ML workspaces that all need identical storage access, you create one user-assigned managed identity, grant it the necessary permissions, and then assign that same identity to all five workspaces. This approach simplifies permission management and enables identity reuse across environments. As you scale from a single AI project to an enterprise platform, this architectural choice becomes essential for maintaining operational efficiency.

## Implementing role assignments for AI resources

Now that you understand which principals to use, let's examine how to grant them appropriate permissions. Azure uses role-based access control (RBAC) to define what actions each principal can perform. Built-in roles like Contributor, Reader, and Owner provide broad permission sets, but AI workloads often require more specific control. The "Azure Machine Learning Data Scientist" role grants permissions to create experiments and register models while preventing deletion of workspaces or modification of compute resources—exactly what your team needs during the experimentation phase.

Role assignments combine three elements: a security principal (*who*), a role definition (*what actions*), and a scope (*where*). When you assign the Data Scientist role to your team's group at the resource group scope, every member can work with any ML workspace in that resource group but can't access resources in other groups. This scoping mechanism becomes your primary tool for environment isolation. Production workspaces live in one resource group with restricted access, while development workspaces live in another with broader permissions. As you see later when we explore governance scopes, this hierarchy enables policy inheritance and simplifies compliance auditing.

At the same time, you must consider service-to-service authentication patterns. Your ML workspace needs to pull container images from Azure Container Registry, write metrics to Azure Monitor, and access training data in storage accounts. Rather than granting your data scientists permissions to all these backend services, you grant the workspace's managed identity specific roles on each dependency. The workspace uses its managed identity for backend operations, while your team members use their user identities for interactive access. This separation of concerns—human identities for interactive work, managed identities for automated operations—represents the security pattern recommended by Microsoft's Azure Security Benchmark.

:::image type="content" source="../media/workspace-needs-pull-container-images.png" alt-text="Diagram showing a workspace that needs to pull container images from Azure Container Registry.":::

## Best practices for principal management

For example, suppose your organization mandates that all service principals rotate credentials every 90 days. You've configured your deployment pipeline with a service principal that automates model registration, but the secret expired overnight and now your production deployment is blocked. Had you used a managed identity for the deployment automation, this incident would never occur—managed identities handle token lifecycle automatically. This scenario illustrates why Microsoft's AI deployment guidance prioritizes managed identities over service principals whenever Azure-to-Azure authentication is required.

However, this changes when you integrate with third-party systems outside Azure. If your model training pipeline pulls data from an on-premises SQL Server or pushes notifications to a Slack channel, you need service principals because these external systems can't authenticate against managed identities. In these cases, store service principal secrets in Azure Key Vault and grant your ML workspace's managed identity permission to retrieve those secrets. This pattern—managed identities for Azure resources, service principals for external integration, secrets centralized in Key Vault—provides defense in depth across your AI infrastructure.

Building on this foundation, regular access reviews ensure your permissions remain aligned with actual job responsibilities. When a data scientist moves from the experimentation team to the production support team, their group membership should change to reflect their new role. When a project completes and the workspace is decommissioned, remove the associated group assignments rather than leaving orphaned permissions. Microsoft Entra ID's access reviews feature automates this governance by requiring group owners to periodically certify that each member still requires access. This becomes especially important when your AI platform scales to dozens of workspaces supporting hundreds of users—manual permission audits become infeasible without automated workflows.

:::image type="content" source="../media/security-principal-types.png" alt-text="Diagram showing Microsoft Entra ID security principal types and their relationship to Azure AI resources.":::

*Microsoft Entra ID security principal types and their relationship to Azure AI resources*


## More resources

- [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) - Comprehensive guide to managed identity types, configuration, and authentication flows
- [Azure built-in roles for Machine Learning](/azure/machine-learning/how-to-assign-roles) - Reference documentation for AI-specific RBAC roles and permission mappings


