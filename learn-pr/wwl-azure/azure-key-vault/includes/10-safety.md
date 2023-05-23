
Key Vault's soft-delete feature allows recovery of the deleted vaults and deleted key vault objects (for example, keys, secrets, certificates), known as soft-delete. Specifically, we address the following scenarios: This safeguard offer the following protections:

 -  Once a secret, key, certificate, or key vault is deleted, it will remain recoverable for a configurable period of 7 to 90 calendar days. If no configuration is specified the default recovery period will be set to 90 days. This provides users with sufficient time to notice an accidental secret deletion and respond.
 -  Two operations must be made to permanently delete a secret. First a user must delete the object, which puts it into the soft-deleted state. Second, a user must purge the object in the soft-deleted state. The purge operation requires additional access policy permissions. These additional protections reduce the risk of a user accidentally or maliciously deleting a secret or a key vault.
 -  To purge a secret in the soft-deleted state, a service principal must be granted an additional "purge" access policy permission. The purge access policy permission is not granted by default to any service principal including key vault and subscription owners and must be deliberately set. By requiring an elevated access policy permission to purge a soft-deleted secret, it reduces the probability of accidentally deleting a secret.

## Supporting interfaces

The soft-delete feature is available through the REST API, the Azure CLI, Azure powerShell, .NET/C\# interfaces, and ARM templates.

## Scenarios

Azure Key Vaults are tracked resources, managed by Azure Resource Manager. Azure Resource Manager also specifies a well-defined behavior for deletion, which requires that a successful DELETE operation must result in that resource not being accessible anymore. The soft-delete feature addresses the recovery of the deleted object, whether the deletion was accidental or intentional.

1.  In the typical scenario, a user may have inadvertently deleted a key vault or a key vault object; if that key vault or key vault object were to be recoverable for a predetermined period, the user may undo the deletion and recover their data.
2.  In a different scenario, a rogue user may attempt to delete a key vault or a key vault object, such as a key inside a vault, to cause a business disruption. Separating the deletion of the key vault or key vault object from the actual deletion of the underlying data can be used as a safety measure by, for instance, restricting permissions on data deletion to a different, trusted role. This approach effectively requires quorum for an operation which might otherwise result in an immediate data loss.

## Soft-delete behavior

When soft-delete is enabled, resources marked as deleted resources are retained for a specified period (90 days by default). The service further provides a mechanism for recovering the deleted object, essentially undoing the deletion.

When creating a new key vault, soft-delete is on by default. Once soft-delete is enabled on a key vault it cannot be disabled.

The default retention period is 90 days but, during key vault creation, it is possible to set the retention policy interval to a value from 7 to 90 days through the Azure portal. The purge protection retention policy uses the same interval. Once set, the retention policy interval cannot be changed.

You cannot reuse the name of a key vault that has been soft-deleted until the retention period has passed.

## Purge protection

Permanently deleting, purging, a key vault is possible via a POST operation on the proxy resource and requires special privileges. Generally, only the subscription owner will be able to purge a key vault. The POST operation triggers the immediate and irrecoverable deletion of that vault.

Exceptions are:

 -  When the Azure subscription has been marked as *undeletable*. In this case, only the service may then perform the actual deletion, and does so as a scheduled process.
 -  When the --enable-purge-protection argument is enabled on the vault itself. In this case, Key Vault will wait for 90 days from when the original secret object was marked for deletion to permanently delete the object.

## Key vault recovery

Upon deleting a key vault object, such as a key, the service will place the object in a deleted state, making it inaccessible to any retrieval operations. While in this state, the key vault object can only be listed, recovered, or forcefully/permanently deleted. To view the objects, use the Azure CLI az keyvault key list-deleted command, or the Azure PowerShell Get-AzKeyVault -InRemovedState command.

At the same time, Key Vault will schedule the deletion of the underlying data corresponding to the deleted key vault or key vault object for execution after a predetermined retention interval. The DNS record corresponding to the vault is also retained for the duration of the retention interval.

## Soft-delete retention period

Soft-deleted resources are retained for a set period of time, 90 days. During the soft-delete retention interval, the following apply:

 -  You may list all of the key vaults and key vault objects in the soft-delete state for your subscription as well as access deletion and recovery information about them.
     -  Only users with special permissions can list deleted vaults. We recommend that our users create a custom role with these special permissions for handling deleted vaults.
 -  A key vault with the same name cannot be created in the same location; correspondingly, a key vault object cannot be created in a given vault if that key vault contains an object with the same name and which is in a deleted state.
 -  Only a specifically privileged user may restore a key vault or key vault object by issuing a recover command on the corresponding proxy resource.
     -  The user, member of the custom role, who has the privilege to create a key vault under the resource group can restore the vault.
 -  Only a specifically privileged user may forcibly delete a key vault or key vault object by issuing a delete command on the corresponding proxy resource.

Unless a key vault or key vault object is recovered, at the end of the retention interval the service performs a purge of the soft-deleted key vault or key vault object and its content. Resource deletion may not be rescheduled.

## Billing implications

In general, when an object (a key vault or a key or a secret) is in deleted state, there are only two operations possible: 'purge' and 'recover'. All the other operations will fail. Therefore, even though the object exists, no operations can be performed and hence no usage will occur, so no bill. However there are following exceptions:

 -  'purge' and 'recover' actions will count towards normal key vault operations and will be billed.
 -  If the object is an HSM-key, the 'HSM Protected key' charge per key version per month charge will apply if a key version has been used in last 30 days. After that, since the object is in deleted state no operations can be performed against it, so no charge will apply.

## Key vault soft-delete on by default<br>

If a secret is deleted and the key vault does not have soft-delete protection, it is deleted permanently. Although users can currently opt out of soft-delete during key vault creation, this ability is deprecated. In February 2025, Microsoft will enable soft-delete protection on all key vaults, and users will no longer be able to opt out of or turn off soft-delete. This will protect secrets from accidental or malicious deletion by a user.

This diagram shows how the process flow of deleting a key with and without soft-delete protection.

:::image type="content" source="../media/az500-key-vault-soft-delete-a123d365.png" alt-text="Diagram of the soft delete flow in Key Vault.  Left side, no Soft Delete - Key is deleted and no recovery option exists.  Right side, Soft Delete enabled - Key is deleted and goes to deleted state, but not purged.  User can recover or purge the key from this point.":::


When a secret is deleted from a key vault without soft-delete protection, the secret is permanently deleted. Users can currently opt out of soft-delete during key vault creation. However, Microsoft will soon enable soft-delete protection on all key vaults to protect secrets from accidental or malicious deletion by a user. Users will no longer be able to opt out of or turn off soft-delete.

## Key vault backup

Azure Key Vault automatically provides features to help you maintain availability and prevent data loss. Back up secrets only if you have a critical business justification. Backing up secrets in your key vault may introduce operational challenges such as maintaining multiple sets of logs, permissions, and backups when secrets expire or rotate.

Key Vault maintains availability in disaster scenarios and will automatically fail over requests to a paired region without any intervention from a user.

If you want protection against accidental or malicious deletion of your secrets, configure soft-delete and purge protection features on your key vault.

## Limitations

> [!IMPORTANT]
> Key Vault does not support the ability to backup more than 500 past versions of a key, secret, or certificate object. Attempting to backup a key, secret, or certificate object may result in an error. It is not possible to delete previous versions of a key, secret, or certificate.

Key Vault doesn't currently provide a way to back up an entire key vault in a single operation. Any attempt to use the commands listed in this document to do an automated backup of a key vault may result in errors and won't be supported by Microsoft or the Azure Key Vault team.

Also consider the following consequences:

 -  Backing up secrets that have multiple versions might cause time-out errors.
 -  A backup creates a point-in-time snapshot. Secrets might renew during a backup, causing a mismatch of encryption keys.
 -  If you exceed key vault service limits for requests per second, your key vault will be throttled, and the backup will fail.

## Design considerations

When you back up a key vault object, such as a secret, key, or certificate, the backup operation will download the object as an encrypted blob. This blob can't be decrypted outside of Azure. **To get usable data from this blob, you must restore the blob into a key vault within the same Azure subscription and Azure geography**.

## Prerequisites

To back up a key vault object, you must have:

 -  Contributor-level or higher permissions on an Azure subscription.
 -  A primary key vault that contains the secrets you want to back up.
 -  A secondary key vault where secrets will be restored.

## Back up and restore from the Azure portal

### Back up

1. Navigate to the Azure portal.

2. Select your key vault.

3. Navigate to the key you want to back up.

### :::image type="content" source="../media/azure-key-vault-key-entry-list-example-100d7123.png" alt-text="Screenshot showing a Key Vault entry."::: 

4. Select the object

5. Select **Download Back up**

:::image type="content" source="../media/azure-portal-key-vault-download-back-up-example-04bb8301.png" alt-text="Screenshot showing Key Vault download back up control.":::


6. Select **Download**

:::image type="content" source="../media/azure-portal-creating-an-azure-key-vault-backup-example-032c52d7.png" alt-text="Screenshot showing creating a back up procedure and control operation.":::


7. Store the encrypted blob in a secure location.

### Restore

1. Navigate to the Azure portal.

2. Select your key vault.

3. Navigate to the key you want to restore.

## :::image type="content" source="../media/azure-key-vault-restore-back-up-control-example-244106f1.png" alt-text="Screenshot showing Key Vault restore back up control."::: 

5. Navigate to the location where you stored the encrypted blob.

6. Select **OK**.
