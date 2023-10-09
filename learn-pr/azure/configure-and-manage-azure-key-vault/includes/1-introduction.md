PetDash is an online pet food delivery company that provides store-to-door service for all their customer's pet needs. They take online orders, store credit cards and personal details in their SQL database, and have a secure website running on Azure App Service to interact with customers. They've been in business a little over a year and Steve, one of the website admins, noticed that their website certificate for the **petdash.com** domain has expired. Steve quickly renews the certificate and gets it installed on the server, and begins to explore ways to ensure that this problem never happens again. The investigation reveals that Azure Key Vault supports certificate management. Even better, Key Vault can communicate with App Service to provide the certification _and_ renew it automatically if necessary.

**Azure Key Vault** helps safeguard cryptographic keys and secrets that cloud applications and services use. Key Vault streamlines the key management process and enables you to maintain control of keys that access and encrypt your data. Developers can create keys for development and testing in minutes, and then migrate them to production keys. Security administrators can grant (and revoke) permission to keys, as needed.

## Learning objectives

In this module, you will:

- Explore proper usage of Azure Key Vault.
- Manage access to an Azure Key Vault.
- Explore certificate management with Azure Key Vault.
- Configure a Hardware Security Module Key-generation solution.
