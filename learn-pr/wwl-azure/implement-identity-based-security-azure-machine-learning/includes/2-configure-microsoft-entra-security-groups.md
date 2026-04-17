When your AI team grows from five data scientists to 50, managing individual user permissions becomes unmanageable. Assigning Azure Machine Learning roles to each person separately creates administrative overhead and increases the risk of permission errors. Security groups solve this problem by letting you manage access collectively—add a user to the Data Scientists group, and they automatically inherit the appropriate workspace permissions.

## Organize teams with security groups

Microsoft Entra security groups act as containers that organize users by their job function and required access level. With Azure Machine Learning workspaces, you typically create three primary groups that mirror your team structure. The Data Scientists group contains analysts who need to view experiments and submit training jobs without modifying infrastructure. The ML Engineers group includes developers who build pipelines, manage compute resources, and deploy models to production endpoints. The AI Administrators group grants platform teams full control over workspace configuration, security settings, and cost governance. This three-tier structure aligns with the principle of least privilege—users receive exactly the permissions their role requires, nothing more.

Building on this foundation, you map each security group to an Azure Machine Learning built-in role through role-based access control (RBAC). Azure Machine Learning provides several roles optimized for data science workflows. The Reader role allows viewing experiments and models without making changes—ideal for your Data Scientists group. The Contributor role enables full development capabilities including compute management and model deployment, which matches the ML Engineers group's responsibilities. The Owner role provides complete administrative control for the AI Administrators group. With these mappings in place, adding a new data scientist to your team requires just one action: adding their user account to the appropriate security group. The RBAC assignment automatically grants workspace access within minutes.

:::image type="content" source="../media/several-roles-optimized-data-science-workflows.png" alt-text="Diagram showing how Azure Machine Learning provides several roles optimized for data science workflows.":::

## Implement dynamic membership for automation

Manual group management works for small teams but becomes error-prone as your organization scales. Dynamic membership rules automate user provisioning by evaluating attributes stored in Microsoft Entra ID. For example, you can configure a rule that automatically adds any user with the job title "Data Scientist" and department "Analytics" to your Data Scientists security group. When HR onboards a new analyst and sets these attributes, the group membership updates automatically—no IT ticket required. This approach reduces provisioning time from days to minutes while eliminating the risk of forgotten access removal when employees change roles.

Dynamic rules support complex logic using Azure's dynamic group syntax. You might create a rule that includes users from multiple departments: `(user.department -eq "Analytics") -or (user.department -eq "Research")`. You can also exclude contractors from production groups: `(user.jobTitle -contains "Data Scientist") -and (user.employeeType -ne "Contractor")`. These rules evaluate continuously, so group membership stays synchronized with your organization's HR system. However, this automation requires accurate attribute maintenance—if job titles aren't standardized, users may receive incorrect permissions. Work with your HR and identity teams to establish consistent attribute values before implementing dynamic groups.

## Design nested group hierarchies

Large organizations often need more granular access control than three groups provide. Nested groups let you create hierarchies that reflect complex team structures while maintaining management simplicity. Consider a multinational company with regional AI teams. You might create a parent group called "Global Data Scientists" and nest regional groups like "EMEA Data Scientists" and "APAC Data Scientists" within it. When you assign the Reader role to the parent group, all nested members inherit that permission automatically. This structure lets you add region-specific permissions—for example, granting EMEA scientists access to European data storage accounts—while maintaining consistent baseline access across all regions.

Nesting becomes valuable when managing cross-functional projects. Suppose your organization launches a new healthcare AI initiative requiring collaboration between data scientists, ML engineers, and domain experts. Create a project-specific group called "Healthcare AI Team" and nest relevant members from your existing functional groups. Assign this project group Contributor access to a dedicated Azure Machine Learning workspace. Team members retain their baseline permissions from their functional groups while gaining project-specific access. When the project concludes, delete the project group—functional group memberships and permissions remain intact. This approach delivers flexibility without fragmenting your security architecture.

:::image type="content" source="../media/project-group-functional-group-memberships.png" alt-text="Diagram showing a project group with functional group memberships and permissions.":::

## Key considerations for group management

Effective security group design requires balancing several factors. First, consider your group naming convention carefully. Use descriptive prefixes that indicate scope and purpose: `AML-DataScientists-Prod` clearly identifies the service (AML for Azure Machine Learning), role (Data Scientists), and environment (Prod). This clarity prevents confusion when security teams audit permissions months later. Second, document group ownership in the description field. Specify which team manages membership and how users request access—this prevents permission drift and ensures accountability. Finally, review group memberships quarterly. Even with dynamic rules, exceptions accumulate over time. Regular audits catch orphaned accounts and verify that access levels still match job responsibilities, reducing your attack surface and maintaining compliance with data protection regulations.

:::image type="content" source="../media/entra-security-groups-mapped-azure.png" alt-text="Diagram showing how organizations can adjust thresholds iteratively to observe real-world usage patterns.":::

*Microsoft Entra security groups mapped to Azure Machine Learning workspace roles*

## More resources

- [Create security groups in Microsoft Entra ID](/entra/fundamentals/how-to-manage-groups) - Step-by-step guidance for group creation and management
- [Dynamic membership rules for groups](/entra/identity/users/groups-dynamic-membership) - Rule syntax reference and examples
- [Azure Machine Learning built-in roles](/azure/machine-learning/how-to-assign-roles) - Complete list of available RBAC roles and permissions


