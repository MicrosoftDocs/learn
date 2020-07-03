You’ve seen how Relecloud can  monitor its customer tenants in a centralized and scalable way. Because Relecloud has onboarded multiple customers with Azure delegated resource management, the company wants to ensure that it stays compliant with all corporate standards and service level agreements.  So now you’ll investigate how Relecloud can help ensure compliance with the help of Azure Policy policies. You’ll explore how Relecloud can deploy policies to customer tenants at scale, and how to use policies with remediation tasks in a customer tenant to remediate non-compliance.

## Deploy a policy for multiple tenants

You can deploy policies across delegated subscriptions in multiple customer tenants. You might want to a single policy that ensures:

- All storage accounts in customer subscriptions only use HTTPS
- Storage accounts that don’t use HTTPS can’t be created
- Any storage accounts that aren’t set to HTTPS are marked non-compliant

You define the policy by creating a policy definition and a policy assignment.  You define both of these in an Azure Resource Manager template.  The template enables you to deploy the policy at scale. You can use tools like Azure PowerShell and Azure CLI to deploy the template across all customer subscriptions. You're able to use the following snippet of Azure PowerShell code  to iterate through all customer subscriptions and deploy the template to each one:

```powershell
foreach ($ManagedSub in $ManagedSubscriptions)
{
    Select-AzSubscription -SubscriptionId $ManagedSub.subscriptionId

    New-AzSubscriptionDeployment -Name mgmt `
                     -Location eastus `
                     -TemplateUri "URL-for-template.json" `
                     -AsJob
}
```

Once you've deployed your template, you’ll confirm that the policy was successfully applied across tenants. To do this, you test the policy out by trying to create a storage account that has the **EnableHttpsTrafficOnly** setting set to **False** in one of the customer subscriptions, like Lamna Healthcare’s subscription. If the policy has been applied successfully, you'll be unable to create the storage account.

## Deploy a policy to remediate non-compliance

You want to make sure that all customer resources are compliant, and fix non-compliance if it occurs for Lamna Healthcare or any other customer. You create policies that have remediation tasks included to remediate non-compliance. These types of policies can be created by including the **DeployIfNotExists** or **Modify** effects inside a policy definition. An effect describes what should happen when a policy rule has been matched. You define an effect inside of a policy definition:

```javascript
"then": {
    "effect": "modify",
    "details": {
        "roleDefinitionIds": [
            "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ],
        "operations": [
            {
                "operation": "addOrReplace",
                "field": "tags['environment']",
                "value": "Test"
            }
        ]
    }
}
```

| Property | Description |
| --------------------- | ------------------------------------------------------------ |
| *effect*| Name   of the effect                                         |
| *details*| Sub properties that are used to define what permissions are needed for remediation |
| *roleDefinitionIds* | Array of strings that match with role-based access control role IDs |
| *operations*        | Array of operations that must be completed on matched resources |

### Define a user to assign roles to managed identities

You'll need to create a managed identity in a customer like Lamna Healthcare’s tenant, to deploy policies with remediation to them.  To onboard new customers with Azure Lighthouse, you'll have defined users and permissions that you and other Relecloud users will use to manage customer’s resources and subscriptions.

To enable any of your users to create a managed identity in any customer’s tenant, the user’s **roleDefinitionId** needs to be set to **User Access Administrator** in the Azure Resource Manager template used for onboarding. The user won’t have the permissions associated with the User Access Administrator role, but it can assign certain built-in roles to managed identities once the customer has been onboarded.

You include these roles in the **delegatedRoleDefinitionIds** property for this user in the template. You would define this user in the template in the following way:

```javascript
{
    "principalId": "3kl47fff-5655-4779-b726-2cf02b05c7c4",
    "principalIdDisplayName": "Policy Automation Account",
    "roleDefinitionId": "18d7d88d-d35e-4fb5-a5c3-7773c20a72d9",
    "delegatedRoleDefinitionIds": [
         "b24988ac-6180-42a0-ab88-20f7382dd24c",
         "92aaf0da-9dab-42b6-94a3-d43ce8d16293"
    ]
}

```

| Property | Description|
| ------------------------------ | ------------------------------------------------------------ |
| *principalId*| The   user ID                                                |
| *principalIdDisplayName*| The user   display name                                      |
| *roleDefinitionId*| The   role ID for User Access Administrator|
| *delegatedRoleDefinitionIds* | The IDs   for roles that this user can assign to managed identities the customer’s   tenant. In this case Log Analytics Contributor and Contributor. |

### Deploy a policy with remediation

You’ve defined a user with the right permissions. You’re now able to deploy policies with remediation. In your case, you want to enforce monitoring for Azure Key Vault in Lamna Healthcare’s tenant.  The defined user can be used to deploy the Resource Manager template with the appropriate policy definition and policy assignment. You also include a role assignment resource in your Resource Manager template that has a **delegatedManagedIdentityResourceId** property. Role assignments are how access to resources is controlled in Azure:

```powershell
"type": "Microsoft.Authorization/roleAssignments",
            "apiVersion": "2019-04-01-preview",
		…
            "properties": {
                "roleDefinitionId": "",
                "principalType": "",
                "delegatedManagedIdentityResourceId": "",
                "principalId": ""
            }
```

| Property| Description|
| -------------------------------------- | ------------------------------------------------------- |
| *roleDefinitionId*| The   role ID for the user                              |
| *principalType*| Type of   user. For example, service principal.         |
| *delegatedManagedIdentityResourceId* | The   ID of the managed identity in the customer tenant |
| *principalId*| The user   ID|

> [!NOTE]
> Note that apiVersion must be set to 2019-04-01-preview to use the **delegatedManagedIdentityResourceId** property. You can find a detailed example template that deploys a policy definition, a policy assignment, and a role assignment to collect logs and metrics for Azure Key Vault in this [**GitHub repo**](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/policy-enforce-keyvault-monitoring)
