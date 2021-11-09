## Azure Policy concepts

The following are some concepts you need to understand in advance to work with Azure Policy:

**Policy:** A policy is the business rule to be applied within your organization.

**Initiative:** An initiative is a set of policies combined to simplify management. Both policies and initiatives are written in JSON format.

**Assignments:** The assignments are the associations of initiatives or policies with scopes. A scope for Azure Policy could be a Management Group, an Azure Subscription or a Resource Group. Assignments are inherited by all child resources.

**Definitions:** The definitions are the list of built-in or custom initiatives and policies available to be assigned.

**Exemptions:**: The exemptions are used to exempt a resource hierarchically or and individual resource from the evaluation of initiatives or definitions.

**Remediation:** A remediation is a way to handle non-compliant resources. It allows you to create remediation tasks and ensure the desired state for resources.

## Working with Azure Policy

Keep in mind that Azure Policies don't have the same approach as you might get from a Group Policy Object in your Active Directory. Besides the possibility to work with the Guest configuration feature from Azure Policy, to audit or configure settings inside a virtual machine, the intent of Azure Policy is to enforce business rules establishing conventions for your resources. The conventions should be met in order to have the conditions take effect.

So the policies are made of conventions, defined from you, to be evaluated following a specific order to have effect over the resources. The effects differ if they are for a new resource, an updated resource, or an existing resource.

The evaluation order is:

* Disabled is checked first to determine whether the policy rule should be evaluated.
* Append and Modify are then evaluated. Since either could alter the request, a change made may prevent an audit or deny effect from triggering. These effects are only available with a Resource Manager mode.
* Deny is then evaluated. By evaluating deny before audit, double logging of an undesired resource is prevented.
* Audit is evaluated last.

After the evaluation, the following effects can be applied to a resource:

* Append: adds the defined set of fields to the request
* Audit: generates a warning event in activity log but doesn't fail the request
* AuditIfNotExists: generates a warning event in activity log if a related resource doesn't exist
* Deny: generates an event in the activity log and fails the request
* DeployIfNotExists: deploys a related resource if it doesn't already exist
* Disabled: doesn't evaluate resources for compliance to the policy rule
* Modify: adds, updates, or removes the defined tags from a resource or subscription

## Considerations of Azure Policy implementation

Here are four important topics to be considered for a successful implementation:

* Assessment
* Test
* Deploy
* Check

The assessment is where you will have an overview about the status of your environment. Then, before making changes in your environment through policies to take actions, assign a policy just to audit your environment. You can use the Overview option from the menu to get this functionality.

Before creating policies, which will make changes in your environment, make sure to test everything.

Validate your policy syntax, the actions that will be taken and the scope in use (Management Groups, Subscriptions, and Resource Groups). Validate all policy inclusions, exclusions and exemptions.

For the deployment initially, make sure you will be running your policy against a controlled environment or dedicated subscription. Be aware that Azure Policy assignments don’t come into effect immediately. There is a policy evaluation delay, which is around 30 minutes or so. Also, auditing your resources might take some time as the Azure Policy engine needs to evaluate all resources against policy rules within the assigned scope.

Finally use the Compliance option to check the results of your policy assignments.

:::image type="content" source="../media/2-compliance.png" alt-text="Screen with the Azure Policy Compliance." lightbox="../media/2-compliance.png":::

## Resources covered

Azure policy covers all Azure resources, including Arc enabled resources. This means that you can extend the coverage of your controls over Windows and Linux physical servers,  virtual machines hosted outside of Azure, on your corporate network, or other cloud provider, as examples. For Azure resources the usage of Azure Policy is free, but for an Arc resource there is a fee associated.

## Related services

* Azure Blueprints: A policy assignment is an artifact type from Azure Blueprints, meaning you can use Azure Blueprints to assign policy assignments. Note you can assign a policy through .NET, JavaScript, Python, REST API, PowerShell, Azure CLI, ARM template, Bicep, and Terraform as well.
* Azure Resource Graph: Though Azure Resource Graph you can run queries to get information about compliance details by assignments and resource types, list all non-compliant resources, summarize resource compliance by state and more.
* Azure Security Center: The recommendations from Azure Security Center come from  built-in security policies initiatives.
