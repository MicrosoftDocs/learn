Azure Policy is designed to help enforce standards and assess compliance across your organization. Through its compliance dashboard, you’re able to access an aggregated view to help evaluate the overall state of the environment, with the ability to drill down to a per-resource, or per-policy level granularity. Additionally, you can take advantage of capabilities like bulk remediation for existing resources and automatic remediation for new resources, to resolve issues rapidly and effectively. Common use cases for Azure Policy include implementing governance for resource consistency, regulatory compliance, security, cost, and management.

Azure Policy evaluates all resources in Azure and Arc enabled resources (specific resource types hosted outside of Azure).

The way it works, is that Azure Policy evaluates whether the properties of resources match with business rules. These business rules are described using [JSON](https://docs.microsoft.com/azure/governance/policy/concepts/definition-structure) format, and referred to as [policy definitions](https://docs.microsoft.com/azure/governance/policy/overview#policy-definition). For simplified management, you can group together multiple business rules to form a single [policy initiative](https://docs.microsoft.com/azure/governance/policy/overview#initiative-definition). After business rules have been formed, you can assign the policy definition, or policy initiative to any scope of resources that are supported, such as management groups, subscriptions, resource groups, or individual resources.  

## Evaluation outcomes

Azure Policy evaluates resources at specific times during the resource lifecycle and the policy assignment lifecycle, and for regular ongoing compliance evaluation. The following events or times will trigger a valuation:

- A resource has been created, deleted, or updated in scope with a policy assignment
- A policy or an initiative is newly assigned to a scope
- A policy or an initiative that has been assigned to a scope, is updated.
- The standard compliance evaluation cycle (happens once every 24 hours).

Organizations will vary in how they respond non-compliant resources.  The following are some examples:

- Deny a change to a resource
- Log changes to a resource
- Alter a resource before or after a change
- Deploy related compliant resources  

With Azure Policy, responses like these are made possible through the use of [effects](https://docs.microsoft.com/azure/governance/policy/concepts/effects), which are specified in policy definitions.

## What’s the difference between Azure Policy and Azure role-based access control (RBAC)?

It’s important to not confuse Azure Policy and Azure RBAC as fulfilling the same role. You use Azure Policy to ensure that the resource state is compliant to your organization’s business rules regardless of who made the change or who has permission to make changes. Azure Policy will evaluate the state of a resource, and act to ensure the resource stays compliant.

Azure role-based access control (Azure RBAC) instead focuses on managing user actions at different scopes. Azure RBAC manages who has access to Azure resources, what they can do with those resources, and what areas they have access to.  If actions need to be controlled, then you would use Azure RBAC.  If an individual has access to perform an action, but the result is a non-compliant resource, Azure Policy still blocks the action.

Azure RBAC and Azure Policy should be used together to achieve full scope control in Azure.
