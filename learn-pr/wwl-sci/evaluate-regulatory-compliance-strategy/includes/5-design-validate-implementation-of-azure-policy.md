
Continuous monitoring is imperative for organizations that are adopting cloud computing since the nature of the workloads is very dynamic. New workloads are provisioned on a daily basis, and it becomes critical to ensure that these workloads are secure by default. In other words, it is necessary to implement guardrails at the beginning of the pipeline to ensure that users are not able to provision unsecure workloads.  

Without this continuous monitoring and policy enforcement your environment will be exposed to more risks as the workloads won't be secure by default.  

When designing your Azure Policy, you need to take into consideration the organization's needs from the infrastructure perspective as well as compliance. By designing a tailored policy, you can help to reduce the time necessary to audit your environment by having all your compliance data in a single place.  

## Set guardrails

Azure Policy can also help to set guardrails throughout your resources to help ensure cloud compliance, avoid misconfigurations, and practice consistent resource governance. Consider also using Azure Policy to reduce the number of external approval processes by implementing policies at the core of the Azure platform for increased developer productivity and control optimization of your cloud spend. Azure Policy will help you govern your Azure resources with simplicity, enforce policies and audit compliance, and monitor compliance continuously. Azure Policy establishes conventions for resources. Policy definitions describe resource compliance conditions and the effect to take if a condition is met. A condition compares a resource property field or a value to a required value. Resource property fields are accessed by using aliases. When a resource property field is an array, a special array alias can be used to select values from all array members and apply a condition to each one. The diagram below shows an example of how Azure Policy can be used in the beginning of the pipeline to ensure that policies are enforced upon the creation of the resources. 

:::image type="content" source="../media/pre-flight-validation-authoring.png" alt-text="Diagram showing an example of how Azure Policy can be used in the beginning of the pipeline to ensure that policies are enforced upon the creation of the resources.":::

## Control Costs

By defining conventions, you can control costs and more easily manage your resources. For example, you can specify that only certain types of virtual machines are allowed. Or, you can require that resources have a particular tag. Policy assignments are inherited by child resources. If a policy assignment is applied to a resource group, it's applicable to all the resources in that resource group.

## Azure Policy and Azure Resources

When designing your Azure Policy, you need to take into account how the policies will affect your Azure resources to business standards and meet compliance needs. When people, processes, or pipelines create or update resources, Azure Policy reviews the request. When the policy definition effect is *Modify*, *Append*, or *DeployIfNotExists*, Policy alters the request or adds to it. When the policy definition effect is *Audit* or *AuditIfNotExists*, Policy causes an activity log entry to be created for new and updated resources. And when the policy definition effect is *Deny*, Policy stops the creation or alteration of the request.

## Validating New Policy 

The recommended approach to validating a new policy definition is by following these steps:

- Tightly define your policy.
- Audit your existing resources.
- Audit new or updated resource requests.
- Deploy your policy to resources.
- Continuously monitor. 

### Tightly define your policy

It's important to understand how the business policy is implemented as a policy definition and the relationship of Azure resources with other Azure services. This step is accomplished by identifying the requirements and determining the resource properties. But it's also important to see beyond the narrow definition of your business policy. Does your policy state for example "All Virtual Machines must\..."? What about other Azure services that make use of VMs, such as HDInsight or AKS? When defining a policy, we must consider how this policy impacts resources that are used by other services.

For this reason, your policy definitions should be as tightly defined and focused on the resources and the properties you need to evaluate for compliance as possible.

### Audit existing resources

Before looking to manage new or updated resources with your new policy definition, it's best to see how it evaluates a limited subset of existing resources, such as a test resource group. Use the enforcement mode Disabled (*DoNotEnforce*) on your policy assignment to prevent the effect from triggering or activity log entries from being created.

This step gives you a chance to evaluate the compliance results of the new policy on existing resources without impacting workflow. Check that no compliant resources are marked as non-compliant (false positive) and that all the resources you expect to be non-compliant are marked correctly. After the initial subset of resources validates as expected, slowly expand the evaluation to all existing resources.

Evaluating existing resources in this way also provides an opportunity to remediate non-compliant resources before full implementation of the new policy. This cleanup can be done manually or through a remediation task if the policy definition effect is *DeployIfNotExists*.

### Audit new or updated resources

Once you've validated your new policy definition is reporting correctly on existing resources, it's time to look at the impact of the policy when resources get created or updated. If the policy definition supports effect parameterization, use Audit. This configuration allows you to monitor the creation and updating of resources to see whether the new policy definition triggers an entry in Azure Activity log for a resource that is non-compliant without impacting existing work or requests.

It's recommended to both update and create new resources that match your policy definition to see that the Audit effect is correctly being triggered when expected. Be on the lookout for resource requests that shouldn't be affected by the new policy definition that trigger the Audit effect. These affected resources are another example of false positives and must be fixed in the policy definition before full implementation.

In the event the policy definition is changed at this stage of testing, it's recommended to begin the validation process over with the auditing of existing resources. A change to the policy definition for a false positive on new or updated resources is likely to also have an impact on existing resources.

### Deploy your policy to resources

After completing validation of your new policy definition with both existing resources and new or updated resource requests, you begin the process of implementing the policy. It's recommended to create the policy assignment for the new policy definition to a subset of all resources first, such as a resource group. After validating initial deployment, extend the scope of the policy to broader and broader levels, such as subscriptions and management groups. This expansion is achieved by removing the assignment and creating a new one at the target scopes until it's assigned to the full scope of resources intended to be covered by your new policy definition.

During rollout, if resources are located that should be exempt from your new policy definition, address them in one of the following ways:

- Update the policy definition to be more explicit to reduce unintended impact.
- Change the scope of the policy assignment (by removing and creating a new assignment).
- Add the group of resources to the exclusion list for the policy assignment.

Any changes to the scope (level or exclusions) should be fully validated and communicated with your security and compliance organizations to ensure there are no gaps in coverage.

### Monitor your policy and compliance

Implementing and assigning your policy definition isn't the final step. Continuously monitor the compliance level of resources to your new policy definition and set up appropriate Azure Monitor alerts and notifications for when non-compliant devices are identified. It's also recommended to evaluate the policy definition and related assignments on a scheduled basis to validate the policy definition is meeting business policy and compliance needs. Policies should be removed if no longer needed. Policies also need updating from time to time as the underlying Azure resources evolve and add new properties and capabilities.
