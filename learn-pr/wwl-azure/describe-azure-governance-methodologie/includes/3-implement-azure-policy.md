There are three steps to creating and implementing an Azure policy.

![Three-step process for implementing policy definitions as discussed in the text](../media/policy-process.png)

## Create a policy definition

A policy definition expresses what to evaluate and what action to take. For example, you could prevent VMs from being deployed if they are exposed to a public IP address. You also could prevent a hard disk from being used when deploying VMs to control costs.

Every policy definition has conditions under which it is enforced. And, it has an accompanying effect that takes place if the conditions are met. Here are some example policy definitions:

- **Allowed storage account SKUs**. This policy definition has a set of conditions/rules that determine whether a storage account that is being deployed is within a set of SKU sizes. Its effect is to deny all storage accounts that do not adhere to the set of defined SKU sizes.
- **Allowed resource type**. This policy definition has a set of conditions/rules to specify the resource types that your organization can deploy. Its effect is to deny all resources that are not part of the defined list.
- **Allowed locations**. This policy enables you to restrict the locations that your organization can specify when deploying resources. Its effect is used to enforce your geographic compliance requirements.
- **Allowed Virtual Machine SKUs**. This policy enables you to specify a set of VM SKUs that your organization can deploy.

More sample policies are available on the [Azure policy samples](https://docs.microsoft.com/azure/governance/policy/samples?azure-portal=true) page.

## Assign a definition to a scope of resources

To implement your policy definitions, you assign them to resources. A policy assignment is a policy definition that has been assigned to take place within a specific scope. This specific scope could range from a management group to a resource group. Policy assignments are inherited by all child resources. This means that if a policy is applied to a resource group, it is applied to all the resources within that resource group. However, you can exclude a subscope from the policy assignment.

## Review the policy evaluation results

When a condition is evaluated against your existing resources it is marked compliant or non-compliant. You can review the non-compliant policy results and take any action that is needed.

Policy evaluation happens about once an hour, which means that if you make changes to your policy definition and create a policy assignment then it will be re-evaluated over your resources within the hour.

