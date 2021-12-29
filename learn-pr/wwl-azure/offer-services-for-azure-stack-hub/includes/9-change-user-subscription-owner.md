Azure Stack Hub operators can use PowerShell to change the billing owner for a user subscription. One reason to change the owner, for example, is to replace a user that leaves your organization.

There are two types of *Owners* that are assigned to a subscription:

 -  **Billing owner**: By default, the billing owner is the user account that gets the subscription from an offer and then owns the billing relationship for that subscription. This account is also an administrator of the subscription. Only one user account can have this designation on a subscription. A billing owner is often an organization or team lead.

You can use the PowerShell cmdlet `Set-AzsUserSubscription` to change the billing owner.

 -  **Owners added through Role Based Access Control (RBAC) roles** \- Additional users can be granted the **Owner** role using role-based access control (RBAC). Any number of additional user accounts can be added as owners to compliment the billing owner. Additional owners are also administrators of the subscription and have all privileges for the subscription, except permission to delete the billing owner.

## Change the billing owner

Run the following script to change the billing owner of a user subscription. The computer that you use to run the script must connect to Azure Stack Hub and run the Azure Stack Hub PowerShell module 1.3.0 or later

In a multi-tenant Azure Stack Hub, the new owner must be in the same directory as the existing owner. Before you can provide ownership of the subscription to a user that's in another directory, you must first invite that user as a guest into your directory.

Replace the following values in the script before it runs:

 -  **$ArmEndpoint**: The Resource Manager endpoint for your environment.
 -  **$TenantId**: Your Tenant ID.
 -  **$SubscriptionId**: Your subscription ID.
 -  **$OwnerUpn**: An account to add as the new billing owner.

```PowerShell
# Set up Azure Stack Hub admin environment
Add-AzEnvironment -ARMEndpoint $ArmEndpoint -Name AzureStack-admin
Add-AzAccount -Environment AzureStack-admin -TenantId $TenantId
# Select admin subscription
$providerSubscriptionId = (Get-AzSubscription -SubscriptionName "Default Provider Subscription").Id
Write-Output "Setting context to the Default Provider Subscription: $providerSubscriptionId"
Set-AzContext -Subscription $providerSubscriptionId
# Change user subscription owner
$ubscription = Get-AzsUserSubscription -SubscriptionId $SubscriptionId
$Subscription.Owner = $OwnerUpn
Set-AzsUserSubscription -InputObject $subscription

```
