Azure Key Vault automatically provides features to help you maintain availability and prevent data loss. Back up secrets only if you have a critical business justification. Backing up secrets in your key vault may introduce operational challenges such as maintaining multiple sets of logs, permissions, and backups when secrets expire or rotate.

Key Vault maintains availability in disaster scenarios and will automatically fail over requests to a paired region without any intervention from a user.

If you want protection against accidental or malicious deletion of your secrets, configure soft-delete and purge protection features on your key vault.

Key Vault doesn't currently provide a way to back up an entire key vault in a single operation. Any attempt to use the commands listed in this document to do an automated backup of a key vault may result in errors and won't be supported by Microsoft or the Azure Key Vault team.

Also consider the following consequences:

 -  Backing up secrets that have multiple versions might cause time-out errors.
 -  A backup creates a point-in-time snapshot. Secrets might renew during a backup, causing a mismatch of encryption keys.
 -  If you exceed key vault service limits for requests per second, your key vault will be throttled, and the backup will fail.

## Design considerations

When you back up a key vault object, such as a secret, key, or certificate, the backup operation will download the object as an encrypted blob. This blob can't be decrypted outside of Azure. To get usable data from this blob, you must restore the blob into a key vault within the same Azure subscription and Azure geography.

## Prerequisites

To back up a key vault object, you must have:

 -  Contributor-level or higher permissions on an Azure subscription.
 -  A primary key vault that contains the secrets you want to back up.
 -  A secondary key vault where secrets will be restored.

## Back up and restore from the Azure portal

Follow the steps in this section to back up and restore objects by using the Azure portal.

## Back up

1.  Go to the [Azure portal](https://portal.azure.com/).
2.  Select your key vault.<br>
3.  Go to the object (secret, key, or certificate) you want to back up.
4.  Select the object.<br>
5.  Select **Download Backup**.
6.  Select **Download**.<br>
7.  Store the encrypted blob in a secure location.<br>

## Restore

1.  Go to the [Azure portal](https://portal.azure.com/).
2.  Select your key vault.
3.  Go to the type of object (secret, key, or certificate) you want to restore.
4.  Select **Restore Backup**.
5.  Go to the location where you stored the encrypted blob.<br>
6.  Select **OK**.
