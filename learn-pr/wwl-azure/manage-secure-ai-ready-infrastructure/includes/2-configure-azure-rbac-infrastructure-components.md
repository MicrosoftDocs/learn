When Contoso's development team first deployed their AI agents, they granted every service account Contributor permissions at the subscription level. This approach delivered fast deployment velocity during the prototype phase, but it also gave agents the ability to delete production databases, modify network security rules, and access resources across unrelated projects. Security audits revealed that over-privileged access increased the blast radius of potential breaches by 300%, turning what should have been isolated incidents into organization-wide security events.

Azure Role-Based Access Control (RBAC) solves this problem by letting you assign permissions at precisely the scope required for each job task. With RBAC, you define who can access which resources and what actions they can perform, enforcing the principle of least privilege across your entire infrastructure. The system uses a hierarchy of scopes—subscription, resource group, and individual resource—where permissions assigned at a higher level automatically inherit to child resources. For example, granting Reader access at the resource group level means that identity can view all resources within that group without requiring separate assignments for each database, storage account, or virtual machine.

Building on this hierarchical model, Azure provides built-in roles tailored to common job functions. The Contributor role grants full management permissions for resources within a scope but prevents the assignment of roles to other users—ideal for DevOps engineers who deploy and configure infrastructure but don't manage access policies. In contrast, the Cosmos DB Data Contributor role allows reading and writing data within Cosmos DB containers without granting permissions to modify the database account configuration, networking rules, or billing settings. This separation becomes critical when your AI agents need to persist conversation logs but shouldn't have the ability to delete entire databases or change throughput settings.

:::image type="content" source="../media/hierarchical-model-azure-built-in-roles.png" alt-text="Diagram showing how hierarchical models provide built-in roles tailored to common job functions.":::

At the same time, operations teams need visibility into resource configurations without the risk of accidental modifications. The Reader role provides read-only access across all resource types, enabling security auditors to review configurations, developers to troubleshoot issues by inspecting resource properties, and compliance teams to validate policy adherence. With Reader permissions scoped to specific resource groups, you create safe audit trails without exposing production environments to unauthorized changes.

Consider what happens when you assign roles to managed identities representing AI agent applications. You navigate to the Access Control (IAM) blade of your Cosmos DB account, select **Add role assignment**, choose Cosmos DB Data Contributor from the Role tab, then specify the agent's system-assigned managed identity as the assignee on the Members tab. After confirming the assignment, the agent can immediately write conversation documents and query session history without storing any credentials in configuration files. This pattern eliminates the risk of leaked connection strings—a vulnerability responsible for 40% of cloud data breaches according to Microsoft security telemetry.

:::image type="content" source="../media/pattern-eliminates-risk-leaked-connection-string.png" alt-text="Diagram showing how a pattern can eliminate the risk of leaked connection strings.":::

This becomes especially important when you operate across multiple environments. Traditional approaches require duplicating service accounts and rotating credentials separately in development, staging, and production environments. With RBAC and managed identities, you define role assignments once per environment using infrastructure-as-code templates, and Azure handles credential lifecycle automatically. Your operations team reduces permission management overhead by 70% while simultaneously improving security posture.

Now that you understand how RBAC enforces least-privilege access through built-in roles and scope hierarchy, let's explore how managed identities eliminate the need for credential storage entirely. The next unit demonstrates enabling managed identities on Azure App Service and configuring the token acquisition flow that powers keyless authentication.

:::image type="content" source="../media/role-assignment-subscription-resource-group.png" alt-text="Diagram showing how role assignments across subscription, resource group, and resources scopes.":::


*Azure RBAC role assignments across subscription, resource group, and resource scopes for Contoso's AI agent infrastructure*

## More resources

- [Azure built-in roles](/azure/role-based-access-control/built-in-roles) - Complete reference of all Azure built-in roles with detailed permission lists and scope recommendations
- [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal) - Step-by-step guide for assigning roles through the Access Control (IAM) blade with screenshots
- [Best practices for Azure RBAC](/azure/role-based-access-control/best-practices) - Recommendations for scope selection, custom role creation, and audit logging strategies


