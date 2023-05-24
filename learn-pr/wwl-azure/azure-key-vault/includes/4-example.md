In this example, we're developing an application that uses a certificate for SSL, Azure Storage to store data, and an RSA 2,048-bit key for sign operations. Our application runs in an Azure virtual machine (VM) (or a virtual machine scale set). We can use a key vault to store the application secrets. We can store the bootstrap certificate that's used by the application to authenticate with Azure AD.

We need access to the following stored keys and secrets:

 -  **SSL certificate** \- Used for SSL.
 -  **Storage key** \- Used to access the Storage account.
 -  **RSA 2,048-bit key** \- Used for sign operations.
 -  **Bootstrap certificate** \- Used to authenticate with Azure AD. After access is granted, we can fetch the storage key and use the RSA key for signing.

We need to define the following roles to specify who can manage, deploy, and audit our application:

 -  **Security team** \- IT staff from the office of the CSO (Chief Security Officer) or similar contributors. The security team is responsible for the proper safekeeping of secrets. The secrets can include SSL certificates, RSA keys for signing, connection strings, and storage account keys.
 -  **Developers and operators** \- The staff who develop the application and deploy it in Azure. The members of this team aren't part of the security staff. They shouldn't have access to sensitive data like SSL certificates and RSA keys. Only the application that they deploy should have access to sensitive data.
 -  **Auditors** \- This role is for contributors who aren't members of the development or general IT staff. They review the use and maintenance of certificates, keys, and secrets to ensure compliance with security standards.

There is another role that is outside the scope of our application: the **subscription (or resource group) administrator**. The subscription admin sets up initial access permissions for the security team. They grant access to the security team by using a resource group that has the resources required by the application.

### Security team

 -  Create key vaults.
 -  Turn on Key Vault logging.
 -  Add keys and secrets.
 -  Create backups of keys for disaster recovery.
 -  Set Key Vault access policies to grant permissions to users and applications for specific operations.
 -  Roll the keys and secrets periodically.

### Developers and operators

 -  Get references from the security team for the bootstrap and SSL certificates (thumbprints), storage key (secret URI), and RSA key (key URI) for signing.
 -  Develop and deploy the application to access keys and secrets programmatically.

### Auditors

 -  Review the Key Vault logs to confirm proper use of keys and secrets, and compliance with data security standards.

The following table summarizes the access permissions for our roles and application.

| **Role**                 | **Management plane permissions**                                                                             | **Data plane permissions**                                                                                                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Security team            | Key Vault Contributor                                                                                        | Keys: backup, create, delete, get, import, list, restore. Secrets: all operations                                                                                                   |
| Developers and operators | Key Vault deploy permission **Note**: This permission allows deployed VMs to fetch secrets from a key vault. | None                                                                                                                                                                                |
| Auditors                 | None                                                                                                         | Keys: list Secrets: list. **Note**: This permission enables auditors to inspect attributes (tags, activation dates, expiration dates) for keys and secrets not emitted in the logs. |
| Application              | None                                                                                                         | Keys: sign Secrets: get                                                                                                                                                             |

The three team roles need access to other resources along with Key Vault permissions. To deploy VMs (or the Web Apps feature of Azure App Service), developers and operators need Contributor access to those resource types. Auditors need read access to the Storage account where the Key Vault logs are stored.
