
Azure Key Vault helps solve the following problems:

 -  **Secrets management** \- Azure Key Vault can be used to store securely and tightly control access to tokens, passwords, certificates, API keys, and other secrets.
 -  **Key management** \- Azure Key Vault can also be used as a key management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
 -  **Certificate management** \- Azure Key Vault is also a service that lets you easily provision, manage, and deploy public and private Secure Sockets Layer/Transport Layer Security (SSL/TLS) certificates for use with Azure. And your internal connected resources.
 -  **Store secrets backed by hardware security modules** \- The secrets and keys can be protected by software or FIPS 140-2 Level 2 validates HSMs.

    :::image type="content" source="../media/use-azure-key-vault-a9cc1c77.png" alt-text="Using Azure Key Vault.":::


## Why use Azure Key Vault?

## Centralize application secrets

Centralizing the storage of application secrets in Azure Key Vault allows you to control their distribution.

Key Vault dramatically reduces the chances that secrets may be accidentally leaked.

When using Key Vault, application developers no longer need to store security information in their applications. It eliminates the need to make this information part of the code.

For example, an application may need to connect to a database. Instead of storing the connection string in the app codes, store it securely in Key Vault.

Your applications can securely access the information they need by using URIs that allow them to retrieve specific versions of a secret after the application's key or secret is stored in Azure Key Vault.

It happens without having to write custom code to protect any of the secret information.

## Securely store secrets and keys

Secrets and keys are safeguarded by Azure, using industry-standard algorithms, key lengths, and hardware security modules (HSMs).

The HSMs used are Federal Information Processing Standards (FIPS) 140-2 Level 2 validated.

Access to a key vault requires proper authentication and authorization before a caller (user or application) can get access.

Authentication establishes the identity of the caller, while authorization determines the operations that they can do.

Authentication is done via Azure Active Directory. Authorization may be done via role-based access control (RBAC) or Key Vault access policy.

RBAC is used when dealing with the management of the vaults, and a key vault access policy is used when attempting to access data stored in a vault.

Azure Key Vaults may be either software- or hardware-HSM protected.

You can import or generate keys in hardware security modules (HSMs) that never leave the HSM boundary when you require added assurance.

Microsoft uses Thales hardware security modules. You can use Thales tools to move a key from your HSM to Azure Key Vault.

Finally, Azure Key Vault is designed so that Microsoft doesn't see or extract your data.

## Monitor access and use

Once you've created a couple of Key Vaults, you'll want to monitor how and when your keys and secrets are accessed.

You can do it by enabling logging for Key Vault. You can configure Azure Key Vault to:

 -  Archive to a storage account.
 -  Stream to an Event Hubs.
 -  Send the logs to Log Analytics.

You have control over your logs, and you may secure them by restricting access, and you may also delete logs that you no longer need.

## Simplified administration of application secrets

When storing valuable data, you must take several steps. Security information must be secured. It must follow a lifecycle. It must be highly available.

Azure Key Vault simplifies it by:

 -  Removing the need for in-house knowledge of Hardware Security Modules.
 -  Scaling up on short notice to meet your organization's usage spikes.
 -  Replicating the contents of your Key Vault within a region and to a secondary region. It ensures high availability and takes away the need for any action from the administrator to trigger the failover.
 -  Providing standard Azure administration options via the portal, Azure CLI and PowerShell.
 -  Automating specific tasks on certificates that you purchase from Public CAs, such as enrollment and renewal.

Also, Azure Key Vaults allow you to segregate application secrets.

Applications may access only the vault they can access, and they can only do specific operations.

You can create an Azure Key Vault per application and restrict the secrets stored in a Key Vault to a particular application and team of developers.

## Integrate with other Azure services

As a secure store in Azure, Key Vault has been used to simplify scenarios like Azure Disk Encryption, the always encrypted functionality in SQL Server and Azure SQL Database, Azure web apps.

Key Vault itself can integrate with storage accounts, Event Hubs, and log analytics.
