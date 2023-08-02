
Azure Key Vault is a cloud service for securely storing and accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, or cryptographic keys. Key Vault service supports two types of containers: vaults and managed hardware security module (HSM) pools. Vaults support storing software and HSM-backed keys, secrets, and certificates. Managed HSM pools only support HSM-backed keys. See Azure Key Vault REST API overview for complete details.

Here are other important terms:<br>

 -  Tenant: A tenant is the organization that owns and manages a specific instance of Microsoft cloud services. It's most often used to refer to the set of Azure and Microsoft 365 services for an organization.<br>
 -  Vault owner: A vault owner can create a key vault and gain full access and control over it. The vault owner can also set up auditing to log who accesses secrets and keys. Administrators can control the key lifecycle. They can roll to a new version of the key, back it up, and do related tasks.<br>
 -  Vault consumer: A vault consumer can perform actions on the assets inside the key vault when the vault owner grants the consumer access. The available actions depend on the permissions granted.<br>
 -  Managed HSM Administrators: Users who are assigned the Administrator role have complete control over a Managed HSM pool. They can create more role assignments to delegate controlled access to other users.<br>
 -  Managed HSM Crypto Officer/User: Built-in roles that are usually assigned to users or service principle that will perform cryptographic operations using keys in Managed HSM. Crypto User can create new keys, but can't delete keys.<br>
 -  Managed HSM Crypto Service Encryption User: Built-in role that is usually assigned to a service accounts managed service identity (for example, Storage account) for encryption of data at rest with customer managed key.<br>
 -  Resource: A resource is a manageable item that's available through Azure. Common examples are virtual machine, storage account, web app, database, and virtual network. There are many more.<br>
 -  Resource group: A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. You decide how you want to allocate resources to resource groups, based on what makes the most sense for your organization.<br>
 -  Security principle: An Azure security principle is a security identity that user-created apps, services, and automation tools use to access specific Azure resources. Think of it as a "user identity" (username and password or certificate) with a specific role, and tightly controlled permissions. A security principle should only need to do specific things, unlike a general user identity. It improves security if you grant it only the minimum permission level that it needs to perform its management tasks. A security principle used with an application or service is called a service principle.<br>
 -  Azure Active Directory (Azure AD): Azure AD is the Active Directory service for a tenant. Each directory has one or more domains. A directory can have many subscriptions associated with it, but only one tenant.<br>
 -  Azure tenant ID: A tenant ID is a unique way to identify an Azure AD instance within an Azure subscription.<br>
 -  Managed identities: Azure Key Vault provides a way to securely store credentials and other keys and secrets, but your code needs to authenticate to Key Vault to retrieve them. Using a managed identity makes solving this problem simpler by giving Azure services an automatically managed identity in Azure AD. You can use this identity to authenticate to Key Vault or any service that supports Azure AD authentication, without having any credentials in your code.<br>

## Authentication

To do any operations with Key Vault, you first need to authenticate to it. There are three ways to authenticate to Key Vault:

 -  Managed identities for Azure resources: When you deploy an app on a virtual machine in Azure, you can assign an identity to your virtual machine that has access to Key Vault. You can also assign identities to other Azure resources. The benefit of this approach is that the app or service isn't managing the rotation of the first secret. Azure automatically rotates the identity. We recommend this approach as a best practice.<br>
 -  Service principle and certificate: You can use a service principle and an associated certificate that has access to Key Vault. We don't recommend this approach because the application owner or developer must rotate the certificate.
 -  Service principle and secret: Although you can use a service principle and a secret to authenticate to Key Vault, we don't recommend it. It's hard to automatically rotate the bootstrap secret that's used to authenticate to Key Vault.

## Encryption of data in transit

Azure Key Vault enforces Transport Layer Security (TLS) protocol to protect data when it’s traveling between Azure Key vault and clients. Clients negotiate a TLS connection with Azure Key Vault. TLS provides strong authentication, message privacy, and integrity (enabling detection of message tampering, interception, and forgery), interoperability, algorithm flexibility, and ease of deployment and use.

Perfect Forward Secrecy (PFS) protects connections between customers’ client systems and Microsoft cloud services by unique keys. Connections also use RSA-based 2,048-bit encryption key lengths. This combination makes it difficult for someone to intercept and access data that is in transit.

## Key Vault roles

Use the following table to better understand how Key Vault can help to meet the needs of developers and security administrators.<br>

:::image type="content" source="../media/azure-key-vault-roles-1fa07c98-38723f1c.png" alt-text="Screenshot showing Azure Key Vault roles.":::
<br>

Anybody with an Azure subscription can create and use key vaults. Although Key Vault benefits developers and security administrators, it can be implemented and managed by an organization's administrator who manages other Azure services. For example, this administrator can sign in with an Azure subscription, create a vault for the organization in which to store keys, and then be responsible for operational tasks like these:

 -  Create or import a key or secret
 -  Revoke or delete a key or secret
 -  Authorize users or applications to access the key vault, so they can then manage or use its keys and secrets
 -  Configure key usage (for example, sign or encrypt)
 -  Monitor key usage

This administrator then gives developers URIs to call from their applications. This administrator also gives key usage logging information to the security administrator.

:::image type="content" source="../media/azure-key-vault-overview-3f10b2d5.png" alt-text="Screenshot showing an example of Key Vault creation and management.":::


Developers can also manage the keys directly, by using APIs.
