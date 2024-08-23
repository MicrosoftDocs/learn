When using Blob storage, you should consider the following security recommendations:

## Data protection

- Use the Azure Resource Manager deployment model.
- Enable Azure Defender for all of your storage accounts.
- Turn on soft delete for blobs.
- Turn on soft delete for containers.
- Lock storage account to prevent accidental or malicious deletion or configuration changes.
- Store business-critical data in immutable blobs.
- Require secure transfer (HTTPS) to the storage account.
- Limit shared access signature (SAS) tokens to HTTPS connections only.

## Identity and access management

- Use Microsoft Entra ID to authorize access to blob data.
- Keep in mind the principle of least privilege when assigning permissions to a Microsoft Entra ID security principle via Azure RBAC.
- Use a user delegation SAS to grant limited access to blob data to clients.
- Secure your account access keys with Azure Key Vault.
- Regenerate your account keys periodically.
- Disallow Shared Key authorization.
- Keep in mind the principle of least privilege when assigning permissions to a SAS.
- Have a revocation plan in place for any SAS that you issue to clients.
- If a service SAS isn't associated with a stored access policy, then set the expiry time to one hour or less.
- Disable anonymous public read access to containers and blobs.

## Networking

- Configure the minimum required version of Transport Layer Security (TLS) for a storage account.
- Enable the Secure transfer required option on all of your storage accounts.
- Enable firewall rules.
- Allow trusted Microsoft services to access the storage account.
- Use private endpoints.
- Use virtual network service tags.
- Limit network access to specific networks.
- Configure network routing preference.

## Logging and monitoring

- Track how requests are authorized.
- Set up alerts in Azure Monitor.
