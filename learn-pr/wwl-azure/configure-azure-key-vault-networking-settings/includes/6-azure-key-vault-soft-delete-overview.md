
Key Vault's soft-delete feature allows recovery of the deleted vaults and deleted key vault objects (for example, keys, secrets, certificates), known as soft-delete. Specifically, we address the following scenarios: This safeguard offer the following protections:

 -  Once a secret, key, certificate, or key vault is deleted, it remains recoverable for a configurable period of 7 to 90 calendar days. If no configuration is specified the default recovery period is set to 90 days. This provides users with sufficient time to notice an accidental secret deletion and respond.
 -  Two operations must be made to permanently delete a secret. First a user must delete the object, which puts it into the soft-deleted state. Second, a user must purge the object in the soft-deleted state. The purge operation requires other access policy permissions. These other protections reduce the risk of a user accidentally or maliciously deleting a secret or a key vault.
 -  To purge a secret in the soft-deleted state, a service principle must be granted another "purge" access policy permission. The purge access policy permission isn't granted by default to any service principle including key vault and subscription owners and must be deliberately set. By requiring an elevated access policy permission to purge a soft-deleted secret, it reduces the probability of accidentally deleting a secret.

> [!WARNING]
> If a secret is deleted and the key vault does not have soft-deleted protection, it is deleted permanently. Although users can currently opt out of soft-delete during key vault creation, this ability is deprecated. **In February 2025, Microsoft will enable soft-delete protection on all key vaults, and users will no longer be able to opt out of or turn off soft-delete.** This protects secrets from accidental or malicious deletion by a user.

> [!IMPORTANT]
> When a Key Vault is soft-deleted, services that are integrated with the Key Vault will be deleted. For example: Azure RBAC roles assignments and Event Grid subscriptions. Recovering a soft-deleted Key Vault will not restore these services. They will need to be recreated.

## Supporting interfaces

The soft-delete feature is available through the REST API, the Azure CLI, Azure PowerShell, and .NET/C\# interfaces, and Azure Resource Manager templates.

## Scenarios

Azure Key Vaults are tracked resources, managed by Azure Resource Manager. Azure Resource Manager also specifies a well-defined behavior for deletion, which requires that a successful DELETE operation must result in that resource not being accessible anymore. The soft-delete feature addresses the recovery of the deleted object, whether the deletion was accidental or intentional.

1.  In the typical scenario, a user may have inadvertently deleted a key vault or a key vault object; if that key vault or key vault object were to be recoverable for a predetermined period, the user may undo the deletion and recover their data.<br>
2.  In a different scenario, a rogue user may attempt to delete a key vault or a key vault object, such as a key inside a vault, to cause a business disruption. Separating the deletion of the key vault or key vault object from the actual deletion of the underlying data can be used as a safety measure by, for instance, restricting permissions on data deletion to a different, trusted role. This approach effectively requires quorum for an operation, which might otherwise result in an immediate data loss.

## Soft-delete behavior

When soft-delete is enable, resources marked as deleted resources are retained for a specified period (90 days by default). The service further provides a mechanism for recovering the deleted object, essentially undoing the deletion.

When creating a new key vault, soft-delete is on by default. Once soft-delete is enable on a key vault it can't be disabled.<br>

The retention policy interval can only be configured during key vault creation and can't be changed afterwards. You have the option to set it anywhere from 7 to 90 days, with 90 days being the default. The same interval applies to both soft-delete and the purge protection retention policy.<br>

You can't reuse the name of a key vault that has been soft-deleted until the retention period has passed.

## Purge protection

Purge protection is an optional Key Vault behavior and isn't enabled by default. Purge protection can only be enabled once soft-delete is enable. It can be turned on via CLI or PowerShell. Purge protection is recommended when using keys for encryption to prevent data loss. Most Azure services that integrate with Azure Key Vault, such as Storage, require purge protection to prevent data loss.

When purge protection is on, a vault or an object in the deleted state can't be purged until the retention period has passed. Soft-deleted vaults and objects can still be recovered, ensuring that the retention policy will be followed.<br>

The default retention period is 90 days, but it's possible to set the retention policy interval to a value from 7 to 90 days through the Azure portal. Once the retention policy interval is set and saved, it can't be changed for that vault.

## Permitted purge

Permanently deleting, purging, a key vault is possible via a POST operation on the proxy resource and requires special privileges. Generally, only the subscription owner is able to purge a key vault. The POST operation triggers the immediate and irrecoverable deletion of that vault.

Exceptions are:<br>

 -  When the Azure subscription has been marked as undeletable. In this case, only the service may then perform the actual deletion, and does so as a scheduled process.<br>
 -  When the enable purge protection argument is enabled on the vault itself. In this case, Key Vault waits for 90 days from when the original secret object was marked for deletion to permanently delete the object.

## Key vault recovery

When a key vault is deleted, the service creates a proxy resource under the subscription, adding sufficient metadata for recovery. The proxy resource is a stored object, available in the same location as the deleted key vault.

## Key vault object recovery

Upon deleting a key vault object, such as a key, the service places the object in a deleted state, making it inaccessible to any retrieval operations. While in this state, the key vault object can only be listed, recovered, or forcefully/permanently deleted. To view the objects, use the Azure CLI az keyvault key list-deleted command (as documented in How to use Key Vault soft-delete with CLI), or the Azure PowerShell Get-AzKeyVault -InRemovedState command (as described in How to use Key Vault soft-delete with PowerShell).

At the same time, Key Vault will schedule the deletion of the underlying data corresponding to the deleted key vault or key vault object for execution after a predetermined retention interval. The DNS record corresponding to the vault is also retained during the retention interval.

## Soft-delete retention period

Soft-deleted resources are retained for a set period of time, 90 days. During the, soft-delete retention interval, the following apply:

 -  You may list all of the key vaults and key vault objects in the soft-delete state for your subscription as well as access deletion and recovery information about them.<br>
     -  Only users with special permissions can list deleted vaults. We recommend that our users create a custom role with these special permissions for handling deleted vaults.
 -  A key vault with the same name can't be created in the same location; correspondingly, a key vault object can't be created in a given vault if that key vault contains an object with the same name and which is in a deleted state.
 -  Only a specifically privileged user may restore a key vault or key vault object by issuing a recover command on the corresponding proxy resource.
     -  The user, member of the custom role, who has the privilege to create a key vault under the resource group can restore the vault.
 -  Only a privileged user may forcibly delete a key vault or key vault object by issuing a delete command on the corresponding proxy resource.

Unless a key vault or key vault object is recovered, at the end of the retention interval the service performs a purge of the soft-deleted key vault or key vault object and its content. Resource deletion may not be rescheduled.

## Billing implications

In general, when an object (a key vault or a key or a secret) is in deleted state, there are only two operations possible: 'purge' and 'recover'. All the other operations fail. Therefore, even though the object exists, no operations can be performed and hence no usage will occur, so no bill. However there are following exceptions:

'purge' and 'recover' actions count towards normal key vault operations and will be billed.<br>

If the object is an HSM-key, the 'HSM Protected key' charge per key version per month charge applies if a key version has been used in last 30 days. After that, since the object is in deleted state no operations can be performed against it, so no charge will apply.

## Soft-delete on by default

If a secret is deleted and the key vault doesn't have soft-deleted protection, it's eleted permanently. Although users can currently opt out of soft-delete during key vault creation, this ability is deprecated. In February 2025, Microsoft enables soft-delete protection on all key vaults, and users will no longer be able to opt out of or turn off soft-delete. This will protect secrets from accidental or malicious deletion by a user.

## Can my application work with soft-delete enabled?

Key vault names are globally unique. The names of secrets stored in a key vault are also unique. You won't be able to reuse the name of a key vault or key vault object that exists in the soft-deleted state.

For example, if your application programmatically creates a key vault named "Vault A" and later deletes "Vault A," the key vault is moved to the soft-deleted state. Your application won't be able to re-create another key vault named "Vault A" until the key vault is purged from the soft-deleted state.

Also, if your application creates a key named test key-in "Vault A" and later deletes that key, your application won't be able to create a new key named test key-in "Vault A" until the test key object is purged from the soft-deleted state.

Attempting to delete a key vault object and re-create it with the same name without purging it from the soft-deleted state first can cause conflict errors. These errors might cause your applications or automation to fail. Consult your dev team before you make the following required application and administration changes.

### Application changes

If your application assumes that soft-delete isn't enabled and expects that deleted secret or key vault names are available for immediate reuse, you need to make the following changes to your application logic.

1.  Delete the original key vault or secret.
2.  Purge the key vault or secret in the soft-deleted state.
3.  Wait for the purge to complete. Immediate re-creation might result in a conflict.
4.  Re-create the key vault with the same name.
5.  If the create operation still results in a name conflict error, try re-creating the key vault again. Azure DNS records might take up to 10 minutes to update in the worst-case scenario.

### Administration changes

Security principles that need access to permanently delete secrets must be granted more access policy permissions to purge these secrets and the key vault.

Disable any Azure Policy assignments on your key vaults that mandates that soft-delete is turn off. You might need to escalate this issue to an administrator who controls Azure Policy assignments applied to your environment. If this policy assignment isn't disabled, you might lose the ability to create new key vaults in the scope of the applied policy assignment.<br>

If your organization is subject to legal compliance requirements and can't allow deleted key vaults and secrets to remain in a recoverable state for an extended period of time, you have to adjust the retention period of soft-delete to meet your organization's standards. You can configure the retention period to last from 7 to 90 days.
