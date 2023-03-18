We will cover the following keys to addressing security and compliance requirements with Azure Policy:
1. Background on Azure policy and its features
1. Creating policies and applying them to resources
	1. Using built-in policies
	2. Creating custom policies
	3. Grouping policies with intiative definitions
2. Evaluating compliance
3. Remediating non-compliant resources

## Introduction to Azure Policy

Azure Policy evaluates resources and actions in Azure by comparing the properties of those resources to business rules. These business rules, described in JSON format, are known as policy definitions. To simplify management, several business rules can be grouped together to form a policy initiative (sometimes called a _policySet_). Once your business rules have been formed, the policy definition or initiative is assigned to any scope of resources that Azure supports, such as management groups, subscriptions, resource groups, or individual resources. The assignment applies to all resources within the Resource Manager scope of that assignment. Subscopes can be excluded, if necessary. For more information, see Scope in Azure Policy.

Azure Policy uses a JSON format to form the logic the evaluation uses to determine whether a resource is compliant or not. Definitions include metadata and the policy rule. The defined rule can use functions, parameters, logical operators, conditions, and property aliases to match exactly the scenario you want. The policy rule determines which resources in the scope of the assignment get evaluated.

### Understand evaluation outcomes

Resources are evaluated at specific times during the resource lifecycle, the policy assignment lifecycle, and for regular ongoing compliance evaluation. The following are the times or events that cause a resource to be evaluated:

-   A resource is created or updated in a scope with a policy assignment.
-   A policy or initiative is newly assigned to a scope.
-   A policy or initiative already assigned to a scope is updated.
-   During the standard compliance evaluation cycle, which occurs once every 24 hours.

### Control the response to an evaluation

Business rules for handling non-compliant resources vary widely between organizations. Examples of how an organization wants the platform to respond to a non-compliant resource include:

-   Deny the resource change
-   Log the change to the resource
-   Alter the resource before the change
-   Alter the resource after the change
-   Deploy related compliant resources
-   Block actions on resources

Azure Policy makes each of these business responses possible through the application of effects. Effects are set in the **policy rule** portion of the policy definition.

### Remediate non-compliant resources

While these effects primarily affect a resource when the resource is created or updated, Azure Policy also supports dealing with existing non-compliant resources without needing to alter that resource. For more information about making existing resources compliant, see [remediating resources](https://learn.microsoft.com//azure/governance/policy/how-to/remediate-resources).

<!--- START: (https://learn.microsoft.com//azure/governance/policy/tutorials/create-and-manage) --->

## Assign a policy

The first step in enforcing compliance with Azure Policy is to assign a policy definition. A policy definition defines under what condition a policy is enforced and what effect to take. In this example, assign the built-in policy definition called _Inherit a tag from the resource group if missing_ to add the specified tag with its value from the parent resource group to new or updated resources missing the tag.

## Implement a new custom policy

Now that you've assigned a built-in policy definition, you can do more with Azure Policy. Next, create a new custom policy to save costs by validating that virtual machines created in your environment can't be in the G series. This way, every time a user in your organization tries to create a virtual machine in the G series, the request is denied.

## Create and assign an initiative definition

With an initiative definition, you can group several policy definitions to achieve one overarching goal. An initiative evaluates resources within scope of the assignment for compliance to the included policies. For more information about initiative definitions, see [Azure Policy overview](https://learn.microsoft.com//azure/governance/policy/overview).

<!--- END: (https://learn.microsoft.com//azure/governance/policy/tutorials/create-and-manage)--->

## Evaluating compliance

<!--- BEGIN: (https://learn.microsoft.com//azure/governance/policy/how-to/get-compliance-data)--->

### Evaluation triggers

The results of a completed evaluation cycle are available in the `Microsoft.PolicyInsights` Resource Provider through `PolicyStates` and `PolicyEvents` operations.

Evaluations of assigned policies and initiatives happen as the result of various events:

- A policy or initiative is newly assigned to a scope. It takes around five minutes for the assignment to be applied to the defined scope, then the evaluation cycle begins for applicable resources against the newly assigned policy or initiative. Depending on the effects used, resources are marked as compliant, non-compliant, exempt, or unknown. A large policy or initiative evaluated against a large scope of resources can take time, so there's no pre-defined expectation of when the evaluation cycle completes. Once it completes, updated compliance results are available in the portal and SDKs.
- A policy or initiative already assigned to a scope is updated. The evaluation cycle and timing for this scenario is the same as for a new assignment to a scope.
- A resource is deployed to or updated within a scope with an assignment via Azure Resource Manager, REST API, or a supported SDK. In this scenario, the effect event (append, audit, deny, deploy) and compliant status information for the individual resource becomes available in the portal and SDKs around 15 minutes later. This event doesn't cause an evaluation of other resources.
- A subscription (resource type `Microsoft.Resources/subscriptions`) is created or moved within a [management group hierarchy](https://learn.microsoft.com//azure/governance/management-groups/overview) with an assigned policy definition targeting the subscription resource type. Evaluation of the subscription supported effects (audit, auditIfNotExist, deployIfNotExists, modify), logging, and any remediation actions takes around 30 minutes.
- A [policy exemption](https://learn.microsoft.com//azure/governance/policy/concepts/exemption-structure) is created, updated, or deleted. In this scenario, the corresponding assignment is evaluated for the defined exemption scope.
- Standard compliance evaluation cycle. Once every 24 hours, assignments are automatically reevaluated. A large policy or initiative of many resources can take time, so there's no pre-defined expectation of when the evaluation cycle completes. Once it completes, updated compliance results are available in the portal and SDKs.
- The [machine configuration](https://learn.microsoft.com//azure/governance/machine-configuration/overview) resource provider is updated with compliance details by a managed resource.
- On-demand scan

### Compliant and non-compliant states

In an assignment, a resource is **non-compliant** if it's applicable to the policy assignment and doesn't adhere to conditions in the policy rule. The following table shows how different policy effects work with the condition evaluation for the resulting compliance state:

| Resource State | Effect | Policy Evaluation | Compliance State |
| --- | --- | --- | --- |
| New or Updated | Audit, Modify, AuditIfNotExist | True | Non-Compliant |
| New or Updated | Audit, Modify, AuditIfNotExist | False | Compliant |
| Exists | Deny, Audit, Append, Modify, DeployIfNotExist, AuditIfNotExist | True | Non-Compliant |
| Exists | Deny, Audit, Append, Modify, DeployIfNotExist, AuditIfNotExist | False | Compliant |

### Other compliance states

Besides **Compliant** and **Non-compliant**, policies and resources have four other states:

- **Exempt**: The resource is in scope of an assignment, but has a defined exemption.
- **Conflicting**: Two or more policy definitions exist with conflicting rules. For example, two
  definitions append the same tag with different values.
- **Not started**: The evaluation cycle hasn't started for the policy or resource.
- **Not registered**: The Azure Policy Resource Provider hasn't been registered or the account
  logged in doesn't have permission to read compliance data.

Azure Policy relies on several factors to determine whether a resource is considered applicable, then to determine its compliance state.

The compliance percentage is determined by dividing **Compliant**, **Exempt**, and **Unknown** resources by _total
resources_. _Total resources_ include **Compliant**, **Non-compliant**,
**Exempt**, and **Conflicting** resources. The overall compliance numbers are the sum of distinct
resources that are **Compliant**, **Exempt**, and **Unknown** divided by the sum of all distinct resources. In the
image below, there are 20 distinct resources that are applicable and only one is **Non-compliant**.
The overall resource compliance is 95% (19 out of 20).

<!--- END: (https://learn.microsoft.com//azure/governance/policy/how-to/get-compliance-data)--->

### Remediating non-compliant resources

Resources that are non-compliant to policies with deployIfNotExists or modify effects can be put into a compliant state through Remediation. Remediation is accomplished through remediation tasks that deploy the deployIfNotExists template or the modify operations of the assigned policy on your existing resources and subscriptions, whether that assignment is on a management group, subscription, resource group, or individual resource. For more information on the remediation process, see [Remediate non-compliant resources with Azure Policy](https://learn.microsoft.com//azure/governance/policy/how-to/remediate-resources?tabs=azure-portal).