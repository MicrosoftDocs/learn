
Microsoft Defender for Cloud Apps encrypts data at rest to protect
against 'out-of-band' attacks (such as accessing underlying storage)
using encryption. This helps ensure that attackers can't easily read or
modify the data.

-   [Microsoft Defender for Cloud Apps data security and privacy](/cloud-app-security/cas-compliance-trust#encryption)

-   [Understand encryption at rest in Azure](/azure/security/fundamentals/encryption-atrest#encryption-at-rest-in-microsoft-cloud-services)

-   [Data at rest double encryption in Azure](/azure/security/fundamentals/encryption-atrest)

**For additional information on Identifying and Protecting Sensitive
Data, see the following:**

-   [**Discover and Protect Sensitive Information**](/defender-cloud-apps/tutorial-dlp)

-   [**Sensitivity Labels**](/defender-cloud-apps/use-case-information-protection)

-   [**Information Protection**](/defender-cloud-apps/use-case-admin-quarantine)

-   [**Microsoft Purview**](/azure/purview/overview)

-   **Sensitive
    [Information](/microsoft-365/compliance/sensitive-information-type-entity-definitions?view=o365-worldwide&preserve-view=true)
    Types**

####  Specify an encryption standard for data at rest and in motion

To help protect data in the cloud, you need to account for the possible
states in which your data can occur and what controls are available for
that state. Best practices for Azure data security and encryption
related to the following data states:

-   **At rest:** This includes all information storage objects,
    containers, and types that exist statically on physical media,
    whether magnetic or optical disk.

-   **In transit:** When data is being transferred between components,
    locations, or programs, it's in transit. Examples are transferred
    over the network, across a service bus (from on-premises to cloud
    and vice-versa, including hybrid connections such as ExpressRoute),
    or during an input/output process.

Azure provides double encryption for data at rest and data in transit.
Double encryption is where two or more independent layers of encryption
are enabled to protect against compromises of any one layer of
encryption. Using two layers of encryption mitigates threats that come
with encrypting data.

### Encryption of data at rest

Data at rest includes information that resides in persistent storage on
physical media, in any digital format. The media can include magnetic or
optical media files, archived data, and data backups. Microsoft Azure
offers a variety of data storage solutions to meet different needs,
including file, disk, blob, and table storage. Microsoft also provides
encryption to protect [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview), [Azure Cosmos DB](/azure/cosmos-db/database-encryption-at-rest),
and Azure Data Lake.

Data encryption at rest is available for services across the software as
a service (SaaS), platform as a service (PaaS), and infrastructure as a
service (IaaS) cloud models. This article summarizes and provides
resources to help you use the Azure encryption options.

### Azure encryption of data at rest models

Azure supports various encryption models, including server-side
encryption that uses service-managed keys, customer-managed keys in Key
Vault, or customer-managed keys on customer-controlled hardware. You can
manage and store keys on-premises or in another secure location with
client-side encryption.

| Client-side encryption | Client-side encryption is performed outside of Azure. It includes:                                                                                                                                                                                                                              |
|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                        | Data is encrypted by an application running in the customer's datacenter or by a service application.                                                                                                                                                                                           |
|                        | Data that is already encrypted when Azure receives it.                                                                                                                                                                                                                                          |
|                        | With client-side encryption, cloud service providers don't have access to the encryption keys and can't decrypt this data. You maintain complete control of the keys.                                                                                                                          |
| Server-side encryption | The three server-side encryption models offer different key management characteristics, which you can choose according to your requirements:                                                                                                                                                    |
|                        | Service-managed keys: Provides a combination of control and convenience with low overhead.                                                                                                                                                                                                      |
|                        | Customer-managed keys: Gives you control over the keys, including Bring Your Own Keys (BYOK) support, or allows you to generate new ones.                                                                                                                                                       |
|                        | Service-managed keys in customer-controlled hardware: Enables you to manage keys in your proprietary repository, outside of Microsoft control. This characteristic is called Host Your Own Key (HYOK). However, the configuration is complex, and most Azure services don't support this model. |



### Encryption of data in transit

Azure offers many mechanisms for keeping data private as it moves from
one location to another.

* **Data-link Layer encryption in Azure** - Whenever Azure Customer traffic moves between datacenters-- outside physical boundaries not controlled by Microsoft (or on behalf of Microsoft)-- a data-link layer encryption method using the IEEE 802.1AE MAC Security Standards (also known as MACsec) is applied from point-to-point across the underlying network hardware. The packets are encrypted and decrypted on the devices before being sent, preventing physical man-in-the-middle or snooping/wiretapping attacks. Because this technology is integrated on the network hardware itself, it provides line rate encryption on the network hardware with no measurable link latency increase. This MACsec encryption is on by default for all Azure traffic traveling within a region or between regions, and no action is required on customers' part to enable.
* **TLS encryption in Azure** - Microsoft gives customers the ability to use Transport Layer Security (TLS) protocol to protect data when it's traveling between the cloud services and customers. Microsoft datacenters negotiate a TLS connection with client systems that connect to Azure services. TLS provides strong authentication, message privacy, and integrity (enabling detection of message tampering, interception, and forgery), interoperability, algorithm flexibility, and ease of deployment and use.
* **Perfect Forward Secrecy (PFS)** - protects connections between customers' client systems and Microsoft cloud services by unique keys. Connections also use RSA-based 2,048-bit encryption key lengths. This combination makes it difficult for someone to intercept and access data that is in transit.
* **Azure Storage transactions** - When you interact with Azure Storage through the Azure portal, all transactions take place over HTTPS. You can also use the Storage REST API over HTTPS to interact with Azure Storage. You can enforce the use of HTTPS when you call the REST APIs to access objects in storage accounts by enabling the secure transfer that's required for the storage account.
* **Shared Access Signatures (SAS)** - can be used to delegate access to Azure Storage objects, include an option to specify that only the HTTPS protocol can be used when you use Shared Access Signatures. This approach ensures that anybody who sends links with SAS tokens uses the proper protocol.
    * SMB 3.0, which used to access Azure Files shares, supports encryption, and it's available in Windows Server 2012 R2, Windows 8, Windows 8.1, and Windows 10. It allows cross-region access and even access on the desktop.
    * Client-side encryption encrypts the data before it's sent to your Azure Storage instance, so that it's encrypted as it travels across the network.
* **SMB encryption over Azure virtual networks** - By using SMB 3.0 in VMs that are running Windows Server 2012 or later, you can make data transfers secure by encrypting data in transit over Azure Virtual Networks. By encrypting data, you help protect against tampering and eavesdropping attacks. Administrators can enable SMB encryption for the entire server, or just specific shares.
    * By default, after SMB encryption is turned on for a share or server, only SMB 3.0 clients are allowed to access the encrypted shares.
* **Point-to-site VPNs** - Point-to-site VPNs allow individual client computers access to an Azure virtual network. The Secure Socket Tunneling Protocol (SSTP) is used to create the VPN tunnel. It can traverse firewalls (the tunnel appears as an HTTPS connection). You can use your own internal public key infrastructure (PKI) root certificate authority (CA) for point-to-site connectivity.
* **Site-to-site VPNs** -You can use a site-to-site VPN gateway connection to connect your on-premises network to an Azure virtual network over an IPsec/IKE (IKEv1 or IKEv2) VPN tunnel. This type of connection requires an on-premises VPN device that has an external-facing public IP address assigned to it.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

### Azure data security and encryption best practices

#### Choose a key management solution

You can use Key Vault to create multiple secure containers, called
vaults. These vaults are backed by HSMs. Vaults help reduce the chances
of accidental loss of security information by centralizing the storage
of application secrets. Key vaults also control and log the access to
anything stored in them. Azure Key Vault can handle requesting and
renewing Transport Layer Security (TLS) certificates. It provides
features for a robust solution for certificate lifecycle management.

**Best practice**: Grant access to users, groups, and applications at a
specific scope.\
**Detail**: Use Azure RBAC predefined roles. For example, to grant
access to a user to manage key vaults, you would assign the predefined
role [Key Vault
Contributor](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles) to
this user at a specific scope. The scope in this case would be a
subscription, a resource group, or just a specific key vault. If the
predefined roles don't fit your needs, you can [define your own
roles](https://docs.microsoft.com/azure/role-based-access-control/custom-roles).

**Best practice**: Control what users have access to.\
**Detail**: Access to a key vault is controlled through two separate
interfaces: the management and data plane. The management plane and data
plane access controls work independently.

**Best practice**: Store certificates in your key vault. Your
certificates are of high value. In the wrong hands, your application's
security or the security of your data can be compromised.\
**Detail**: Azure Resource Manager can securely deploy certificates
stored in Azure Key Vault to Azure VMs when the VMs are deployed. By
setting appropriate access policies for the key vault, you also control
who gets access to your certificate. Another benefit is that you manage
all your certificates in one place in Azure Key Vault. See [Deploy
Certificates to VMs from customer-managed Key
Vault](https://docs.microsoft.com/archive/blogs/kv/updated-deploy-certificates-to-vms-from-customer-managed-key-vault) for
more information.

**Best practice**: Ensure that you can recover a deletion of key vaults
or key vault objects.\
**Detail**: Deletion of key vaults or key vault objects can be
inadvertent or malicious. Enable the soft delete and purge protection
features of Key Vault, particularly for keys used to encrypt data at
rest. Deleting these keys is equivalent to data loss, so you can recover
deleted vaults and vault objects if needed. Practice Key Vault recovery
operations regularly.

#### Manage with secure workstations

Because the vast majority of attacks target the end user, the endpoint
becomes one of the primary points of attack. An attacker who compromises
the endpoint can use the user's credentials to gain access to the
organization's data. Most endpoint attacks take advantage of users'
administrators in their local workstations.

**Best practice**: Use a secure management workstation to protect
sensitive accounts, tasks, and data.\
**Detail**: Use a [privileged access
workstation](https://4sysops.com/archives/understand-the-microsoft-privileged-access-workstation-paw-security-model/) to
reduce the attack surface in workstations. These secure management
workstations can help you mitigate some of these attacks and ensure that
your data is safer.

**Best practice**: Ensure endpoint protection.\
**Detail**: Enforce security policies across all devices used to consume
data, regardless of the data location (cloud or on-premises).

**Protect data at rest**

Organizations that don't enforce data encryption are more exposed to
data-confidentiality issues. For example, unauthorized or rogue users
might steal data in compromised accounts or gain unauthorized access to
data coded in Clear Format. Companies also must prove that they're
diligent and using correct security controls to enhance their data
security to comply with industry regulations.

**Best practice**: Apply disk encryption to help safeguard your data.\
**Detail**: Use [Azure Disk
Encryption](https://docs.microsoft.com/azure/security/fundamentals/azure-disk-encryption-vms-vmss).
It enables IT administrators to encrypt Windows and Linux IaaS VM disks.
Disk Encryption combines the industry-standard Windows BitLocker feature
and the Linux dm-crypt feature to provide volume encryption for the OS
and the data disks.

Azure Storage and Azure SQL Database encrypt data at rest by default,
and many services offer encryption as an option. You can use Azure Key
Vault to maintain control of keys that access and encrypt your data.
See [Azure resource providers encryption model support to learn
more](https://docs.microsoft.com/azure/security/fundamentals/encryption-atrest#azure-resource-providers-encryption-model-support).

**Best practices**: Use encryption to help mitigate risks related to
unauthorized data access.\
**Detail**: Encrypt your drives before you write sensitive data to them.

**Protect data in transit**

Protecting data in transit should be essential for your data protection
strategy. Because data is moving back and forth from many locations, we
generally recommend that you always use SSL/TLS protocols to exchange
data across different locations. In some circumstances, you might want
to isolate the entire communication channel between your on-premises and
cloud infrastructures by using a VPN.

**Best practice**: Secure access from multiple workstations located
on-premises to an Azure virtual network.\
**Detail**: Use a [site-to-site
VPN](https://docs.microsoft.com/azure/vpn-gateway/tutorial-site-to-site-portal).

**Best practice**: Secure access from an individual workstation located
on-premises to an Azure virtual network.\
**Detail**: Use a [point-to-site
VPN](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-point-to-site-classic-azure-portal).

**Best practice**: Move larger data sets over a dedicated high-speed WAN
link.\
**Detail**:
Use [ExpressRoute](/azure/expressroute/expressroute-introduction).
If you choose to use ExpressRoute, you can also encrypt the data at the
application level by using SSL/TLS or other protocols for added
protection.

**Best practice**: Interact with Azure Storage through the Azure
portal.\
**Detail**: All transactions occur via HTTPS. You can also use [Storage
REST
API](https://docs.microsoft.com/rest/api/storageservices/) over
HTTPS to interact with [Azure
Storage](https://azure.microsoft.com/services/storage/).

**Key management with Key Vault**

Without proper protection and management of the keys, encryption is
rendered useless. Key Vault is the Microsoft-recommended solution for
managing and controlling access to encryption keys used by cloud
services. Permissions to access keys can be assigned to services or
users through Azure Active Directory accounts. Key Vault relieves
organizations of configuring, patching, and maintaining hardware
security modules (HSMs) and key management software.

Azure Key Vault helps solve the following problems:

-   **Secrets Management** - Azure Key Vault can be used to Securely
    store and tightly control access to tokens, passwords, certificates,
    API keys, and other secrets

-   **Key Management** - Azure Key Vault can be used as a Key Management
    solution. Azure Key Vault makes it easy to create and control the
    encryption keys used to encrypt your data.

-   **Certificate Management** - Azure Key Vault lets you easily
    provision, manage, and deploy public and private Transport Layer
    Security/Secure Sockets Layer (TLS/SSL) certificates for use with
    Azure and your internal connected resources.

**For additional information on Encryption Standards, see the
following:**

-   [**Azure Encryption
    Overview**](https://docs.microsoft.com/azure/security/fundamentals/encryption-overview)

-   [**Data Encryption Best
    Practices**](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices)

-   [**Protect Sensitive
    Information**](https://docs.microsoft.com/defender-cloud-apps/use-case-proxy-block-session-aad)

