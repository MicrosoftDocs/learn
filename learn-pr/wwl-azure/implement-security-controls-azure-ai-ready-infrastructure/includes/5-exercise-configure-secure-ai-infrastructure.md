Learners can find the full list of labs and launch each exercise directly by visiting the [Secure AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2349700) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.

## Exercise 1: Configure authorization for Microsoft Foundry project

Access management for cloud resources is a critical function for any organization that's using the cloud. Azure role-based access control (Azure RBAC) helps manage who has access to Azure resources, what they can do with those resources, and what areas they have access to. Azure RBAC is an authorization system built on Azure Resource Manager that provides fine-grained access management to Azure resources.

The way access is controlled is through role assignments, which define how permissions are enforced. A role assignment consists of three elements: security principal, role definition, and scope.
- Security principal: An object that represents a user, group, service principal, or managed identity requesting access to Azure resources. 
- Role definition: A collection of permissions (or "role") that defines which actions can be performed, such as read, write, or delete. Azure includes many built-in roles. You can also create custom roles tailored to your specific needs.
- Scope: The set of resources that the access applies to. Roles can be assigned at the management group, subscription, resource group, or resource level. Scopes from a hierarchy, and permissions assigned at a higher scope automatically apply to all lower scopes.


### Scenario
Your company is a global financial analytics firm that develops AI-driven models to assess credit risk, detect fraud, and provide personalized financial insights for its clients. To support these workloads, the company builds a centralized AI development platform using Microsoft Foundry, enabling multiple teams to collaborate securely while maintaining strict access boundaries between projects.

To maintain strong governance and data protection controls, the company implements Azure role-based access control (RBAC) to manage who can view, build, or manage AI assets. By using built-in roles such as Azure AI Account Owner, Azure AI Project Manager, and Azure AI User, the company is able to ensure that each team member has access appropriate to their responsibilities while adhering to the principle of least privilege. Because RBAC permissions are allow-only and cumulative, any access granted at the resource level will automatically apply to all projects created within the same Microsoft Foundry resource.

:::image type="content" source="../media/company-implements-azure-role-based.png" alt-text="Diagram showing how a company implements Azure role-based access control (RBAC) to manage who can view files.":::

Within this model, one team member serves as the Project Manager for the default project, with full management capabilities, including the ability to build and develop AI assets and manage access for other users. The same individual holds only the Azure AI User role in other projects under the same Foundry resource, allowing visibility into shared data and configurations without the ability to modify them. This separation of duties ensures clear accountability, prevent unauthorized changes, and provide a secure foundation for collaborative AI development across teams.

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2349803)

### Estimated duration
10 minutes

## Exercise 2: Enhance security of Microsoft Foundry compute resources by using Azure Policy

Azure Policy is a governance tool that allows organizations to enforce standards and ensure that Azure resources remain compliant with defined policies. It provides a framework to define rules and effects that can be applied at the subscription, resource group, or individual resource level. Policies are automatically enforced across all resources within their scope, helping maintain consistent security, operational, and compliance standards.

For Microsoft Foundry, policy definitions can be assigned to hubs and projects. Azure provides a set of built-in policies for common scenarios, which can be assigned directly or used as templates to create custom policies tailored to organizational requirements. When a policy is assigned, it's enforced across both Microsoft Foundry and Azure Machine Learning workspaces. For example, a policy applied at the subscription level that disables public network access will automatically apply to all hubs, projects, and ML workspaces under that subscription.


### Scenario
Your company, a healthcare analytics organization that develops AI-driven models for patient risk prediction, treatment optimization, and clinical decision support, plans to implement a comprehensive governance framework for its Microsoft Foundry and Azure Machine Learning environments. Given the highly sensitive nature of patient data and the strict regulatory requirements in the healthcare industry, it's critical to ensure that all compute resources remain secure, up to date, and compliant with organizational standards. By applying both built-in and custom policy definitions, the company is able to enforce operational controls tailored to the healthcare context, such as requiring compute instances to run the latest operating system updates to reduce vulnerabilities, restrict network access to virtual networks to prevent unauthorized data exposure, and disable local authentication methods in favor of Microsoft Entra ID-based access to ensure secure and auditable access. This approach reduces security risks, strengthen access controls, and maintain consistent operational standards across all AI workloads that handle sensitive patient information.

To streamline policy management and enforce consistent rules across multiple teams and projects, the company uses an initiative definition. The initiative allows the grouping of individual policies covering compute updates, network isolation, and authentication controls into a single, assignable unit. By using initiatives, the company ensures that all Microsoft Foundry hubs, projects, and Azure Machine Learning workspaces adhere to the same set of security and compliance requirements, simplifying oversight and reducing the risk of misconfigurations.

:::image type="content" source="../media/company-allows-grouping-individual-policies.png" alt-text="Diagram showing how a company allows the grouping of individual policies covering compute updates.":::

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2349804)

## Estimated duration
15 minutes