Direct storage and handling of secrets, encryption keys, and certificates is risky. Every usage introduces the possibility of unintentional data exposure. Azure Key Vault provides a secure storage area so you can manage all your app secrets and properly encrypt your data in transit or while it's being stored. 

Azure Key Vault can help you solve security problems for Tailwind Traders:

- **Manage secrets**. You can securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets.

- **Manage keys**. Key Vault is a key management solution that lets you easily create and control encryption keys to encrypt corporate data.

- **Manage certificates**. Key Vault is also a service that makes it easy to enroll, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and internal connected resources.

### Things to know about Azure Key Vault

As CTO for Tailwind Traders, you'd like to know how Azure Key Vault can enhance your current strategy. Consider these characteristics of Key Vault:

- Key Vault is available in two service tiers:
   - **Standard tier** lets you encrypt your data with a software key.
   - **Premium tier** offers hardware security module (HSM)-protected keys.

- You can build access policies with restricted secret access that are tailored to the apps and individuals that need them.

- Sensitive app information can be separated from other configuration and code, which reduces the risk of accidental leaks.

- Centralized secret storage allows required changes to happen in only one place.

- Logging and monitoring in Key Vault helps you understand how and when secrets are accessed.

- Key Vault provides secure access to sensitive information from within your apps:
   - Keys, secrets, and certificates are protected without writing extra code, and you can use these assets from your apps.
   - Customers can own and manage their own keys, secrets, and certificates. Your apps don't own the responsibility or potential liability for customer assets. You can concentrate on providing the core software features for Tailwind Traders apps. 
   - Your app can use keys for signing and encryption while keeping key management external from the app. 
   - You can manage credentials like passwords, access keys, and shared access signature tokens by storing them in Key Vault as secrets. 

### Things to consider when using Azure Key Vault

You're on your last step in planning how to implement authentication and authorization for Tailwind Traders. Consider how Azure Key Vault can be used to manage user passwords, certificates, API keys, and other secrets.

- **Consider using separate key vaults**. Key vaults define security boundaries for stored secrets. Grouping secrets into the same vault increases the *blast radius* of a security event. Consider what secrets a specific application should have access to, and then separate your key vaults based on this delineation. Separating key vaults by application is the most common boundary. 

- **Consider access to the key vault**. Secure access to your key vaults by allowing only authorized applications and users. Here are some suggestions. 

   - Create access policies for every vault.
   - Use the principle of least privilege access to grant access.
   - Turn on firewall and virtual network service endpoints.


- **Consider data protection for your key vault**. Turn on [soft delete and purge protection](/azure/key-vault/general/key-vault-recovery?tabs=azure-portal#what-are-soft-delete-and-purge-protection) to protect your key vault data.

   - **Soft delete** is designed to prevent accidental deletion of your key vault and keys, secrets, and certificates stored inside key vault. Think of soft-delete like a recycle bin. 
   - **Purge protection** Purge protection is designed to prevent the deletion of your key vault, keys, secrets, and certificates by a malicious insider. Think of this as a recycle bin with a time based lock. You can recover items at any point during the configurable retention period. 

