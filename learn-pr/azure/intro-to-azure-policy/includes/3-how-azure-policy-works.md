## Azure Policy concepts

To work with Azure Policy, you need to understand the following concepts:

- **Policy**: The business rule to be applied within your organization.
- **Initiative**: A set of policies combined to simplify management. Both policies and initiatives are written in JSON format.
- **Assignments**: The associations of initiatives or policies with scopes. A scope for Azure Policy might be a management group, an Azure subscription, or a resource group. All child resources inherit assignments.
- **Definitions**: The list of built-in or custom initiatives and policies available to be assigned.
- **Exemptions**: Rules that remove a resource hierarchically or individually from the evaluation of initiatives or definitions.
- **Remediation**: A way to handle non-compliant resources. You create remediation tasks to help ensure the desired state for resources.

## Working with Azure Policy

Azure Policy doesn't offer the same approach that you might get from a Group Policy object in Active Directory. You can use the guest configuration feature from Azure Policy to audit or configure settings inside a virtual machine. But generally, the intent of Azure Policy is to enforce business rules that establish conventions for your resources. The conditions take effect when the resources meet those conventions.

So the policies are made of conventions that you define. The conventions are evaluated in a specific order to take effect on the resources. The effects differ if they're for a new resource, an updated resource, or an existing resource.

The available effects are:

* **Append**: Adds the defined set of fields to the request.
* **Audit**: Generates a warning event in activity log but doesn't fail the request.
* **AuditIfNotExists**: Generates a warning event in activity log if a related resource doesn't exist.
* **Deny**: Generates an event in the activity log and fails the request.
* **DeployIfNotExists**: Deploys a related resource if it doesn't already exist.
* **Disabled**: Doesn't evaluate resources for compliance with the policy rule.
* **Modify**: Adds, updates, or removes the defined tags from a resource or subscription.

The evaluation order is:

1. **Disabled** is checked to determine whether the policy rule should be evaluated.
1. **Append** and **Modify** are evaluated. Because either might alter the request, a change made might prevent an audit or deny an effect from triggering. These effects are available only with an Azure Resource Manager mode.
1. **Deny** is evaluated. Evaluating **Deny** before **Audit** prevents double logging of an undesired resource.
1. **Audit** is evaluated.

After the evaluation, the effects can be applied to a resource.

## Phases of Azure Policy implementation

A successful implementation consists of the following phases.

### Assess

The assessment is an overview of the status of your environment. Before you make changes in your environment through policies to take actions, assign a policy just to audit your environment. To get this functionality, go to the Azure portal and select **Overview** from the menu.

### Test

Before you create policies to make changes in your environment, make sure to test everything. Validate your policy syntax, the actions that will be taken, and the scope in use (management groups, subscriptions, and resource groups). Validate all policy inclusions, exclusions, and exemptions.

### Deploy

For the deployment, initially, make sure you'll run your policy against a controlled environment or a dedicated subscription. Be aware that Azure Policy assignments don't come into effect immediately. There's a policy evaluation delay of around 30 minutes. Also, auditing your resources might take some time because the Azure Policy engine needs to evaluate all resources against policy rules within the assigned scope.

### Check

Finally, select **Compliance** to check the results of your policy assignments.

:::image type="content" source="../media/2-compliance.png" alt-text="Screenshot that shows the Azure Policy compliance." lightbox="../media/2-compliance.png":::

## Covered resources

Azure policy covers all Azure resources, including Azure Arc enabled resources. This means that, for example, you can extend the coverage of your controls to Windows and Linux physical servers, and to virtual machines hosted outside Azure on your corporate network or though another cloud provider. For Azure resources, the usage of Azure Policy is free. For an Azure Arc resource, there is a fee.

## Related services

* **Azure Blueprints**: A policy assignment is an artifact type from Azure Blueprints, so you can use Azure Blueprints to make policy assignments. You an also assign a policy through .NET, JavaScript, Python, REST API, PowerShell, Azure CLI, Azure Resource Manager template, Bicep, and Terraform.
* **Azure Resource Graph**: Though Azure Resource Graph, you can run queries to get information about compliance details by assignments and resource types, list all non-compliant resources, summarize resource compliance by state, and more.
* **Azure Security Center**: The recommendations from Azure Security Center come from  built-in security policy initiatives.
