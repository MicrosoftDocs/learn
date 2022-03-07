[Azure Policy](https://azure.microsoft.com/services/azure-policy) is a service in Azure that enables you to create, assign, and manage policies that control or audit your resources. These policies enforce different rules over your resource configurations so that those configurations stay compliant with corporate standards.

**Things to know about Azure policy**

- Azure policy lets you define both individual policies and groups of related policies, called initiatives. Azure Policy comes with many [built-in policy](/azure/governance/policy/samples/built-in-policies) and [initiative definitions](/azure/governance/policy/samples/built-in-initiatives).

- Azure policy lets you scope and enforce your policies at different levels in the organizational hierarchy. 

- Azure policies are inherited down the hierarchy. 

- Azure policy evaluates your resources and highlights resources that aren’t compliant with the policies you’ve created. 

- Azure policy can prevent noncompliant resources from being created.

- Azure Policy can automatically remediate noncompliant resources.

- Azure Policy evaluates all resources in Azure and Arc enabled resources (specific resource types hosted outside of Azure).

- Azure policy integrates with Azure DevOps by applying pre-deployment and post-deployment policies. 

### Things to consider when using Azure policy

Tailwind Traders is now ready to consider applying Azure policy to their apps. Some policies will be applied at the Production management group level. Other policies will be assigned at the app level. 

:::image type="content" source="../media/azure-policy-choices.png" alt-text="Different Azure policies are applied at the Production and Application resource group levels.":::

- **Consider using the Azure policy compliance dashboard.** The Azure policy compliance dashboard provides an aggregated view to help evaluate the overall state of the environment. You can drill down to a per-resource, or per-policy level granularity. You can also use capabilities like bulk remediation for existing resources and automatic remediation for new resources, to resolve issues rapidly and effectively.

- **Consider when Azure policy evaluates resources**. Azure policy evaluates resources at specific times. It’s important to understand when an evaluation is triggered. There may be a lag in identifying non-compliant resources. The following events or times will trigger an evaluation.

	- A resource has been created, deleted, or updated in scope with a policy assignment.

	- A policy or an initiative is newly assigned to a scope.

	- A policy or an initiative that’s been assigned to a scope is updated.

	- The standard compliance evaluation cycle (happens once every 24 hours).

- **Consider what you’ll do if a resource is non-compliant.** Organizations will vary in how they respond to non-compliant resources. Your strategy may be different depending on the resource. Here’s some examples of what to do if a resource is non-compliant. 

	- Deny a change to a resource.

	- Log changes to a resource.

	- Alter a resource before or after a change.

	- Deploy related compliant resources.

- **Consider when to automatically remediate non-compliant resources.** In some cases, Azure policy can automatically remediate noncompliant resources. Remediation is especially useful in resource tagging. Azure policy can tag resources and reapply tags that have been removed. For example, Azure policy can ensure all resources in a certain resource group should be tagged with the Location tag.

- **Consider how Azure policy is different from role-based access control (RBAC).** It’s important not to confuse Azure Policy and Azure RBAC. Azure RBAC and Azure Policy should be used together to achieve full scope control.

	- You use Azure Policy to ensure that the resource state is compliant to your organization’s business rules. Compliance doesn’t depend on who made the change or who has permission to make changes. Azure Policy will evaluate the state of a resource, and act to ensure the resource stays compliant.

	- You use Azure RBAC to focus on user actions at different scopes. Azure RBAC manages who has access to Azure resources, what they can do with those resources, and what areas they can access. If actions need to be controlled, then use Azure RBAC. If an individual has access to complete an action, but the result is a non-compliant resource, Azure Policy still blocks the action.

Once you have determined your identity management solution, it’s time to think about resource access. What resources should these identities be able to access? How will you enforce that access? How will you monitor and review the access?

A user’s identity goes through several phases. Initially, the user will have no access. Access can then be granted through role-based access control and verified with Azure AD conditional access. Azure AD Identify Protection can be used to monitor the user’s access. And then periodically Azure AD access reviews will confirm the access is still required. 


