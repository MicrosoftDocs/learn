You’ve seen how Relecloud monitors its customer tenants in a centralized and scalable way. Because Relecloud has onboarded multiple customers with Azure delegated resource management, the company wants to ensure it stays compliant with all corporate standards and service level agreements. You’ll investigate how Relecloud can help ensure compliance by using Azure Policy. Finally, you’ll explore how Relecloud can deploy policies to customer tenants at scale, and how to use policies with remediation tasks in a customer tenant, to remediate non-compliance.

## Deploy a policy for multiple tenants

One of the services you provide at Relecloud is managing storage accounts for your customers. You want to ensure that all storage accounts use HTTPS for traffic. You need to know if there are any customer storage accounts that aren’t using HTTPS. You can use the Azure Resource Graph to run a query and search for any storage accounts that don’t require traffic through HTTPS. Use Azure PowerShell to run the following query through the Azure Resource Graph:

```azurepowershell
$RelecloudTenant = "insert your managing tenantId here"

$subs = Get-AzSubscription

$ManagedSubscriptions = Search-AzGraph -Query "ResourceContainers | where type == 'microsoft.resources/subscriptions' | where tenantId != '$($RelecloudTenant)' | project name, subscriptionId, tenantId" -subscription $subs.subscriptionId

Search-AzGraph -Query "Resources | where type =~ 'Microsoft.Storage/storageAccounts' | project name, location, subscriptionId, tenantId, properties.supportsHttpsTrafficOnly" -subscription $ManagedSubscriptions.subscriptionId | convertto-json
```

This query returns a list of storage accounts that don’t require HTTPS for all traffic.

When you've deployed your template, you’ll confirm that the policy was successfully applied across tenants. To test the policy, you'll try to create a storage account that has the **EnableHttpsTrafficOnly** setting set to **False** in one of the customer subscriptions, such as Lamna Healthcare. If the policy has been applied successfully, you can't create the storage account.

You can deploy policies across delegated subscriptions in multiple customer tenants. You want to deploy a single policy that ensures:

- All storage accounts in customer subscriptions only use HTTPS
- Storage accounts that don’t use HTTPS can’t be created
- Any storage accounts that aren't set to HTTPS will be marked as noncompliant

You define the policy by creating a policy definition and a policy assignment in an [Azure Resource Manager template](https://github.com/Azure/Azure-Lighthouse-samples/blob/master/templates/policy-enforce-https-storage/enforceHttpsStorage.json). The template allows you to deploy the policy at scale. You can use tools like Azure PowerShell and Azure CLI to deploy the template across all customer subscriptions. Use the following snippet of Azure PowerShell code to iterate through all customer subscriptions and deploy the template to each one:

```azurepowershell
foreach ($ManagedSub in $ManagedSubscriptions)
{
    Select-AzSubscription -SubscriptionId $ManagedSub.subscriptionId

    New-AzSubscriptionDeployment -Name mgmt `
                     -Location eastus `
                     -TemplateUri "URL-for-template.json" `
                     -AsJob
}
```

When you've deployed your template, you'll confirm that the policy was successfully applied across tenants. To do this, you test the policy by trying to create a storage account that has the **EnableHttpsTrafficOnly** setting set to **False** in one of the customer subscriptions, such as Lamna Healthcare. You can use Azure PowerShell to run a command to create a new storage account, like this:

```azurepowershell
New-AzStorageAccount -ResourceGroupName (New-AzResourceGroup -name policy-test -Location eastus -Force).ResourceGroupName `
                     -Name (get-random) `
                     -Location eastus `
                     -EnableHttpsTrafficOnly $false `
                     -SkuName Standard_LRS `
                     -Verbose
```

If the policy has been applied successfully, you won't be able to create the storage account.

## Deploy a policy to remediate noncompliance

You want to make sure that all customer resources are compliant, and fix noncompliance if it occurs for Lamna Healthcare or any other customer. You can create policies that have remediation tasks included to remediate noncompliance.

### Define a user to assign roles to managed identities

You'll need to create a managed identity in a customer tenant, like Lamna Healthcare, to deploy policies with remediation to them. To onboard new customers with Azure Lighthouse, you'll have defined users and permissions that you and other Relecloud users will use to manage customer resources and subscriptions.

To enable any of your users to create a managed identity in a customer tenant, the user’s **roleDefinitionId** needs to be set to **User Access Administrator** in the Azure Resource Manager template used for onboarding. The user won’t have the permissions associated with the User Access Administrator role, but it can assign certain built-in roles to managed identities after the customer is onboarded.

You can include these roles in the **delegatedRoleDefinitionIds** property for this user in the template. You can define this user in the template in the following way:

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
| *principalId*| The user ID                                                |
| *principalIdDisplayName*| The user display name                                      |
| *roleDefinitionId*| The role ID for User Access Administrator|
| *delegatedRoleDefinitionIds* | The IDs for roles that this user can assign to managed identities in the customer's tenant. In this case, Log Analytics Contributor and Contributor. |

### Deploy a policy with remediation

You've defined a user with the correct permissions, and you can now deploy policies with remediation. You want to enforce monitoring for Azure Key Vault in Lamna Healthcare’s tenant. You can use the defined user to deploy the Resource Manager template with the appropriate policy definition and policy assignment. You can also include a role assignment resource in your Resource Manager template that has a **delegatedManagedIdentityResourceId** property. Role assignments are how access to resources is controlled in Azure:

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
| *roleDefinitionId*| The user's role ID                              |
| *principalType*| Type of user; for example, service principal         |
| *delegatedManagedIdentityResourceId* | The ID of the managed identity in the customer tenant |
| *principalId*| The user ID|

> [!NOTE]
> To use the **delegatedManagedIdentityResourceId** property, apiVersion must be set to 2019-04-01-preview. There's a detailed example template that deploys a policy definition, a policy assignment, and a role assignment to collect logs and metrics for Azure Key Vault, in this [**GitHub repo**.](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/policy-enforce-keyvault-monitoring)

As part of the managed services that your company provides, you look after Windows and Linux virtual machines for customers like Lamna Healthcare. Of course, this means you’ll have to make sure that all virtual machines are constantly monitored for issues and insights. You can use a template that ensures Azure Monitor is enforced on all customer virtual machines, and Log Analytics workspaces are created for capturing and analyzing data.

Use the [enforce Azure Monitor using Azure Policy template](https://github.com/Azure/Azure-Lighthouse-samples/tree/master/templates/policy-enforce-sub-monitoring) on GitHub to deploy several policies that will enforce Azure Monitor for all virtual machine resources at a subscription level, and create the workspaces to be used accordingly. Because this is an Azure Resource Manager template, you can deploy it just like you’ve deployed previous templates.
