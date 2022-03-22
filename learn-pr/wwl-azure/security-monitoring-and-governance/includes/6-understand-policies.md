Applying a policy to your resources with Azure Policy involves the following high-level steps:

 -  Policy definition. Create a policy definition.
 -  Policy assignment. Assign the definition to a scope of resources.
 -  Remediation. Review the policy evaluation results and address any non-compliances.

## Policy definition

A **policy definition** specifies the resources to be evaluated and the actions to take on them. For example, you could prevent VMs from deploying if exposed to a public IP address. You could also contain a specific hard disk from deploying VMs to control costs. Policies are defined in the JavaScript Object Notation (JSON) format.

The following example defines a policy that limits where you can deploy resources:

```JSON
{
    "properties": {
        "mode": "all",
        "parameters": {
            "allowedLocations": {
                "type": "array",
                "metadata": {
                    "description": "The list of locations that can be specified when deploying resources",
                    "strongType": "location",
                    "displayName": "Allowed locations"
                }
            }
        },
        "displayName": "Allowed locations",
        "description": "This policy enables you to restrict the locations your organization can specify when deploying resources.",
        "policyRule": {
            "if": {
                "not": {
                    "field": "location",
                    "in": "[parameters('allowedLocations')]"
                }
            },
            "then": {
                "effect": "deny"
            }
        }
    }
}

```

The following list is example policy definitions:

 -  Allowed Storage Account SKUs. This policy defines conditions (or *rules*) that limit storage accounts to a set of specified sizes or Stock Keeping Units (SKUs). Its effect is to deny all storage accounts that don't adhere to defined SKU sizes.
 -  Allowed Resource Type. This policy definition has a set of conditions to specify the resource types deployed. Its effect is to deny all resources that are on the list.
 -  Allowed Locations. This policy restricts the locations where new resources can be deployed. It's used to enforce geographic compliance requirements.
 -  Allowed Virtual Machine SKUs. This policy specifies a set of VM SKUs that can be deployed. The policy effect is that VMs can't be deployed from unspecified SKUs.

## Policy assignment

Policy definitions, whether custom or built-in, need to be assigned.

A *policy assignment* is a policy definition that has been assigned to a specific scope. Scopes can range from a management group to a resource group.

Child resources will inherit any policy assignments applied to their parents.

It means if a policy is applied to a resource group, it's used to all the resources within that resource group.

However, you can define subscopes for excluding resources from policy assignments.

You can assign policies via:

 -  Azure portal.
 -  Azure CLI.
 -  PowerShell.

## Remediation

Resources found not to follow a *deployIfNotExists* or *modify* policy condition can be put into a compliant state through Remediation.

*Remediation* instructs Azure Policy to run the *deployIfNotExists* effect or the tag operations of the policy on existing resources.

To minimize configuration drift, you can bring resources into compliance using automated bulk Remediation instead of going through them one at a time.

You can read more about Azure Policy on the [Azure Policy](https://azure.microsoft.com/services/azure-policy/) webpage.
