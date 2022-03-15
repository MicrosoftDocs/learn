You always want to make sure you can back up keys, certificates, and even secrets from your Key Vault if there is an emergency. There are two primary features to do this:

 -  Azure Key Vault Soft-delete
 -  Key Vault Backup

## Key vault soft-delete

This diagram shows how the process flow of deleting a key with and without soft-delete protection.

:::image type="content" source="../media/az500-key-vault-soft-delete-a123d365.png" alt-text="Diagram of the soft delete flow in Key Vault.  Left side, no Soft Delete - Key is deleted and no recovery option exists.  Right side, Soft Delete enabled - Key is deleted and goes to deleted state, but not purged.  User can recover or purge the key from this point.":::


When a secret is deleted from a key vault without soft-delete protection, the secret is permanently deleted. Users can currently opt out of soft-delete during key vault creation. However, Microsoft will soon enable soft-delete protection on all key vaults to protect secrets from accidental or malicious deletion by a user. Users will no longer be able to opt out of or turn off soft-delete.

## Key vault backup

The screenshot shows how to download a backup of a primary key. Similar process can be used to back up other items in Key Vault.

:::image type="content" source="../media/az500-key-vault-backup-key-1267e766.png" alt-text="Screenshot of the Key Vault - backup a key page.  Users select an existing key and then choose Download Backup, to create the backup.":::


You can back up secrets, keys, and certificates stored in your key vault. A backup is intended to provide you with an offline copy of all your secrets in the unlikely event that you lose access to your key vault.

> [!NOTE]
> There is currently no way to make a backup of your entire Key Vault Instance
